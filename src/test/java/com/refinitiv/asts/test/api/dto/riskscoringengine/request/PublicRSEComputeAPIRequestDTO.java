package com.refinitiv.asts.test.api.dto.riskscoringengine.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class PublicRSEComputeAPIRequestDTO {

    private String country;
    private String industryType;
    private String businessType;
    private String parentBusinessType;
    private String childBusinessType;
    private String affiliation;
    private String revenue;
    private String spendCategory;
    private String productDesignAgreement;
    private String relationshipVisibility;
    private String sourcingMethod;
    private String sourcingType;
    private String productImpact;
    private String commodityType;

}
