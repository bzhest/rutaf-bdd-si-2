package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class EmploymentSafetyAndReputationPOJO {

    @JsonProperty("RIA-MDS")
    private ScoreDescPOJO RIA_MDS;

    @JsonProperty("RIA-DIV")
    private ScoreDescPOJO RIA_DIV;

    @JsonProperty("RIA-HES")
    private ScoreDescPOJO RIA_HES;

    @JsonProperty("RIA-IRM")
    private ScoreDescPOJO RIA_IRM;

    @JsonProperty("RIA-MLH")
    private ScoreDescPOJO RIA_MLH;

    @JsonProperty("RIA-EMR")
    private ScoreDescPOJO RIA_EMR;

}
