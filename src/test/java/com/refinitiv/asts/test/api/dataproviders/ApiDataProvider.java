package com.refinitiv.asts.test.api.dataproviders;

import com.refinitiv.asts.test.api.dto.riskscoringengine.request.PublicRSEAddRangeRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.RiskScoringEngineAPIRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.response.RiskScoringEngineAPIResponseDTO;
import com.refinitiv.asts.test.api.dto.references.request.ReferencesRequestDTO;
import com.refinitiv.asts.test.api.dto.references.response.ReferenceResponseDTO;

import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceProcessIdStatusResponseDTO;
import com.refinitiv.asts.test.api.dto.selfservice.response.SelfServiceResponseDTO;

import lombok.Getter;

@Getter
public enum ApiDataProvider {

    RISKSCORINGENGINE_REQUEST(RiskScoringEngineAPIRequestDTO.class,
                              "apiRestAssured/riskScoringEngine/riskScoringEngineRequest.json"),
    RISKSCORINGENGINE_PUBLIC_ADDRANGE_REQUEST(PublicRSEAddRangeRequestDTO.class,
                                              "apiRestAssured/riskScoringEngine/riskScoringEnginePublicAddRangeRequest.json"),
    SELFSERVICE_PROCESSID_STATUS_RESPONSE(SelfServiceProcessIdStatusResponseDTO.class,
                                          "apiRestAssured/selfservice/selfServiceProcessIdStatusResponse.json"),
    SELFSERVICE_PROCESSID_RESPONSE(SelfServiceResponseDTO.class, "apiRestAssured/selfservice/selfServiceResponse.json"),
    REFERENCES_RESPONSE(ReferenceResponseDTO.class, "apiRestAssured/references/referencesResponse.json"),
    REFERENCES_REQUEST(ReferencesRequestDTO.class, "apiRestAssured/references/referencesRequest.json");

    private final Class<?> dataPayloadClass;
    private final String jsonDataFile;
    private final String JSON = ".json";

    ApiDataProvider(Class<?> dataPayloadClass, String jsonDataFile) {
        this.dataPayloadClass = dataPayloadClass;
        this.jsonDataFile = jsonDataFile;
    }

    public Class<?> getDataPayloadClass() {
        return this.dataPayloadClass;
    }
}

