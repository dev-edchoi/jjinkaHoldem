package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.repository.UserPointRepository;
import com.jjinka.jjinkaHoldem.service.UserPointService;
import com.jjinka.jjinkaHoldem.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/alphaAdmin/userPoint")
@RequiredArgsConstructor
public class UserPointController {
    private final UserPointService userPointService;
    private final UserService userService;
    private final UserPointRepository userPointRepository;

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

    @GetMapping("/recPointConversion")
    public String recPointConversion(Model model, @RequestParam("userNo") Long userNo){
//        UserDTO userDTO = new UserDTO();
//                userDTO.setUserNo(userNo);

        UserDTO userDTO = userService.findByUserNo(userNo);

        model.addAttribute("userInfo", userDTO);

        return "/user/recPointConversion";
    }

    @PostMapping("/recPointConv")
    public @ResponseBody int recPointConv(@RequestParam("userNo") Long userNo, @RequestParam("convPoint") Long convPoint,
                                                    @RequestParam("convRecPoint") Long convRecPoint, @RequestParam("convUserPoint") Long convUserPoint){
        Map<String,Object> recPointMap = new HashMap<>();
        recPointMap.put("userNo", userNo);
        recPointMap.put("recPoint", convRecPoint);
        recPointMap.put("userPoint", convUserPoint);

        if(userPointService.recPointConv(recPointMap) >= 1){
            Map<String,Object> recPointLogMap = new HashMap<>();

            recPointLogMap.put("userNo", userNo);
            recPointLogMap.put("convPoint", convPoint);
            recPointLogMap.put("reasonForChange", 5);

            userPointService.insertPointLog(recPointLogMap);

            return 1;
        } else {
            return 0;
        }
    }
}
