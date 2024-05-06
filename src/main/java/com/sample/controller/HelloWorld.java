package com.sample.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
    return "Intercepted the request";
  }

  @PostMapping(value = "/publish")
  public ResponseEntity<Object> publish(@RequestBody Object requestBody){
    logger.info("Received JSON request: {}", requestBody);
    return ResponseEntity.status(HttpStatus.OK).body(requestBody);
  }

}
