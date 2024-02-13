package com.jjinka.jjinkaHoldem.controller;

import com.jjinka.jjinkaHoldem.dto.GameDTO;
import com.jjinka.jjinkaHoldem.dto.PageDTO;
import com.jjinka.jjinkaHoldem.dto.UserDTO;
import com.jjinka.jjinkaHoldem.dto.UserPointDTO;
import com.jjinka.jjinkaHoldem.service.UserPointService;
import com.jjinka.jjinkaHoldem.service.UserService;
import com.jjinka.jjinkaHoldem.service.GameService;
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
    private final GameService gameService;

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
    /*
    @GetMapping("/")
    public String findAll(Model model) {
        List<UserDTO> userDTOList = userService.findAll();
        model.addAttribute("userList", userDTOList);
        return "userList";
    }
    */
    @GetMapping("/")
    public String paging(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page, @RequestParam(value = "searchWord", required = false) String searchWord){
        List<UserDTO> userDTOList = userService.userList(page, searchWord);
        PageDTO pageDTO = userService.pagingParam(page,searchWord);

        model.addAttribute("userList", userDTOList);
        model.addAttribute("paging", pageDTO);

        return "userList";
    }

    @GetMapping
    public String findByUserNo(@RequestParam("userNo") Long userNo,@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model){
        UserDTO userDTO = userService.findByUserNo(userNo);
        List<UserPointDTO> userPointDTOS = userPointService.userPointAll(userNo);

        model.addAttribute("userList", userDTO);
        model.addAttribute("userPoint", userPointDTOS);
        model.addAttribute("page", page);

        return "userDetail";
    }

    @PostMapping("/findByUserName")
    public @ResponseBody List<UserDTO> findByUserName(@RequestParam("userName") String userName){
        return userService.findByUserName(userName);
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
    public String userUpdatePoint(@ModelAttribute UserDTO userDTO, @RequestParam("userPoint") String userPoint, @RequestParam("reasonForChange") String reasonForChange, @RequestParam(value = "etcReason", required=false) String etcReason){
        Map<String,Object> map = new HashMap<>();
        map.put("userNo", userDTO.getUserNo());
        map.put("userPoint", (long) Integer.parseInt(userPoint));
        map.put("reasonForChange", reasonForChange);
        map.put("etcReason", etcReason);

        userService.updatePoint(map);
        userPointService.insertPointLog(map);

        return "redirect:/user?userNo=" + userDTO.getUserNo();
    }
    @PostMapping("/phoneNumberChk")
    public @ResponseBody String phoneNumberChk(@RequestParam("phoneNumber") String phoneNumber){
        return userService.phoneNoCheck(phoneNumber);
    }

    @GetMapping("/userPopUp")
    public String userPopUp(Model model,@RequestParam("gameNo") Long gameNo){
        List<UserDTO> userDTOList = userService.userPopUp(gameNo);
        Long gameReward = gameService.getGameReward(gameNo);

        GameDTO gameDTO = new GameDTO();
                gameDTO.setGameReward(gameReward);
                gameDTO.setGameNo(gameNo);

        model.addAttribute("userList", userDTOList);
        model.addAttribute("gameInfo", gameDTO);

        return "userPopUp";
    }

    @GetMapping("/userPointPopUp")
    public String userPointPopUp(Model model, @RequestParam("userNo") Long userNo, @RequestParam("userPoint") Long userPoint){
        UserDTO userDTO = new UserDTO();
                userDTO.setUserNo(userNo);
                userDTO.setUserPoint(userPoint);

        model.addAttribute("userInfo", userDTO);

        return "userPointSendPopUp";
    }
    @PostMapping("/sendPointToUser")
    public @ResponseBody String sendPointToUser(@RequestParam("senderUserNo") Long senderUserNo, @RequestParam("receiverUserNo") Long receiverUserNo, @RequestParam("pointToSend") Long pointToSend){
        Map<String,Object> senderMap = new HashMap<>();
        senderMap.put("userNo", senderUserNo);
        senderMap.put("userPoint", pointToSend * -1);
        senderMap.put("reasonForChange", "2");
        senderMap.put("receiverUserNo", receiverUserNo);

        Map<String,Object> receiverMap = new HashMap<>();
        receiverMap.put("userNo", receiverUserNo);
        receiverMap.put("userPoint", pointToSend);
        receiverMap.put("reasonForChange", "2");
        receiverMap.put("senderUserNo", senderUserNo);

        if(userService.updatePoint(senderMap) > 0) {
            userPointService.insertPointLog(senderMap);
            if (userService.updatePoint(receiverMap) > 0) {
                userPointService.insertPointLog(receiverMap);
            }
            return "true";
        }else{
            return "false";
        }
    }
}

