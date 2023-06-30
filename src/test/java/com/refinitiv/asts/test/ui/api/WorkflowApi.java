package com.refinitiv.asts.test.ui.api;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.model.OrderApproval;
import com.refinitiv.asts.test.ui.api.model.WorkflowResponse;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ObjectsItem;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ProcessRuleRequest;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ProcessRuleResponse;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnaireRequest;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnaireResponse;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnairesResponseData;
import com.refinitiv.asts.test.ui.api.model.reviewProcess.ReviewProcessRequest;
import com.refinitiv.asts.test.ui.api.model.riskManagement.AdHocActivity;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowItem;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowResponse;
import com.refinitiv.asts.test.ui.api.model.workflowGroup.WorkflowGroupRequest;
import com.refinitiv.asts.test.ui.enums.OrderType;
import com.refinitiv.asts.test.ui.enums.ProcessRuleTypes;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MessageManagementData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionCustomFieldRequest;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireCustomFieldsItemResponse;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import lombok.NonNull;
import lombok.SneakyThrows;
import org.apache.http.HttpStatus;

import java.util.List;
import java.util.NoSuchElementException;

import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.enums.Languages.EN;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.ENORMOUS_ITEMS_PER_PAGE;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.hc.core5.http.HttpStatus.SC_OK;

public class WorkflowApi extends BaseApi {

    private static final String WORKFLOW_GROUP_ID_FILTER =
            "objects.find { it.name == '%s' }.workflowGroupId";
    private static final String ACTIVE_SCOPE_FILTER =
            "findAll { it.searchType == '%s' }.findAll { it.expired == false }.findAll { it.active == true }.name";
    public static final String FIRST_ID_FILTER = "id[0]";
    public static final String ACTIVE_NAME_FILTER = "findAll { it.status == 'Active' }.name";
    private final static String workflowAPIUrl = Config.get().value("workflow.api.url");

    public WorkflowApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    public static String getLastAddedAdHocActivityByName(String supplierId, String activityName) {
        return given()
                .get(Endpoints.STANDALONE_ACTIVITIES, supplierId)
                .getBody().jsonPath()
                .get(format("objects.find { it.activityType.name == '%s' }.psaOrderId", activityName));
    }

    public static void createAdHocActivityForThirdParty(String thirdPartyId, AdHocActivity activity) {
        given()
                .body(activity)
                .post(Endpoints.STANDALONE_ACTIVITIES, thirdPartyId);
    }

    @NonNull
    public static String getLastSavedAsActivityByName(String supplierId) {
        return given()
                .get(Endpoints.WORKFLOW_PSA_ORDER_SUPPLIER, supplierId)
                .getBody().jsonPath().get(FIRST_ID_FILTER);
    }

