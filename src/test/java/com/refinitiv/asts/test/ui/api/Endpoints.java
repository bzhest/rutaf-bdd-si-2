package com.refinitiv.asts.test.ui.api;

public class Endpoints {

    //Connect
    public static final String TENANT_FEATURE_MANAGEMENT = "/siconnect/tenant/featureManagement";
    public static final String ORDER_CUSTOM_FIELD = "/siconnect/integraCheckOrder/customField";
    public static final String SUPPLIER_COMPLIANCE = "/siconnect/cases/supplier/{supplierId}/compliance";
    public static final String CONTACT_COMPLIANCE = "/siconnect/cases/contact/{contactId}/compliance";
    public static final String GET_SUPPLIER = "/siconnect/suppliers/%s";
    public static final String GET_SUPPLIERS_CONTACTS = "/siconnect/suppliers/contacts/%s";
    public static final String DELETE_SUPPLIER = "/siconnect/suppliers/{supplierId}";
    public static final String WORKFLOW_GROUP = "/siconnect/workFlowGroup";
    public static final String USER_GROUP = "/siconnect/userGroup";
    public static final String DELETE_EDIT_CUSTOM_FIELD = "/siconnect/customField/{fieldId}";
    public static final String CUSTOM_FIELD = "/siconnect/customField";
    public static final String COUNTRY_CHECKLIST = "/siconnect/countrychecklist";
    public static final String DELETE_COUNTRY_CHECKLIST = "/siconnect/countrychecklist/{listId}";
    public static final String COUNTRIES = "/siconnect/countries";
    public static final String RISK_ASSESSMENT_RISK_PROPERTIES = "/siconnect/suppliers/riskAssessment/riskProperties";
    public static final String WORLD_CHECK_ONE_IS_ENABLED = "/siconnect/worldCheckOne/isEnabled";
    public static final String INDUSTRY_TYPES = "/siconnect/industryTypes";
    public static final String MEDIA_CHECK = "/siconnect/cases/supplier/{supplierId}/mediacheck";
    public static final String UPDATE_CHECK_TYPES = "/siconnect/cases/supplier/{supplierId}";
    public static final String TP_OTHER_NAME_MEDIA_CHECK =
            "/siconnect/cases/supplier/{supplierId}/otherName/{otherName}/mediacheck";
    public static final String MY_EXPORTS = "/siconnect/my-exports";
    public static final String SIMILAR_ARTICLE_LIST =
            "/siconnect/cases/supplier/{supplierId}/mediacheck/results/duplicates";
    public static final String CONTACT_MEDIA_CHECK = "/siconnect/cases/contact/{contactId}/mediacheck";
    public static final String WORLD_CHECK_PUBLICATION_DATE =
            "/siconnect/worldCheckOne/screeningResultSetting/publicationDate";
    public static final String IND_MEDIA_CHECK = "/siconnect/cases/contact/{contactId}/mediacheck";
    public static final String IND_OTHER_NAME_MEDIA_CHECK =
            "/siconnect/cases/contact/{contactId}/otherName/{name}/mediacheck";
    public static final String USERS_DETAILS = "/siconnect/userDetails";
    public static final String LANGUAGES = "/siconnect/languages";
    public static final String PEP_STATUS = "/siconnect/profiles/{referenceId}/pep";

