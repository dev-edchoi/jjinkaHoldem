package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.service.UserPointService;
import com.jjinka.jjinkaHoldem.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserPointService userPointService;

    @GetMapping("/userRegister")
    public String saveForm() {
        return "userRegister";
    }

    @PostMapping("/save")
    public String userRegister(@ModelAttribute UserDTO userDTO) {
        int saveResult = userService.userRegister(userDTO);

        if (saveResult > 0) {
            return "redirect:/user/";
        } else {
            return "userRegister";
        }
    }

    @GetMapping("/login")
    public String loginForm(){
        return "login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute UserDTO userDTO, HttpSession httpSession){
        boolean loginResult = userService.login(userDTO);

        if(loginResult){
            httpSession.setAttribute("phone", userDTO.getUserName());
            return "index";
        } else {
            return "login";
        }
    }

    @GetMapping("/")
    public String findAll(Model model) {
        List<UserDTO> userDTOList = userService.findAll();
        model.addAttribute("userList", userDTOList);
        return "userList";
    }
    @GetMapping
    public String findByUserNo(@RequestParam("userNo") Long userNo, Model model){
        UserDTO userDTO = userService.findByUserNo(userNo);
        List<UserPointDTO> userPointDTOS = userPointService.userPointAll(userNo);

        System.out.println(userPointDTOS);

        model.addAttribute("userList", userDTO);
        model.addAttribute("userPoint", userPointDTOS);

        return "userDetail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("userNo") Long userNo){
        userService.delete(userNo);
        return "redirect:/user/";
    }

    @GetMapping("/userUpdate")
    public String userUpdate(@RequestParam("userNo") Long userNo, Model model){
        UserDTO userDTO = userService.findByUserNo(userNo);
        model.addAttribute("user", userDTO);
        return "userUpdate";
    }

    //수정 처리
    @PostMapping("/userUpdate")
    public String userUpdate(@ModelAttribute UserDTO userDTO){
        boolean result = userService.update(userDTO);
        if(result){
            return "redirect:/user?userNo=" + userDTO.getUserNo();
        } else {
            return "index";
        }
    }

    @PostMapping("/userUpdatePoint")
    public String userUpdatePoint(@ModelAttribute UserDTO userDTO, @RequestParam("userPoint") String userPoint){
        System.out.println(userDTO.getUserNo() + " : " + userPoint);
        Map<String,Object> map = new HashMap<String,Object>();
            map.put("userNo", userDTO.getUserNo());
            map.put("userPoint", (long) Integer.parseInt(userPoint));
        userService.updatePoint(map);
        userPointService.insertPointLog(map);

        return "redirect:/user?userNo=" + userDTO.getUserNo();
    }

    @PostMapping("/phoneNumberChk")
    public @ResponseBody String phoneNumberChk(@RequestParam("phoneNumber") String phoneNumber){
        return userService.phoneNoCheck(phoneNumber);
    }
}

