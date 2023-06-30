package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RSEPublicReferenceValuePOJO {

    private String code;
    private String name;
    private String description;
    private String createTime;
    private String updateTime;

}
