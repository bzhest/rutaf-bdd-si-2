package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RangeItemPOJO {

    private String id;
    private Double min;
    private Double max;
    private String name;
    private String color;
    private String dateCreated;
    private String dateUpdated;
    private Boolean deleted;

}
