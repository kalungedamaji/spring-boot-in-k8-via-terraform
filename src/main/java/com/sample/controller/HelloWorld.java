package com.sample.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class HelloWorld {

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


}
