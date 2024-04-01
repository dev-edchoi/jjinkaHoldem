package com.jjinka.jjinkaHoldem.controller;


import com.jjinka.jjinkaHoldem.dto.AdminLoginDTO;
import com.jjinka.jjinkaHoldem.service.LoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

import com.jjinka.jjinkaHoldem.util.PwdEncryption;

@Controller
@RequiredArgsConstructor
@RequestMapping("/alphaAdmin")
public class LoginController {
    private final LoginService loginService;
    PwdEncryption pwdEncryption = new PwdEncryption();
    @GetMapping("/makePwd")
    public void makePwd(@RequestParam("adminPwd") String adminPwd) {

        String makePwd = pwdEncryption.hashPassword(adminPwd);
        System.out.println(makePwd);
    }
    @PostMapping("/adminLogin")
    public String adminLogin(@ModelAttribute AdminLoginDTO adminLoginDTO, HttpSession httpSession) {
        String adminId = adminLoginDTO.getAdminId();
        String adminPwd = adminLoginDTO.getAdminPwd();

        // 비밀번호를 SHA-256으로 암호화
        String hashedPassword = pwdEncryption.hashPassword(adminPwd);

        adminLoginDTO.setAdminPwd(hashedPassword);

        boolean isValidUser = loginService.validateAdmin(adminLoginDTO);

        if (isValidUser) {
            httpSession.setAttribute("adminId", adminId);
            return "redirect:/alphaAdmin";
        } else {
            //return "alphaAdmin/login";
            return "redirect:/alphaAdmin/login";
        }
    }
}
