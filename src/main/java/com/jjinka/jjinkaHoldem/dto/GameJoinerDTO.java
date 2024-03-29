package com.jjinka.jjinkaHoldem.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class GameJoinerDTO {
    private Long gameJoinNo;
    private Long gameNo;
    private Long userNo;
    private String userName;
    private Long gameTime;
    private int inGame;
    private Long prizeMoney;
    private Long joinUserPoint;
    private Timestamp joinTime;
    private Timestamp finishTime;
}
