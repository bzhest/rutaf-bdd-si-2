package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RSEPublicModelValuePOJO {

    private String id;
    private String modelName;
    private String description;
    private String createTime;
    private String updateTime;

    @JsonProperty("default")
    private Boolean defaultValue;

}
