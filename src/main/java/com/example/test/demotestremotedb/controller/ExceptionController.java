package com.example.test.demotestremotedb.controller;

import org.springframework.web.bind.annotation.ExceptionHandler;

@org.springframework.web.bind.annotation.ControllerAdvice
public class ExceptionController {

    @ExceptionHandler(Exception.class)
    public String redirectToMainPage(){
        return "redirect:/products";
    }
}
