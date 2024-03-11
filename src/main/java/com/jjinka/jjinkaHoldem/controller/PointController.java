package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.service.PointService;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
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
    public @ResponseBody UserDTO checkPoint(@RequestParam("userName") String userName, @RequestParam("phoneNumber") String phoneNumber) {
        Map<String, Object> map = new HashMap<>();
        map.put("userName", userName);
        map.put("phoneNumber", phoneNumber);
        return pointService.checkPoint(map);
    }

    @PostMapping("/point/checkUserPoint")
    public String checkUserPoint(Model model, UserDTO userDTO,
                                 @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                 @RequestParam("userNo") Long userNo, @RequestParam("userName") String userName) {
        List<UserPointDTO> userPointDTO = pointService.checkUserPoint(page, userDTO.getUserNo());
        PageDTO pageDTO = pointService.pagingParam(page, userDTO.getUserNo());

        model.addAttribute("userPointLog", userPointDTO);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("userNo", userNo);
        model.addAttribute("userName", userDTO.getUserName());

        return "checkUserPoint";
    }
}
