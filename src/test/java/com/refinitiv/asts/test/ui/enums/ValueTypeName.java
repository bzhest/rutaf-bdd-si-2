package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;

import java.util.HashMap;
import java.util.Map;

@Getter
public enum ValueTypeName {

    DUE_DILIGENCE_ADD_ONS("Add-Ons", null),
    ACTIVITY_PRIORITY("Activity Priority", null),
    REGION("Region", "RefRegion"),
    COUNTRY("Country", "RefCountry"),
    INDUSTRY_TYPE("Industry Type", null),
    BUSINESS_CATEGORY("Business Category", null),
    AFFILIATION("Affiliation", null),
    REVENUE("Revenue", null),
    RELATIONSHIP_VISIBILITY("Relationship Visibility", null),
    CURRENCY("Currency", null),
    SOURCING_METHOD("Sourcing Method", null),
    SOURCING_TYPE("Sourcing Type", null),
    SPEND_CATEGORY("Spend Category", null),
    PRODUCT_IMPACT("Product Impact", null),
    COMMODITY_TYPE("Commodity Type", null),
    CONTRACT_STATUS("Contract Status", null),
    COMPANY_TYPE("Company Type", null),
    QUESTION_CATEGORY("Question Category", null),
    CONTRACT_TYPE("Contract Type", null),
    QUESTIONNAIRE_CATEGORY("Questionnaire Category", "RefQuestionnaireCategory"),
    RELATIONSHIP_TYPE("Relationship Type", null),
    DESIGN_AGREEMENT("Design Agreement", null),
    ORGANISATION_SIZE("Organisation Size", null),
    RISK_SCORING_RANGE("Risk Scoring Range", "RefRiskScoringRange"),
    ACTIVITY_TYPE("Activity Type", "RefActivityType"),
    WC1COUNTRY("WC1Country", null),
    ISOCOUNTRY("ISOCountry", null);

    private final String name;
    private final String type;

    private static final Map<String, ValueTypeName> lookup = new HashMap<>();

    static {
        for (ValueTypeName value : ValueTypeName.values()) {
            lookup.put(value.getName(), value);
        }
    }

    ValueTypeName(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public static ValueTypeName get(String abbreviation) {
        return lookup.get(abbreviation);
    }
}
