package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.refinitiv.asts.test.ui.api.model.thirdParty.RiskArea;
import lombok.Data;

import java.util.List;

@Data
public class RiskAreasWrapper {

    private List<RiskArea> riskAreas;
    private Float averageRiskScore;

}
