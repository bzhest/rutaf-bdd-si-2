package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class EnvironmentalAndGovernancePOJO {

    @JsonProperty("RIA-EWM")
    private ScoreDescPOJO RIA_EWM;

    @JsonProperty("RIA-IAT")
    private ScoreDescPOJO RIA_IAT;

    @JsonProperty("RIA-SUS")
    private ScoreDescPOJO RIA_SUS;

    @JsonProperty("RIA-CHU")
    private ScoreDescPOJO RIA_CHU;

    @JsonProperty("RIA-PRR")
    private ScoreDescPOJO RIA_PRR;

    @JsonProperty("RIA-ENS")
    private ScoreDescPOJO RIA_ENS;

}
