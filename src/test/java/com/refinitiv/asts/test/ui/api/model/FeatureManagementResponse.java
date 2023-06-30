package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class FeatureManagementResponse {

    boolean disableAdhocActivity;
    boolean disableDueDiligenceOrder;
    boolean disableDynamicRiskScoringEngine;
    boolean disableQuestionnaire;
    boolean disableRiskAnalyzer;

}