    //App
    public static final String REFDATA_RETRIVE_ALL = "/app/refdata/retrieveAll";
    public static final String REFDATA_RETRIEVE_LIST_VALUE = "/app/refdata/retrieveListValue?valueType={valueType}";
    public static final String REFDATA_RETRIEVE_BY_ID_SORT = "/app/refdata/retrieveByIdSort";
    public static final String REFDATA_DELETE = "/app/refdata/delete";
    public static final String REFDATA_APPEND = "/app/refdata/append";
    public static final String REFREGION_RETRIVE_ALL = "/app/refRegion/retrieveAll";
    public static final String REFCOUNTRY_RETRIVE_ALL = "/app/refCountry/retrieveAll";
    public static final String USERS_RETRIEVE_USERS_ROLES = "/app/role/retrieveByPaginatedSort";
    public static final String USERS_UPDATE_ROLE = "/app/role/update";
    public static final String USERS_RETRIEVE_BY_EMAIL = "/app/users/retrievebyemail/{email}";
    public static final String BILLING_ENTITY = "/app/users/billing-entity";
    public static final String USERS_RETRIEVE_ALL = "/app/users/retrieveall";
    public static final String USERS_RETRIEVE_BY_ID = "/app/users/retrievebyid";
    public static final String USERS_UPDATE = "/app/users/update/{encodedUrl}";
    public static final String EMAIL_TEMPLATE_RETRIEVE_ALL = "/app/emailtemplate/retrieveall/";
    public static final String EMAIL_TEMPLATE_UPDATE = "/app/emailtemplate/update";
    public static final String CLIENT_ORGANIZATION = "/app/organization/retrieveclientorganization";
    public static final String ORGANIZATION_UPDATE = "app/organization/update";
    public static final String DIVISION = "/app/division";
    public static final String ENTITY = "/app/entity";
    public static final String EXTERNAL_ORGANISATION = "/app/externalorganisation";
    public static final String DEPARTMENT = "/app/department";
    public static final String ORGANISATION_GET = "/retrieveallbyorganizationid/";
    public static final String ORGANISATION_DELETE = "/delete/";
    public static final String MY_PROFILE_CONTACTS = "/app/contactinformation/retrievepaginatedlistoverview";

    //Dashboard
    public static final String USER_DETAILS = "/userDetails";
    public static final String DASHBOARD_ASSIGNED_ACTIVITIES = "/sidashboardspa/assigned-activities";
    public static final String DASHBOARD_DRILLDOWN_QUESTIONNAIRE = "/sidashboardspa/drilldown/questionnaire";
    public static final String DASHBOARD_DRILLDOWN_DUE_DILIGENCE = "/sidashboardspa/drilldown/dueDiligence";
    public static final String DASHBOARD_DRILLDOWN_ACTIVITY = "/sidashboardspa/drilldown/activity";
    public static final String DASHBOARD_ITEMS_TO_APPROVE = "/sidashboardspa/activities-to-approve";
    public static final String DASHBOARD_ITEMS_TO_REVIEW = "/sidashboardspa/activities-to-review";
    public static final String DASHBOARD_ASSIGNED_DD_ORDERS = "/sidashboardspa/active-order";
    public static final String DASHBOARD_ORDER_FOR_APPROVAL = "/sidashboardspa/order-for-approval";
    public static final String DASHBOARD_SCREENING_ITEMS_TO_REVIEW = "/sidashboardspa/screening-results-to-review";
    public static final String DASHBOARD_QUESTIONNAIRE_ITEMS_TO_REVIEW = "/sidashboardspa/questionnaire-to-review";
    public static final String DASHBOARD_THIRD_PARTY_FOR_RENEWAL = "/sidashboardspa/suppliers-for-renewal";
    public static final String DASHBOARD_ONBOARDING_MATRIX = "/sidashboardspa/dashboard/onboardingMatrix";
    public static final String DASHBOARD_RENEWAL_MATRIX = "/sidashboardspa/dashboard/renewalMatrix";
    public static final String EXTERNAL_USER_ASSIGNED_ACTIVITIES = "/sidashboardspa/assigned-activities";
    public static final String MEDIA_CHECK_ARTICLE = "/sidashboardspa/riskremediation/{thirdPartyId}/mediacheck";