    public static List<WorkFlowItem> getLastWorkflowHistoryResponse(String thirdPartyId) {
        Response response = given()
                .params(SUPPLIER_ID, thirdPartyId)
                .get(Endpoints.WORKFLOW_HISTORY);
        Object responseList = getResponseJsonPath(response, OBJECTS_FILTER);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @SneakyThrows
    public static WorkflowResponse getLastSavedAsActivity(String supplierId) {
        Response response = given().get(Endpoints.WORKFLOW_PSA_ORDER_SUPPLIER, supplierId);
        Object responseList = response.getBody().jsonPath().get();
        return getResponseAsObject(responseList, new TypeReference<List<WorkflowResponse>>() {
        }).get(0);
    }

    @SneakyThrows
    public static WorkflowResponse getWorkflowResponse(String orderId) {
        Response response = given().get(Endpoints.WORKFLOW_PSA_ORDER, orderId);
        return getResponseAsObject(response, WorkflowResponse.class);
    }

    public static void postNewWorkflowGroup(String name, boolean status) {
        WorkflowGroupRequest request = new WorkflowGroupRequest().setName(name).setStatus(status);
        postUntilExpectedStatusCode(Endpoints.MANAGEMENT_WORKFLOW_GROUP,
                                    given().body(request));
    }

    public static void patchWorkflowAction(String supplierId, String action) {
        WorkFlowItem request = new WorkFlowItem().setAction(action);
        if (nonNull(supplierId)) {
            given().body(request)
                    .expect()
                    .statusCode(HttpStatus.SC_OK)
                    .when()
                    .patch(Endpoints.SUPPLIERS_WORKFLOW, supplierId);
        }
    }

    public static String getWorkflowGroupIdByName(String name) {
        return (String) getResponseJsonPath(given()
                                                    .param(LIMIT, TEN)
                                                    .param(SORT_BY, _ID)
                                                    .param(SORT_ORDER, DESC)
                                                    .get(Endpoints.MANAGEMENT_WORKFLOW_GROUP),
                                            format(WORKFLOW_GROUP_ID_FILTER, name));
    }

    @SneakyThrows
    public static List<WorkflowGroupData> getWorkflowGroupsList(int limit, int skip, String sortOrder,
            String sortBy) {
        Response response = given()
                .param(LIMIT, limit)
                .param(OFFSET, skip)
                .param(SORT_ORDER, sortOrder)
                .param(SORT_BY, sortBy)
                .get(Endpoints.MANAGEMENT_WORKFLOW_GROUP);
        Object responseList = getResponseJsonPath(response, OBJECTS_FILTER);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @SuppressWarnings("unchecked")
    public static List<String> getPsaScopeResponse(OrderType orderType) {
        return (List<String>) getResponseJsonPath(given().get(Endpoints.GET_SCOPE),
                                                  format(ACTIVE_SCOPE_FILTER, orderType.getSearchType()));
    }

    public static void deleteWorkflowGroup(String groupId) {
        Response response = given().when()
                .delete(Endpoints.DELETE_WORKFLOW_GROUP, groupId);
        if (response.getStatusCode() == SC_OK) {
            logger.info(format("Workflow Group with ID %s is deleted!", groupId));
        } else {
            logger.error(format("Error during deletion Workflow Group with ID %s!", groupId));
        }

    }

    public static WorkFlowItem getWorkflowByName(String name) {
        try {
            return getWorkflows(ENORMOUS_ITEMS_PER_PAGE, _ID, ASC)
                    .getObjects()
                    .stream()
                    .filter(o -> o.getName().equals(name))
                    .findFirst()
                    .orElseThrow(
                            () -> new IllegalArgumentException(name + " is not found in get workflow api response"));
        } catch (NullPointerException | NoSuchElementException ex) {
            logger.error("Workflow with name '" + name + "' doesn't exist");
            return null;
        }
    }

    @SneakyThrows
    public static List<WorkFlowItem> getWorkflowList() {
        Response response = getUntilExpectedStatusCode(Endpoints.GET_WORKFLOWS,
                                                       given().param(LIMIT, ENORMOUS_ITEMS_PER_PAGE)
                                                               .param(SORT_BY, CREATE_TIME)
                                                               .param(SORT_ORDER, DESC));
        Object responseList = getResponseJsonPath(response, OBJECTS_FILTER);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    public static WorkFlowResponse getWorkflows(int limit, String sortBy, String sortOrder) {
        Response response = getUntilExpectedStatusCode(Endpoints.GET_WORKFLOWS,
                                                       given().param(LIMIT, limit)
                                                               .param(SORT_BY, sortBy)
                                                               .param(SORT_ORDER, sortOrder));
        return parseResponseBody(response, WorkFlowResponse.class);
    }

    public static void updateWorkflow(WorkFlowItem workflow, String workflowId) {
        Response response = given()
                .body(workflow)
                .put(Endpoints.EDIT_WORKFLOW, workflowId);
        if (response.getStatusCode() == SC_OK) {
            logger.info(format("Workflow with name %s is updated!", workflow.getName()));
        } else {
            logger.error(format("Error during updating Workflow with name %s!", workflow.getName()));
        }
    }

    public static void triggerRenewalUpdate() {
        RestAssured.given(new RequestSpecBuilder()
                                  .addHeader("X-Tenant-Code", Config.get().value("tenant"))
                                  .addHeader("requestorEmail", Config.get().value("admin.username"))
                                  .setBaseUri(workflowAPIUrl).build())
                .post(Endpoints.RENEWAL_UPDATE)
                .then()
                .statusCode(SC_OK);
    }

    public static ProcessRuleResponse getProcessRules(int limit, int offset, ProcessRuleTypes type) {
        return getProcessRules(limit, offset, type, null);
    }

    public static ProcessRuleResponse getProcessRules(int limit, int offset, ProcessRuleTypes type, String status) {
        return parseResponseBody(getProcessRulesRequestPreset(limit, offset, type, status)
                                         .get(Endpoints.PROCESS_RULES), ProcessRuleResponse.class);
    }

    public static void deleteProcessRule(String processRuleId) {
        Response response = given()
                .when()
                .delete(Endpoints.DELETE_PROCESS_RULES, processRuleId);
        if (response.getStatusCode() == SC_OK) {
            logger.info(format("Process Rule with ID %s is deleted!", processRuleId));
        } else {
            logger.error(format("Error during deletion Process Rule with ID %s!", processRuleId));
        }
    }

    public static ProcessRuleResponse getRecentlyProcessRules(int limit, int offset, Long startDate,
            Long endDate, ProcessRuleTypes type) {
        return parseResponseBody(getProcessRulesRequestPreset(limit, offset, type, null)
                                         .param(START_DATE, startDate)
                                         .param(END_DATE, endDate)
                                         .get(Endpoints.PROCESS_RULES), ProcessRuleResponse.class);
    }

    public static void postApprovalProcessRule(ProcessRuleRequest request) {
        given().body(request).expect().statusCode(SC_OK)
                .when()
                .post(Endpoints.PROCESS_RULES);
    }

    public static ObjectsItem postReviewProcessRule(ReviewProcessRequest request) {
        return parseResponseBody(given().body(request).expect().statusCode(SC_OK)
                                         .when()
                                         .post(Endpoints.PROCESS_RULES), ObjectsItem.class);
    }

    public static OrderApproval getOrderApproval() {
        return parseResponseBody(given().expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.ORDER_APPROVAL), OrderApproval.class);
    }

    public static void postOrderApproval(OrderApproval request) {
        given().body(request).expect().statusCode(SC_OK)
                .when()
                .post(Endpoints.ORDER_APPROVAL);
    }

    @SneakyThrows
    public static List<QuestionnairesResponseData> getActiveQuestionnaires() {
        return getActiveQuestionnaires(CREATE_TIME, DESC).getObjects();
    }

    public static QuestionnaireResponse getActiveQuestionnaires(String sortBy, String sortOrder) {
        return parseResponseBody(given()
                                         .param(LIMIT, 1000)
                                         .param(STATUS, true)
                                         .param(SORT_BY, sortBy)
                                         .param(SORT_ORDER, sortOrder)
                                         .expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.QUESTIONNAIRES), QuestionnaireResponse.class);
    }

    public static QuestionnaireResponse getAllQuestionnaires(String sortBy, String sortOrder) {
        return parseResponseBody(given()
                                         .param(LIMIT, 1000)
                                         .param(SORT_BY, sortBy)
                                         .param(SORT_ORDER, sortOrder)
                                         .expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.QUESTIONNAIRES), QuestionnaireResponse.class);
    }

