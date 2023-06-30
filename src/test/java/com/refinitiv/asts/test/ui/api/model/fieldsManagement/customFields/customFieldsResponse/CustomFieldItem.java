package com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomFieldItem {

    private Integer orderNumber;
    private String description;
    private Object updateTime;
    private String customFieldId;
    private String type;
    private boolean required;
    private String createBy;
    private Long createTime;
    private String name;
    private List<OptionsItem> options;
    private String id;
    private Object value;
    private Boolean usePredefinedValues;
    private String status;

}