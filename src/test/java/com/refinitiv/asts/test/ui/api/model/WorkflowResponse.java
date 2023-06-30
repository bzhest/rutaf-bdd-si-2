package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class WorkflowResponse {

    private String id;
    private String orderId;
    private String supplierId;
    private String activityId;
    private String clientCode;
    private String clientPoNo;
    private String orderStatus;
    private String orderStatusDesc;
    private ScopeItem recommendedProduct;
    private ScopeItem lineItem;
    private List<ScopeItem> availableProducts;
    private String billingEntityName;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class ScopeItem {

        private String id;
        private String name;
        private String description;
        private String productType;

    }

}
