package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.JinLoginDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.service.LoginService;
import com.jjinka.jjinkaHoldem.service.UserService;
import com.jjinka.jjinkaHoldem.util.PwdEncryption;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final LoginService loginService;
    private final UserService userService;
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

    @GetMapping("/jin/login")
    public String jinLogin() {
        return "jin/login";
    }

    PwdEncryption pwdEncryption = new PwdEncryption();
    @PostMapping("/jin/login")
    public String adminLogin(@ModelAttribute JinLoginDTO jinLoginDTO, HttpSession httpSession) {
        String jinId = jinLoginDTO.getJinId();
        String jinPwd = jinLoginDTO.getJinPwd();

        // 비밀번호를 SHA-256으로 암호화
        String hashedPassword = pwdEncryption.hashPassword(jinPwd);

        jinLoginDTO.setJinPwd(hashedPassword);

        boolean isValidUser = loginService.validateJin(jinLoginDTO);

        if (isValidUser) {
            httpSession.setAttribute("jinId", jinId);
            return "redirect:/jin/totalPoint";
        } else {
            return "redirect:/jin/login";
        }
    }
    @GetMapping("/jin/totalPoint")
    public String totalPoint(Model model) {
        UserDTO userDTO = userService.cntMembers();
        model.addAttribute("cntMember", userDTO.getCntMember());
        model.addAttribute("cntUserPoint", userDTO.getCntUserPoint());

        return "jin/totalPoint";
    }
}
