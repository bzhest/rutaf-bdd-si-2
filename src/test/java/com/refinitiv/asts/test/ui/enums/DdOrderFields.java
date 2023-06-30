package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DdOrderFields {

    ORDER_ID("Order Id"),
    ORDER_ID_DASHBOARD("Order ID"),
    ORDER_PO_NUMBER("PO Number"),
    ORDER_DATE("Order Date"),
    ORDER_TYPE("Order Type"),
    SUBJECT_NAME("Subject Name"),
    SCOPE("Scope"),
    STATUS("Status"),
    ORDER_STATUS("Order Status"),
    REQUESTER_NAME("Requester Name"),
    APPROVER_NAME("Approver Name"),
    DUE_DATE("Due Date"),
    RISK_RATING("Risk Rating"),
    DUE_DILIGENCE_SCOPE("Due Diligence Scope");

    private final String name;
}