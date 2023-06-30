package com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse;

import lombok.Data;

import java.util.List;

@Data
public class CustomFieldsResponse {

    private int total;
    private List<CustomFieldItem> objects;

}