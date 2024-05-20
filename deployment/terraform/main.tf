resource "kubernetes_namespace" "sample" {
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "sample"
    }

    name = "sample-namespace"
  }
}

resource "kubernetes_replication_controller" "hello_world" {
  metadata {
    name = "scalable-hello-world-example"
    namespace = "${kubernetes_namespace.sample.metadata.0.name}"
    labels = {
      App = "HelloWorldExample"
    }
  }

  spec {
   replicas = 1
   selector = {
     test = "HelloWorldExample"
    }


    template {
      metadata {
       labels = {
       test = "HelloWorldExample"
       }
       }
      spec {
        container {
          image = "dkalunge/spring-boot-in-k8-via-terraform_js:js"
          name  = "hello-service"

          port {
            container_port = 8081
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
        container {
        port {
                container_port = 8080
                }
            name  = "nginx-sidecar"
            image = "dkalunge/audit-event-producer-v90:kt"
      }
    }
  }
  }
  }


# Define the ConfigMap resource to store the elasticmq.conf file
resource "kubernetes_config_map" "elasticmq_config" {
  metadata {
    name      = "elasticmq-config"
    namespace = "${kubernetes_namespace.sample.metadata.0.name}"
  }

  data = {
    "elasticmq.conf" = <<EOF
include classpath("application.conf")

queues {
  audit-events {
    defaultVisibilityTimeout = 30 seconds
    fifo = true
    contentBasedDeduplication = false
    deadLettersQueue {
      name = "audit-events-dlq.fifo"
      maxReceiveCount = 5
    }
  }

  audit-events-dlq {
    fifo = true
  }
}
EOF
  }
}

# Define the Deployment resource
resource "kubernetes_deployment" "queue" {
  metadata {
    name = "elasticmq"
    namespace = "${kubernetes_namespace.sample.metadata.0.name}"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "elasticmq"
      }
    }

    template {
      metadata {
        labels = {
          app = "elasticmq"
        }
      }

      spec {
        container {
          name    = "elasticmq"
          image   = "softwaremill/elasticmq-native:latest"

          # Mount the ConfigMap volume into the container
          volume_mount {
            name       = "config-volume"
            mount_path = "/etc/elasticmq"
            read_only  = true
          }
          # Volume Mount
          volume_mount {
            name       = "queue-volume"
            mount_path = "/mnt/data/queue"  # Adjust the mount path as needed
          }
        }
        # Volume for the ConfigMap
        volume {
          name = "config-volume"
          config_map {
            name = kubernetes_config_map.elasticmq_config.metadata.0.name
          }
        }
        # Volume
        volume {
          name = "queue-volume"
          empty_dir {}
        }
      }

    }
  }
}

# Define the Service resource
resource "kubernetes_service" "queue" {
  metadata {
    name = "elasticmq-service"
    namespace = "${kubernetes_namespace.sample.metadata.0.name}"
  }

  spec {
    selector = {
      app = "elasticmq"
    }

    port {
      name = "pc"
      port        = 9324  # ElasticMQ port
      target_port = 9324
    }

    port {
      name = "health"
      port        = 9325  # ElasticMQ port
      target_port = 9325
    }

    # Define NodePort type for Minikube
    type = "ClusterIP"
  }
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name = "hello-world-service-example"
    namespace = "${kubernetes_namespace.sample.metadata.0.name}"
  }
  spec {
    selector = {
       test = "HelloWorldExample"
    }
    port {
      name        = "ngnix"
      port        = 8080
      target_port = 8080
    }
    port {
         name        = "service"
         port        = 8081
         target_port = 8081
       }
    type = "NodePort"
  }
}