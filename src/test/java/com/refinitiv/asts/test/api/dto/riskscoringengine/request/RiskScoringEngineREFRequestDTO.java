package com.refinitiv.asts.test.api.dto.riskscoringengine.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RiskScoringEngineREFRequestDTO {

    private String country;
    private String industry;

    @JsonProperty("business_type")
    private String businessType;

    @JsonProperty("parent_business_type")
    private String parentBusinessType;

    @JsonProperty("child_business_type")
    private String childBusinessType;

    private String affiliation;
    private String revenue;

    @JsonProperty("spend_category")
    private String spendCategory;

    @JsonProperty("design_agreement")
    private String designAgreement;

    @JsonProperty("relationship_visibility")
    private String relationshipVisibility;

    @JsonProperty("sourcing_method")
    private String sourcingMethod;

    @JsonProperty("sourcing_type")
    private String sourcingType;

    @JsonProperty("product_impact")
    private String productImpact;

    @JsonProperty("commodity_type")
    private String commodityType;

}