    //Workflow
    public static final String STANDALONE_ACTIVITIES = "/siworkflow/suppliers/{supplierId}/standalone-activities";
    public static final String SUPPLIERS_WORKFLOW = "/siworkflow/suppliers/{supplierId}/workflow";
    public static final String WORKFLOW_PSA_ORDER_SUPPLIER = "/siworkflow/psa/order/supplier/{supplierId}";
    public static final String WORKFLOW_PSA_ORDER = "/siworkflow/psa/order/{orderId}";
    public static final String MANAGEMENT_WORKFLOW_GROUP = "/siworkflow/workflowgroup";
    public static final String DELETE_WORKFLOW_GROUP = "/siworkflow/workflowgroup/{groupId}";
    public static final String GET_WORKFLOWS = "/siworkflow/workflows";
    public static final String GET_SCOPE = "/siworkflow/psa/product";
    public static final String EDIT_WORKFLOW = "/siworkflow/workflows/{groupId}";
    public static final String PROCESS_RULES = "siworkflow/process-rules";
    public static final String DELETE_PROCESS_RULES = "siworkflow/process-rules/{processId}";
    public static final String ORDER_APPROVAL = "/siworkflow/integraCheckOrder/approval";
    public static final String QUESTIONNAIRES = "/siworkflow/questionnaires";
    public static final String QUESTIONNAIRES_INACTIVATE = "/siworkflow/questionnaires/{questionnaireId}";
    public static final String QUESTIONNAIRES_REVIEWER_CONFIG = "/siworkflow/questionnaires/reviewerConfig/{id}";
    public static final String QUESTIONNAIRES_CUSTOM_FIELD = "/siworkflow/questionnaires/custom-field/{type}";
    public static final String WORKFLOW_HISTORY = "/siworkflow/supplier-workflow-history";
    public static final String WORKFLOW_PSA_BILLING_ENTITY = "/siworkflow/psa/billing-entity";
    public static final String MESSAGE_MANAGEMENT_LIST = "/siworkflow/notice/management/message/list";

    //DMS
    public static final String API_FILES = "/dms/api/files/{TENANT}?finalized=true";

    //Third-party
    public static final String RENEWAL_UPDATE = "/api/v1/supplier-for-renewal/due/update";

    //Notifications
    public static final String GET_NOTIFICATIONS = "/sinotifications/notifications";

    //Sipublicapi
    public static final String POST_INDIVIDUAL_ASSOCIATED_PARTY =
            "/sipublicapi/thirdparty-relationship/thirdparty/{thirdPartyId}/individual";
    public static final String POST_ORGANIZATION_ASSOCIATED_PARTY =
            "/sipublicapi/thirdparty-relationship/thirdparty/{thirdPartyId}/organization";
    public static final String DELETE_INDIVIDUAL_ASSOCIATED_PARTY =
            "/sipublicapi/thirdparty-relationship/thirdparty/{thirdPartyId}/individual/{contactId}";
    public static final String GET_REFERENCES_COUNTRIES = "/sipublicapi/references/countries";
    public static final String GET_REFERENCES_REGIONS = "/sipublicapi/references/regions";
    public static final String GET_REFERENCES_USER_GROUPS = "/sipublicapi/references/user-groups";
    public static final String CONTACTS_OFFSET_LIST = "sipublicapi/thirdparty/{thirdPartyId}/contacts/offset-list";
    public static final String COMPLIANCE = "/sipublicapi/contacts/iwCompliance/{contactId}/othername/{othername}";
    public static final String USERS_LIST = "/sipublicapi/users/offset-list";
    public static final String THIRD_PARTIES_LIST = "/sipublicapi/thirdparty/offset-list";
    public static final String THIRD_PARTY = "/sipublicapi/thirdparty/{thirdPartyId}";
    public static final String POST_SUPPLIER = "/sipublicapi/thirdparty";
    public static final String RISK_SCORE_ENGINE_RANGE = "/sipublicapi/risk-score-engine/range";
    public static final String RISK_SCORE_ENGINE_REFERENCE_COMMODITY_TYPE =
            "/sipublicapi/risk-score-engine/reference/commodity-type";
    public static final String RISK_SCORE_ENGINE_REFERENCE_INDUSTRY_TYPE =
            "/sipublicapi/risk-score-engine/reference/industry-type";
    public static final String RISK_SCORE_ENGINE_REFERENCE =
            "/sipublicapi/risk-score-engine/reference/";
    public static final String FIELDS_MANAGEMENT = "/sipublicapi/fields-management";
    public static final String SCREENING_MANAGEMENT = "/sipublicapi/screening-management";

}
