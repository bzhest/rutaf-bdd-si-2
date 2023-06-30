package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class CyberSecurityAndBusinessStabilityPOJO {

    @JsonProperty("RIA-IPI")
    private ScoreDescPOJO RIA_IPI;

    @JsonProperty("RIA-BUC")
    private ScoreDescPOJO RIA_BUC;

    @JsonProperty("RIA-DSB")
    private ScoreDescPOJO RIA_DSB;

    @JsonProperty("RIA-PIM")
    private ScoreDescPOJO RIA_PIM;

}
