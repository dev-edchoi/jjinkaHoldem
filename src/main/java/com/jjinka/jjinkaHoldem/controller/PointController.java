package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.service.PointService;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class PointController {
    private final PointService pointService;

    @GetMapping("/point")
    public String checkPoint() {
        return "checkPoint";
    }

    @PostMapping("/point/checkPoint")
    public @ResponseBody Long checkPoint(@RequestParam("userName") String userName, @RequestParam("phoneNumber") String phoneNumber) {

        Map<String, Object> map = new HashMap<>();
        map.put("userName", userName);
        map.put("phoneNumber", phoneNumber);

        return pointService.checkPoint(map);
    }
}
