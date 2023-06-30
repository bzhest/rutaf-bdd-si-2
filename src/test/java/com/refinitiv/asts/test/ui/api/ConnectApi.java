package com.refinitiv.asts.test.ui.api;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.*;
import com.refinitiv.asts.test.ui.api.model.countryChecklist.CountyChecklistRequest;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.CreateCustomFieldRequest;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldItem;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldsResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckRequest;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckUpdateRequest;
import com.refinitiv.asts.test.ui.api.model.mediacheck.PublicationDateResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.SimilarArticleRequest;
import com.refinitiv.asts.test.ui.api.model.thirdParty.RiskArea;
import com.refinitiv.asts.test.ui.api.model.thirdParty.RiskProperty;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.countryChecklist.CountryChecklistData;
import io.restassured.response.Response;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.SneakyThrows;
import org.apache.http.HttpStatus;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.api.Endpoints.*;
import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static java.lang.String.format;
import static org.apache.http.HttpStatus.SC_NOT_FOUND;
import static org.apache.http.HttpStatus.SC_OK;

@NoArgsConstructor
public class ConnectApi extends BaseApi {

    private static final String SEARCH_ID_FILTER = "searchId";
    private static final String GROUP_ID_FILTER_BY_NAME = "objects.find { it.name == '%s' }.userGroupId";
    private static final String GROUP_ID_FILTER_NAMES = "objects.name";
    private static final String GROUP_ID_FILTER_NAMES_BY_STATUS = "objects.findAll{ it.status == '%s' }.name";
    private static final String OTHER_NAME_ID_FILTER = "iwOtherNames.find { it.name == '%s' }.iwCompliance.searchId";
    private static final String LAST_PSA_ORDER_ID_FILTER = "activities.psaOrderId[-1]";
    private static final String LAST_ADHOC_ACTIVITY_ID_FILTER = "activities.id[-1]";
    private static final String LAST_ACTIVITY_ID_FILTER = "workflowComponents.activities[-1].id[-1]";
    private static final String CUSTOM_FIELD_ID_FILTER = "objects.find {it.name == '%s' }.customFieldId";
    private static final String COUNTRY_CHECKLIST_ID_FILTER =
            "objects.find { it.listName == '%s' }.countryChecklistId";
    private static final String COUNTRY_CHECKLIST_COUNTRY_LIST_FILTER =
            "objects.countryList";
    private static final String ACTIVE_USER_GROUPS_FILTER = "objects.findAll { it.status == 'true' }.name";
    private static final String INACTIVE_USER_GROUPS_FILTER = "objects.findAll { it.status == 'false' }.name";
    private static final String RESPONSE_CODE = "responseCode";
    private static final String RISK_AREAS = "riskAssessment.riskAreas";

    public ConnectApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    @NonNull
    public static FeatureManagementResponse getTenantFeatureManagement() {
        return parseResponseBody(given().get(Endpoints.TENANT_FEATURE_MANAGEMENT), FeatureManagementResponse.class);
    }

    @NonNull
    public static CustomFieldIntegraCheckResponse getIntegraCheckCustomFields() {
        return parseResponseBody(given().get(Endpoints.ORDER_CUSTOM_FIELD), CustomFieldIntegraCheckResponse.class);
    }

    public static void setCustomFields(CustomFieldIntegraCheckResponse defaultSetUp) {
        given().body(defaultSetUp).post(Endpoints.ORDER_CUSTOM_FIELD);
    }

    @NonNull
    public static String getSupplierSearchId(String supplierId) {
        return (String) getResponseJsonPath(
                given().get(Endpoints.SUPPLIER_COMPLIANCE, supplierId), SEARCH_ID_FILTER);
    }

    @NonNull
    public static String getContactSearchId(String contactId) {
        return (String) getResponseJsonPath(given().get(Endpoints.CONTACT_COMPLIANCE, contactId), SEARCH_ID_FILTER);
    }

    public static boolean isThirdPartyNotFound(String thirdPartyId) {
        Response response = given().expect().statusCode(SC_OK).when().get(format(GET_SUPPLIER, thirdPartyId));
        return getResponseJsonPath(response, RESPONSE_CODE).equals(SC_NOT_FOUND);
    }

    public static boolean isContactNotFound(String contactId) {
        Response response = given().expect().statusCode(SC_OK)
                .when()
                .get(format(GET_SUPPLIERS_CONTACTS, contactId));
        return getResponseJsonPath(response, RESPONSE_CODE).equals(SC_NOT_FOUND);
    }

    @NonNull
    public static String getOtherNameSearchId(String supplierId, String otherName) {
        String filter = format(OTHER_NAME_ID_FILTER, otherName);
        return (String) getResponseJsonPath(getUntilNonNull(otherName,
                                                            format(Endpoints.GET_SUPPLIER, supplierId), filter,
                                                            given()), filter);
    }

    public static String getLastPsaOrderId(String supplierId) {
        Response response = given().expect().statusCode(SC_OK).when().get(format(GET_SUPPLIER, supplierId));
        return (String) getResponseJsonPath(response, LAST_PSA_ORDER_ID_FILTER);
    }

