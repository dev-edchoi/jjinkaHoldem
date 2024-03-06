package com.jjinka.jjinkaHoldem.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/point")
@RequiredArgsConstructor
public class PointController {

    @GetMapping("/checkPoint")
    public String checkPoint() {
        return "checkPoint";
    }
}
