package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class RSEReferenceValuesAPIResponseDTO {

    private String modelName;
    private String modelCode;

    @JsonProperty("groups")
    private List<GroupPOJO> groups;

    @JsonProperty("country")
    private List<RSERefUidDescriptionPOJO> countrys;

    @JsonProperty("sourcing_type")
    private List<RSERefUidDescriptionPOJO> sourcingTypes;

    @JsonProperty("revenue")
    private List<RSERefUidDescriptionPOJO> revenues;

    @JsonProperty("affiliation")
    private List<RSERefUidDescriptionPOJO> affiliations;

    @JsonProperty("sourcing_method")
    private List<RSERefUidDescriptionPOJO> sourcingMethods;

    @JsonProperty("spend_category")
    private List<RSERefUidDescriptionPOJO> spendCategorys;

    @JsonProperty("product_impact")
    private List<RSERefUidDescriptionPOJO> productImpacts;

    @JsonProperty("commodity_type")
    private List<RSERefUidDescriptionPOJO> commodityTypes;

    @JsonProperty("industry")
    private List<RSERefUidDescriptionPOJO> industrys;

    @JsonProperty("design_agreement")
    private List<RSERefUidDescriptionPOJO> designAgreements;

    @JsonProperty("relationship_visibility")
    private List<RSERefUidDescriptionPOJO> relationshipVisibilitys;

    @JsonProperty("business_type")
    private List<BusinessTypePOJO> businessTypes;

    @JsonProperty("range")
    private List<RangeValuesPOJO> ranges;

    @JsonProperty("scoring_ranges")
    private List<RangeValuesPOJO> scoringRanges;

}
