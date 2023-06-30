package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class RSEPublicRefBUSCATValuePOJO {

    private String code;
    private String name;
    private String description;
    private String createTime;
    private String updateTime;
    private String parentType;
    private List<String> parentCodes;

}
