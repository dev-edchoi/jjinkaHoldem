package com.jjinka.jjinkaHoldem.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class GameDTO {
    private Long gameNo;
    private Long tableNo;
    private Long gameFee;
    private Long totalGameFee;
    private Long rewardRate;
    private Long gameReward;
    //private Long gamePrize;
    private Long isEnd;
    private Long gameType;
    private Timestamp makeDate;
    private String dateAfter;
    private String dateBefore;
}
