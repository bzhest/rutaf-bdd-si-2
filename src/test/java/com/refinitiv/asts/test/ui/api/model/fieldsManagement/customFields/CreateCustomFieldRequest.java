package com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields;

import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.OptionsItem;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class CreateCustomFieldRequest {

    private Integer orderNumber;
    private String name;
    private String description;
    private String type;
    private Boolean usePredefinedValues;
    private Boolean required;
    private String status;
    private List<OptionsItem> options;

}
