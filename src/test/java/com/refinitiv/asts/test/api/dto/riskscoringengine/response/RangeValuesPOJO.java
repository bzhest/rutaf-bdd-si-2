package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RangeValuesPOJO {

    private String color;
    private String name;
    private Double min;
    private Double max;

}
