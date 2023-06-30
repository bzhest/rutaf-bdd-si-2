package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class RSEPublicRangeValuePOJO {

    private String id;
    private String modelName;
    private String description;
    private List<RangeItemPOJO> ranges;

}
