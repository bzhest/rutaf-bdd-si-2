package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class BusinessTypePOJO {

    private List<String> parentUid;
    private String uid;
    private String description;

}