    public static String getLastAdhocActivityId(String supplierId) {
        Response response = given().expect().statusCode(SC_OK).when().get(format(GET_SUPPLIER, supplierId));
        return (String) getResponseJsonPath(response, LAST_ADHOC_ACTIVITY_ID_FILTER);
    }

    public static String getLastActivityId(String supplierId) {
        return (String) getResponseJsonPath(given().get(SUPPLIERS_WORKFLOW, supplierId), LAST_ACTIVITY_ID_FILTER);
    }

    public static List<RiskArea> getThirdPartyRiskAreasScore(String thirdPartyId) {
        Response response = given().when().get(format(GET_SUPPLIER, thirdPartyId));
        Object responseList = getResponseJsonPath(response, RISK_AREAS);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @SneakyThrows
    public static List<RiskProperty> getRiskProperties() {
        Response response = given().when().get(Endpoints.RISK_ASSESSMENT_RISK_PROPERTIES);
        Object responseList = response.jsonPath().get();
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @NonNull
    public static Response getWorkflowGroupResponse() {
        return given().expect().statusCode(SC_OK).when().get(Endpoints.WORKFLOW_GROUP);
    }

    public static void createUserGroup(UserManagementGroup request) {
        given().body(request).post(Endpoints.USER_GROUP);
    }

    public static Response getMediaCheck(MediaCheckRequest request, String supplierId) {
        return given().body(request).post(Endpoints.MEDIA_CHECK, supplierId);
    }

    public static Response getPepStatus(String referenceId) {
        return given().post(Endpoints.PEP_STATUS, referenceId);
    }

    public static Response getMediaCheckOtherNames(MediaCheckRequest request, String supplierId, String otherName) {
        return given().body(request).post(Endpoints.TP_OTHER_NAME_MEDIA_CHECK, supplierId, otherName);
    }

    public static PublicationDateResponse getPublicationDate() {
        Response response = given().when().get(Endpoints.WORLD_CHECK_PUBLICATION_DATE);
        return getResponseAsObject(response, PublicationDateResponse.class);
    }

    public static Response getMediaCheckTpOtherName(MediaCheckRequest request, String supplierId, String otherName) {
        return given().body(request).post(Endpoints.TP_OTHER_NAME_MEDIA_CHECK, supplierId, otherName);
    }

    public static Response getMediaCheckAssociatedIndividual(MediaCheckRequest request, String contactId) {
        return given().body(request).post(Endpoints.IND_MEDIA_CHECK, contactId);
    }

    public static Response getMediaCheckIndOtherName(MediaCheckRequest request, String contactId, String name) {
        return given().body(request).post(IND_OTHER_NAME_MEDIA_CHECK, contactId, name);
    }

    public static void updateCheckTypes(MediaCheckUpdateRequest request, String supplierId) {
        given().body(request).patch(Endpoints.UPDATE_CHECK_TYPES, supplierId);
    }

    public static Response getSimilarArticle(SimilarArticleRequest request, String supplierId) {
        return given().body(request).post(Endpoints.SIMILAR_ARTICLE_LIST, supplierId);
    }

    @NonNull
    public static String getGroupIdByName(String name) {
        return (String) getResponseJsonPath(getUserGroups(), format(GROUP_ID_FILTER_BY_NAME, name));
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public static List<String> getUserGroupNames() {
        return (List<String>) getResponseJsonPath(getUserGroups(), GROUP_ID_FILTER_NAMES);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public static List<String> getUserGroupNamesByStatus(String status) {
        return (List<String>) getResponseJsonPath(getUserGroups(), format(GROUP_ID_FILTER_NAMES_BY_STATUS, status));
    }

    public static Response getUserGroups() {
        return given()
                .param(LIMIT, "1000")
                .param(SORT_BY, "createTime")
                .param(SORT_ORDER, DEFAULT_SORT)
                .expect().statusCode(SC_OK)
                .when()
                .get(Endpoints.USER_GROUP);
    }

    public static UserManagementGroup getUserGroup(String groupId) {
        return parseResponseBody(given().expect()
                                         .statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.USER_GROUP + DELIMITER + groupId),
                                 UserManagementGroup.class);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public static List<String> getListOfActiveUserGroups() {
        return (List<String>) getResponseJsonPath(getUserGroups(), ACTIVE_USER_GROUPS_FILTER);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public static List<String> getListOfInactiveUserGroups() {
        return (List<String>) getResponseJsonPath(getUserGroups(), INACTIVE_USER_GROUPS_FILTER);
    }

    public static void deleteGroup(String groupId) {
        given().expect().statusCode(SC_OK).when().delete(Endpoints.USER_GROUP + DELIMITER + groupId);
    }

    public static void deleteThirdParty(String thirdPartyId) {
        given().expect().statusCode(SC_OK).when().delete(Endpoints.DELETE_SUPPLIER, thirdPartyId);
    }

    public static CustomFieldItem createCustomField(CreateCustomFieldRequest request) {
        return parseResponseBody(given().body(request).post(Endpoints.CUSTOM_FIELD), CustomFieldItem.class);
    }

    public static CustomFieldsResponse getCustomFields(int limit, String status) {
        return parseResponseBody(given().param(LIMIT, limit)
                                         .param(OFFSET, DEFAULT_PAGE)
                                         .param(SORT_BY, _ID)
                                         .param(SORT_ORDER, ASC)
                                         .param(STATUS, status)
                                         .get(Endpoints.CUSTOM_FIELD), CustomFieldsResponse.class);
    }

    public static CustomFieldsResponse getAllCustomFields() {
        return parseResponseBody(getUntilExpectedStatusCode(Endpoints.CUSTOM_FIELD, given().param(LIMIT, ALL_ITEMS)
                .param(OFFSET, DEFAULT_PAGE)
                .param(SORT_BY, _ID)
                .param(SORT_ORDER, ASC)
                .param(STATUS, ALL)), CustomFieldsResponse.class);
    }

    public static String getCustomFieldId(String name) {
        Response response = given().param(LIMIT, ENORMOUS_ITEMS_PER_PAGE)
                .param(SORT_BY, _ID)
                .param(SORT_ORDER, DESC)
                .get(Endpoints.CUSTOM_FIELD);
        return (String) getResponseJsonPath(response, format(ConnectApi.CUSTOM_FIELD_ID_FILTER, name));
    }

    public static void deleteCustomField(String fieldId) {
        deleteFieldById(Endpoints.DELETE_EDIT_CUSTOM_FIELD, fieldId);
    }

    public static void updateCustomField(CustomFieldItem fieldData) {
        Object errors = given().body(ApiRequestBuilder.buildUpdateCustomFieldRequest(fieldData))
                .put(Endpoints.DELETE_EDIT_CUSTOM_FIELD, fieldData.getCustomFieldId()).getBody().path("errors");
        if (Objects.nonNull(errors)) {
            logger.error("Custom field was not updated. Error:\n " + errors);
        }
    }

    public static String getCountryChecklistId(String name) {
        Response response = given().param(LIMIT, TEN)
                .param(OFFSET, DEFAULT_PAGE)
                .param(SORT_BY, _ID)
                .param(SORT_ORDER, DESC)
                .get(COUNTRY_CHECKLIST);
        return (String) getResponseJsonPath(response, format(COUNTRY_CHECKLIST_ID_FILTER, name));
    }

    @NonNull
    public static String getCountryChecklistCountriesList() {
        return given()
                .param(OFFSET, DEFAULT_PAGE)
                .param(SORT_BY, _ID)
                .param(SORT_ORDER, DESC)
                .get(Endpoints.COUNTRY_CHECKLIST)
                .getBody()
                .jsonPath()
                .getString(COUNTRY_CHECKLIST_COUNTRY_LIST_FILTER);
    }

    @SneakyThrows
    public static List<CountryChecklistData> getCountryChecklistsList(int limit_number, String sorted_By,
            String order) {
        Response response = given()
                .param(LIMIT, limit_number)
                .param(OFFSET, DEFAULT_PAGE)
                .param(SORT_BY, sorted_By)
                .param(SORT_ORDER, order)
                .get(Endpoints.COUNTRY_CHECKLIST);
        Object responseList = getResponseJsonPath(response, OBJECTS_FILTER);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    public static void deleteCountryChecklist(String listId) {
        deleteFieldById(Endpoints.DELETE_COUNTRY_CHECKLIST, listId);
    }

    public static void postCountryChecklist(CountyChecklistRequest request) {
        given().body(request).post(Endpoints.COUNTRY_CHECKLIST);
    }

    public static ReferencesResponse getIndustryTypes() {
        return parseResponseBody(given().expect().statusCode(SC_OK).when().get(INDUSTRY_TYPES),
                                 ReferencesResponse.class);
    }

    public static ReferencesResponse getCountries() {
        return parseResponseBody(given().expect().statusCode(SC_OK).when().get(COUNTRIES), ReferencesResponse.class);
    }

    private static void deleteFieldById(String endpoint, String fieldId) {
        Response deleteResponse = given().when().delete(endpoint, fieldId);
        if (deleteResponse.getStatusCode() == (HttpStatus.SC_OK)) {
            logger.info(format("Field with ID %s is deleted!", fieldId));
        } else {
            logger.error(format("Error during deletion Field with ID %s!", fieldId));
        }
    }

    @SneakyThrows
    public static Map<String, Boolean> getTenantFlagResponse() {
        Object responseMap = given()
                .get(Endpoints.WORLD_CHECK_ONE_IS_ENABLED)
                .getBody()
                .jsonPath().get();
        return getResponseAsObject(responseMap, new TypeReference<>() {
        });
    }

    public static MyExportsResponse getMyExports() {
        return parseResponseBody(given().expect().statusCode(SC_OK).when().get(MY_EXPORTS),
                                 MyExportsResponse.class);
    }

    public static LanguageResponse getLanguagesResponse() {
        return parseResponseBody(given().expect().statusCode(SC_OK).when().get(LANGUAGES),
                                 LanguageResponse.class);
    }

}