package com.refinitiv.asts.test.ui.api;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.activityFilters.ActivityMetricsFiltersRequest;
import com.refinitiv.asts.test.ui.api.model.dashboard.DashboardResponse;
import com.refinitiv.asts.test.ui.api.model.dashboard.OnboardingMatrixResponse;
import com.refinitiv.asts.test.ui.api.model.dashboard.RenewalMatrixResponse;
import com.refinitiv.asts.test.ui.api.model.metricsActivities.MetricsActivitiesResponse;
import com.refinitiv.asts.test.ui.api.model.metricsDueDiligence.MetricsDueDiligenceResponse;
import com.refinitiv.asts.test.ui.api.model.metricsQuestionnaires.MetricsQuestionnaireResponse;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DdOrdersData;
import io.restassured.response.Response;
import lombok.SneakyThrows;

import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.api.AppApi.PAYLOAD;
import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static java.lang.String.format;

public class DashboardApi extends BaseApi {

    public static final String PAYLOAD_RECORDS = "payload.records";
    public static final String PAYLOAD_RECORDS_ARTICLE_ID =
            "payload.records.find { it.articleName == \"%s\" }.articleId";

    public DashboardApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    public static DashboardResponse getAssignedActivities(String userEmail) {
        return parseResponseBody(given()
                                         .param(EMAIL, userEmail)
                                         .param(LIMIT, ALL_ITEMS)
                                         .get(Endpoints.DASHBOARD_ASSIGNED_ACTIVITIES),
                                 DashboardResponse.class);
    }

    public static MetricsActivitiesResponse getActivities(ActivityMetricsFiltersRequest body) {
        return parseResponseBody(given()
                                         .body(body)
                                         .post(Endpoints.DASHBOARD_DRILLDOWN_ACTIVITY),
                                 MetricsActivitiesResponse.class);
    }

    public static MetricsQuestionnaireResponse getQuestionnaires(ActivityMetricsFiltersRequest body) {
        return parseResponseBody(given()
                                         .body(body)
                                         .post(Endpoints.DASHBOARD_DRILLDOWN_QUESTIONNAIRE),
                                 MetricsQuestionnaireResponse.class);
    }

    public static MetricsDueDiligenceResponse getDueDiligence(ActivityMetricsFiltersRequest body) {
        return parseResponseBody(given()
                                         .body(body)
                                         .post(Endpoints.DASHBOARD_DRILLDOWN_DUE_DILIGENCE),
                                 MetricsDueDiligenceResponse.class);
    }

    public static DashboardResponse getItemsToApprove(String userEmail) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .get(Endpoints.DASHBOARD_ITEMS_TO_APPROVE),
                                 DashboardResponse.class);
    }

    public static DashboardResponse getItemsToReview(String userEmail) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .get(Endpoints.DASHBOARD_ITEMS_TO_REVIEW),
                                 DashboardResponse.class);
    }

    public static DashboardResponse getExternalAssignedActivities(String userEmail, Map<String, Long> dates) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .params(dates)
                                         .get(Endpoints.EXTERNAL_USER_ASSIGNED_ACTIVITIES), DashboardResponse.class);
    }

    @SneakyThrows
    public static List<DdOrdersData.DdOrderDashboard> getAssignedDDOrders(String userEmail) {
        Response response = given()
                .param(EMAIL, userEmail)
                .param(LIMIT, ALL_ITEMS)
                .get(Endpoints.DASHBOARD_ASSIGNED_DD_ORDERS);
        Object responseList = getResponseJsonPath(response, PAYLOAD_RECORDS);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    public static DashboardResponse getOrderForApproval(String userEmail) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .param(LIMIT, ALL_ITEMS)
                                         .get(Endpoints.DASHBOARD_ORDER_FOR_APPROVAL), DashboardResponse.class);
    }

    public static DashboardResponse getScreeningItemsToReview(String userEmail) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .param(LIMIT, ALL_ITEMS)
                                         .get(Endpoints.DASHBOARD_SCREENING_ITEMS_TO_REVIEW), DashboardResponse.class);
    }

    public static DashboardResponse getQuestionnaireItemsToReview(String userEmail) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .param(LIMIT, ALL_ITEMS)
                                         .get(Endpoints.DASHBOARD_QUESTIONNAIRE_ITEMS_TO_REVIEW),
                                 DashboardResponse.class);
    }

    public static DashboardResponse getThirdPartyForRenewal(String userEmail) {
        return parseResponseBody(given().param(EMAIL, userEmail)
                                         .param(LIMIT, ALL_ITEMS)
                                         .get(Endpoints.DASHBOARD_THIRD_PARTY_FOR_RENEWAL),
                                 DashboardResponse.class);
    }

    @SneakyThrows
    public static Map<String, OnboardingMatrixResponse> getOnboardingMatrix(String filter) {
        Response response = given().param(FILTER, filter).get(Endpoints.DASHBOARD_ONBOARDING_MATRIX);
        Object responseMap = getResponseJsonPath(response, PAYLOAD);
        return getResponseAsObject(responseMap, new TypeReference<>() {
        });
    }

    @SneakyThrows
    public static Map<String, RenewalMatrixResponse> getRenewalMatrix(String filter) {
        Response response = given().param(FILTER, filter).get(Endpoints.DASHBOARD_RENEWAL_MATRIX);
        Object responseMap = getResponseJsonPath(response, PAYLOAD);
        return getResponseAsObject(responseMap, new TypeReference<>() {
        });
    }

    public static String getMediaCheckArticleId(String thirdPartyId, String articleName) {
        Response response = given().post(Endpoints.MEDIA_CHECK_ARTICLE, thirdPartyId);
        return (String) getResponseJsonPath(response, format(PAYLOAD_RECORDS_ARTICLE_ID, articleName));
    }

}