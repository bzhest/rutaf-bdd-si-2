package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Providers {

    WATCHLIST("World-Check One"),
    CLIENT_WATCHLIST("Custom WatchList");

    private final String provider;
}
