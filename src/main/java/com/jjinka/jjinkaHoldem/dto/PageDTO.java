package com.jjinka.jjinkaHoldem.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
    private int page;
    private int maxPage;
    private int startPage;
    private int endPage;
    private String dateAfter;
    private String dateBefore;
}