package com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse;

import lombok.Data;

@Data
public class OptionsItem {

    private Boolean inUse;
    private String id;
    private String option;
    private Boolean redFlag;

}