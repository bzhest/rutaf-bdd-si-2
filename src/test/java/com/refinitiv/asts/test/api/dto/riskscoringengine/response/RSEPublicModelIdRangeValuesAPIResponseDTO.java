package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RSEPublicModelIdRangeValuesAPIResponseDTO {

    private String message;
    private RSEPublicRangeValuePOJO data;

}
