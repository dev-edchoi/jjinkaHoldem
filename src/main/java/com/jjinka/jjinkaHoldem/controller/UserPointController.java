package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.service.UserPointService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/alphaAdmin/userPoint")
@RequiredArgsConstructor
public class UserPointController {
    private final UserPointService userPointService;

    @GetMapping("/userPointLog")
    public String userPointLog(Model model,
                               @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                               @RequestParam("userNo") Long userNo) {
        List<UserPointDTO> userPointDTOS = userPointService.userPointLog(page, userNo);
        PageDTO pageDTO = userPointService.pointPagingParam(page, userNo);
        System.out.println(userPointDTOS);
        model.addAttribute("userPointList", userPointDTOS);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("userNo", userNo);

        return "userPointLog";
    }
}
