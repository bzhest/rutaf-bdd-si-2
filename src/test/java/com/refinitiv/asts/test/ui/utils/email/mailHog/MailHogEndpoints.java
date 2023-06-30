package com.refinitiv.asts.test.ui.utils.email.mailHog;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum MailHogEndpoints {

    RETRIEVE_MESSAGES_LIST("/api/v2/messages"),
    SEARCH_MESSAGES("/api/v2/search"),
    DELETE_MESSAGE("/api/v1/messages");

    private final String path;

}
