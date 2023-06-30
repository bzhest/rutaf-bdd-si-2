package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ActivityAttachmentFields {

    FILE_NAME("File Name"),
    DESCRIPTION("Description"),
    UPLOAD_DATE("Upload Date"),
    UPLOAD_BY("Upload by");

    private final String name;
}
