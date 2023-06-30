package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import lombok.Data;

@Data
public class RSEPublicComputeAPIResponseDTO {

    private String message;
    private RiskScoringEngineAPIResponseDTO data;

}
