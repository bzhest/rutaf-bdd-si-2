package com.refinitiv.asts.test.api.dto.riskscoringengine.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class PublicRSEAddRangeRequestDTO {

    private String name;
    private String min;
    private String max;
    private String color;

}
