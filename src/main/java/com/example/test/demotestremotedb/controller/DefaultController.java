package com.example.test.demotestremotedb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DefaultController {
    @GetMapping("/")
    public String redirectToMainPage(){
        return "redirect:/products";
    }
}
