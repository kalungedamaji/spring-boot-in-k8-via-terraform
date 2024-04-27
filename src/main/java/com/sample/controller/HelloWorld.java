package com.sample.controller;

import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class HelloWorld {

  @GetMapping(value = "/hello")
  public String hello() {
    return "Hello, World!";
  }

  @GetMapping(value = "/intercept")
  public ResponseEntity<Map<String, String>>  intercept(@RequestHeader Map<String, String> headers) {

    // Log the request headers
    headers.forEach((key, value) -> System.out.println(key + ": " + value));

    RestTemplate restTemplate = new RestTemplate();
    String helloResourceUrl
            = "http://hello-world-service-example:8081/hello";
    ResponseEntity<String> response
            = restTemplate.getForEntity(helloResourceUrl , String.class);
        // publish message to queue
    return ResponseEntity.ok(headers);
  }


}
