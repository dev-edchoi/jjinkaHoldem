package com.jjinka.jjinkaHoldem.controller;


import com.jjinka.jjinkaHoldem.dto.AdminLoginDTO;
import com.jjinka.jjinkaHoldem.service.LoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/alphaAdmin")
public class LoginController {
    private final LoginService loginService;

    @GetMapping("/makePwd")
    public void makePwd(@RequestParam("adminPwd") String adminPwd) {
        String makePwd = hashPassword(adminPwd);
    }
    @PostMapping("/adminLogin")
    public String adminLogin(@ModelAttribute AdminLoginDTO adminLoginDTO, HttpSession httpSession) {
        String adminId = adminLoginDTO.getAdminId();
        String adminPwd = adminLoginDTO.getAdminPwd();

        // 비밀번호를 SHA-256으로 암호화
        String hashedPassword = hashPassword(adminPwd);

        adminLoginDTO.setAdminPwd(hashedPassword);

        // 여기에 데이터베이스에서 사용자 정보를 확인하는 로직을 추가 (임의로 true로 가정)
        boolean isValidUser = loginService.validateAdmin(adminLoginDTO);

        if (isValidUser) {
            httpSession.setAttribute("adminId", adminId);
            return "redirect:/alphaAdmin";
        } else {
            //return "alphaAdmin/login";
            return "redirect:/alphaAdmin/login";
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());

            // Convert the byte array to a hexadecimal string
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
