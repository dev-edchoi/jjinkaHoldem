package com.jjinka.jjinkaHoldem.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class UserDTO {
    private Long userNo;
    private String userName;
    private String phoneNumber;
    private String userPwd;
    private boolean pwdUpdate;
    private Long userPoint;
    private Long visitRoute;
    private String etcVisitRoute;
    private Timestamp registDate;
    private String searchWord;
    private Long cntMember;
    private Long cntUserPoint;
    private Long recommenderNo;
}