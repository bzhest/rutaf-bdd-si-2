package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum ThirdPartySegmentationFields {

    SPEND_CATEGORY(getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.spendCategory"),
                   "Spend Category"),
    DESIGN_AGREEMENT(getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.designAgreement"),
                     "Design Agreement"),
    RELATIONSHIP_VISIBILITY(
            getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.relationshipVisibility"),
            "Relationship Visibility"),
    COMMODITY_TYPE(getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.commodityType"),
                   "Commodity Type"),
    SOURCING_METHOD(getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.sourcingMethod"),
                    "Sourcing Method"),
    SOURCING_TYPE(getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.sourcingType"), "Sourcing Type"),
    PRODUCT_IMPACT(getInstance().getValue("thirdPartyInformation.thirdPartySegmentation.productImpact"),
                   "Product Impact");

    private final String name;
    private final String defaultName;
}
