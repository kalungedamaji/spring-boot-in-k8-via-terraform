package com.sample.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorld {

  @GetMapping(value = "/hello")
  public String hello() {
    return "Hello, World!";
  }

  @GetMapping(value = "/intercept")
  public String intercept() {
    System.out.println("Intercepted");
    return "Intercepted the request";
  }


}
