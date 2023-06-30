package com.refinitiv.asts.test.ui.api.model.countryChecklist;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class CountyChecklistRequest {

    private String alertMessage;
    private String alertType;
    private String listName;
    private String status;
    private Object[] countryList;

}
