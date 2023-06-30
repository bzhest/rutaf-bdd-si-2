package com.refinitiv.asts.test.ui.enums;

import com.refinitiv.asts.test.ui.constants.PageElementNames;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;

@Getter
@RequiredArgsConstructor
public enum UserRoleFields {

    THIRD_PARTY_INFORMATION("Third-party Information", THIRD_PARTY),
    ASSOCIATED_PARTIES("Associated Parties", THIRD_PARTY),
    CONTRACTS("Contracts", THIRD_PARTY),
    RELATIONSHIP("Relationship", THIRD_PARTY),
    ACTIVITIES("Activities", THIRD_PARTY),
    BANK_DETAILS("Bank Details", THIRD_PARTY),
    CONFIGURE_OVERALL_RISK("Configure Overall Risk", SUPPLIERS_YES_NO),
    ACTIVITY_ROLLBACK("Activity Rollback", SUPPLIERS_YES_NO),
    EXTERNAL_USER_MANAGEMENT("External User Management", SUPPLIERS_YES_NO),
    ONBOARDING_RENEWAL("Onboarding/Renewal", SUPPLIERS_YES_NO),
    RELATED_FILES("Related Files", null),
    THIRD_PARTY_STATUS("Third-party Status", REPORTS_AND_DASHBOARD),
    RISK_REPORT("Risk Report", REPORTS_AND_DASHBOARD),
    DASHBOARD("Dashboard", REPORTS_AND_DASHBOARD),
    THIRD_PARTY_REPORT("Third-party Report", REPORTS_AND_DASHBOARD),
    ACTIVITY_REPORT("Activity Report", REPORTS_AND_DASHBOARD),
    QUESTIONNAIRE_REPORT("Questionnaire Report", REPORTS_AND_DASHBOARD),
    DUE_DILIGENCE_ORDER_REPORT("Due Diligence Order Report", REPORTS_AND_DASHBOARD),
    WORKFLOW_REPORT("Workflow Report", REPORTS_AND_DASHBOARD),
    USER_MANAGEMENT("User Management", SET_UP),
    MY_ORGANISATION("My Organisation", SET_UP),
    QUESTIONNAIRE_MANAGEMENT("Questionnaire Management", SET_UP),
    WORKFLOW_MANAGEMENT("Workflow Management", SET_UP),
    SCREENING_MANAGEMENT("Screening Management", SET_UP),
    APPROVAL_PROCESS("Approval Process", SET_UP),
    REVIEW_PROCESS("Review Process", SET_UP),
    FIELDS_MANAGEMENT("Fields Management", SET_UP),
    COUNTRY_CHECKLIST("Country Checklist", SET_UP),
    VALUE_MANAGEMENT("Value Management", SET_UP),
    EMAIL_MANAGEMENT("Email Management", SET_UP),
    DUE_DILIGENCE_ORDER_MANAGEMENT("Due Diligence Order Management", SET_UP),
    ANNOUNCEMENT_BANNER("Announcement Banner", SET_UP),
    ORDER_REPORT("Order Report", DUE_DILIGENCE_ORDER),
    ENABLE_SCREENING("Enable Screening", SCREENING),
    MANAGE_RESOLUTION_TYPE("Manage Resolution Type", SCREENING),
    ONGOING_SCREENING("Ongoing Screening", SCREENING),
    CHANGE_SEARCH_CRITERIA("Change Search Criteria", SCREENING),
    BIT_SIGHT_SEARCH("BitSight Search", SCREENING),
    BUSINESS_OVERVIEW_SEARCH("Business Overview Search", null),
    BULK_PROCESSING("Bulk Processing", PageElementNames.BULK_PROCESSING),
    NAME("Name", null),
    DESCRIPTION("Description", null),
    ACTIVE("Active", null),
    DATE_CREATED("Date Created", null),
    LAST_UPDATED("Last Updated", null),
    STATUS("Status", null);

    private final String field;
    private final String block;

    public static List<String> getFieldsFromBlocks(String... blockNames) {
        List<String> result = new ArrayList<>();
        for (String blockName : blockNames) {
            List<String> fields = Arrays.stream(UserRoleFields.values())
                    .filter(value -> value.getBlock() != null && value.getBlock().equals(blockName))
                    .map(UserRoleFields::getField)
                    .collect(Collectors.toList());
            result.addAll(fields);
        }
        return result;
    }
}
