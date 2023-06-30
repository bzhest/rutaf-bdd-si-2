package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class AntiTrustAndCorruptionPOJO {

    @JsonProperty("RIA-POL")
    private ScoreDescPOJO RIA_POL;

    @JsonProperty("RIA-EXC")
    private ScoreDescPOJO RIA_EXC;

    @JsonProperty("RIA-FML")
    private ScoreDescPOJO RIA_FML;

    @JsonProperty("RIA-ANB")
    private ScoreDescPOJO RIA_ANB;

    @JsonProperty("RIA-COB")
    private ScoreDescPOJO RIA_COB;

    @JsonProperty("RIA-SOC")
    private ScoreDescPOJO RIA_SOC;

    @JsonProperty("RIA-SAE")
    private ScoreDescPOJO RIA_SAE;

}
