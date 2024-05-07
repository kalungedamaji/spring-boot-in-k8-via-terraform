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
            image = "dkalunge/nginx-sidecar_js_80:js"
      }
    }
  }
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