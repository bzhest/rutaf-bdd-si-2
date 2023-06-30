package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum OrderType {

    ORGANISATION("Company Searches"),
    INDIVIDUAL("Individual Searches");

    private final String searchType;
}
