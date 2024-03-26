package com.jjinka.jjinkaHoldem.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class UserPointDTO {
    private Long userNo;
    private Long point;
    private Long isGameReward;
    private Long reasonForChange;
    private String etcReason;
    private Long receiverUserNo;
    private String receiverUserName;
    private Long senderUserNo;
    private String senderUserName;
    private String joinGameNo;
    private Timestamp date;
    private Long typeNo;
    private String typeName;
    private Long previous_balance;
    private Long later_balance;
}