    @SneakyThrows
    public static List<QuestionnairesResponseData> getActiveQuestionnaires(String name) {
        Response response = given()
                .param(LIMIT, 1000)
                .params(NAME, name)
                .expect().statusCode(SC_OK)
                .when()
                .get(Endpoints.QUESTIONNAIRES);
        Object responseList = getResponseJsonPath(response, OBJECTS_FILTER);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    public static void inactivateQuestionnaire(String questionnaireId, QuestionnaireRequest questionnaire) {
        Response response = given()
                .body(questionnaire)
                .when()
                .put(Endpoints.QUESTIONNAIRES_INACTIVATE, questionnaireId);
        if (response.getStatusCode() == (HttpStatus.SC_OK)) {
            logger.info(format("Questionnaire with ID %s is inactivated!", questionnaireId));
        } else {
            logger.error(format("Error during inactivation Questionnaire with ID %s!", questionnaireId));
        }
    }

    public static Object getQuestionnairesReviewerConfig(String id) {
        return getResponseAsObject(given().expect().statusCode(SC_OK)
                                           .when()
                                           .get(Endpoints.QUESTIONNAIRES_REVIEWER_CONFIG, id), Object.class);
    }

    public static List<QuestionnaireCustomFieldsItemResponse> getQuestionnairesCustomFields(String type) {
        QuestionCustomFieldRequest request = new QuestionCustomFieldRequest().setLanguageSetup(
                List.of(EN.getCode().toUpperCase()));
        return getResponseJsonPathAsList(given().body(request).expect().statusCode(SC_OK)
                                                 .when()
                                                 .post(Endpoints.QUESTIONNAIRES_CUSTOM_FIELD, type), EMPTY,
                                         QuestionnaireCustomFieldsItemResponse.class);
    }

    @SuppressWarnings("unchecked")
    public static List<String> getActiveBillingEntities() {
        return (List<String>) getResponseJsonPath(given().get(Endpoints.WORKFLOW_PSA_BILLING_ENTITY),
                                                  ACTIVE_NAME_FILTER);
    }

    public static List<MessageManagementData> getMessageManagementItems() {
        return getResponseJsonPathAsList(given().get(Endpoints.MESSAGE_MANAGEMENT_LIST),
                                         EMPTY,
                                         MessageManagementData.class);
    }

    private static RequestSpecification getProcessRulesRequestPreset(int limit, int offset, ProcessRuleTypes type,
            String status) {
        RequestSpecification param = given()
                .param(LIMIT, limit)
                .param(OFFSET, offset)
                .param(TYPE, type)
                .param(SORT_ORDER, DESC)
                .param(SORT_BY, CREATE_TIME);
        if (nonNull(status)) {
            param.param(STATUS, status);
        }
        return param;
    }

    @SneakyThrows
    public static List<String> getFilteredQuestionnaires(boolean isInternal) {
        return getActiveQuestionnaires(CREATE_TIME, ASC).getObjects().stream()
                .filter(questionnaire -> questionnaire.getInternal() == isInternal)
                .map(questionnaire -> questionnaire.getName().trim())
                .collect(toList());
    }

}
