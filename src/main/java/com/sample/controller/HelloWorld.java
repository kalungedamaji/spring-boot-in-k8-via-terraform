package com.sample.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class HelloWorld {
  private static final Logger logger = LoggerFactory.getLogger(HelloWorld.class);

  @GetMapping(value = "/hello")
  public String hello() {
    return "Hello, World!";
  }

  @GetMapping(value = "/intercept")
  public String intercept() {

    System.out.println("Intercepted");

    RestTemplate restTemplate = new RestTemplate();
    String helloResourceUrl
            = "http://hello-world-service-example:8081/hello";
    ResponseEntity<String> response
            = restTemplate.getForEntity(helloResourceUrl , String.class);
        // publish message to queue
    return response.getBody();
  }

  @PostMapping(value = "/publish")
  public ResponseEntity<Object> publish(@RequestBody Object requestBody){
    logger.info("Received JSON request: {}", requestBody);
    return ResponseEntity.status(HttpStatus.OK).body(requestBody);
  }


}
