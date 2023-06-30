package com.refinitiv.asts.test.ui.api.model.metricsDueDiligence;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class DueDiligenceItem {

    private String orderType;
    private String supplierCountry;
    private String orderSrouce;
    private String responsibleParty;
    private String supplierIntegrityID;
    private String requestorEmail;
    private String billingEntity;
    private String approverName;
    private List<String> division;
    private Double completionTime;
    private Long dateOrderedApproved;
    private Long dateCreated;
    private String responsiblePartyEmail;
    private String scope;
    private Double riskScore;
    private String requestorName;
    private String supplierName;
    private String approverEmail;
    private String orderID;
    private String riskTier;
    private Long lastUpdate;
    private String supplierStatus;
    private String status;
    private String pONumber;

}