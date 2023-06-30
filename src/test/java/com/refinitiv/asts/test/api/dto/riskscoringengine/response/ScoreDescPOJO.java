package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class ScoreDescPOJO {

    @JsonProperty("Score")
    private Double score;

    @JsonProperty("Description")
    private String description;

}
