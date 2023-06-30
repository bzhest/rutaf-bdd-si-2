package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class RSEPublicReferenceValuesINDBUSMAPAPIResponseDTO<T> {

    private String message;
    private T data;

}
