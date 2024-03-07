package com.jjinka.jjinkaHoldem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
    @GetMapping("/alphaAdmin")
    public String index() {
        return "index";
    }

    @GetMapping("/alphaAdmin/login")
    public String login() {
        return "login";
    }

    @GetMapping("/test")
    public String test() {
        return "test";
    }
}
