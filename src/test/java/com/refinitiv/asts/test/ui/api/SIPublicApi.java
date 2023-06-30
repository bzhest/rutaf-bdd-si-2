package com.refinitiv.asts.test.ui.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.*;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.thirdPartyFields.ThirdPartyManagementFields;
import com.refinitiv.asts.test.ui.api.model.screeningManagement.ScreeningManagementRequestDTO;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ObjectsItem;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ThirdPartiesListResponse;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ThirdPartyFilterRequest;
import com.refinitiv.asts.test.ui.api.model.user.UserDetailsResponse;
import com.refinitiv.asts.test.ui.api.model.user.UserRequestPayload;
import com.refinitiv.asts.test.ui.api.model.user.UsersPublicApiResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RiskScoreEngineResponse;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import io.restassured.response.Response;
import lombok.SneakyThrows;
import org.apache.http.HttpStatus;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.getThirdPartyNameFilterRequest;
import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.getUserRequest;
import static com.refinitiv.asts.test.ui.api.Endpoints.*;
import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DASH;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_PAGE;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.hc.core5.http.HttpStatus.SC_OK;

public class SIPublicApi extends BaseApi {

    private final static String USER_DIVISIONS = "payload.divisions.name";

    public SIPublicApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    public static AssociatedPartyIndividualCreateResponse postIndividualAssociatedParty(
            AssociatedPartyIndividualCreateRequest request,
            String thirdPartyId) {
        return parseResponseBody(given().body(request)
                                         .expect().statusCode(SC_OK)
                                         .when()
                                         .post(POST_INDIVIDUAL_ASSOCIATED_PARTY, thirdPartyId),
                                 AssociatedPartyIndividualCreateResponse.class);
    }

    public static AssociatedPartyOrganisationCreateResponse postOrganizationAssociatedParty(
            AssociatedPartyOranisationCreateRequest request,
            String thirdPartyId) {
        return parseResponseBody(given().body(request)
                                         .expect().statusCode(SC_OK)
                                         .when()
                                         .post(POST_ORGANIZATION_ASSOCIATED_PARTY, thirdPartyId),
                                 AssociatedPartyOrganisationCreateResponse.class);
    }

    public static SiPublicReferencesResponse getReferencesCountries() {
        return parseResponseBody(given().expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.GET_REFERENCES_COUNTRIES), SiPublicReferencesResponse.class);
    }

    public static SiPublicReferencesResponse getReferencesRegions() {
        return parseResponseBody(given().expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.GET_REFERENCES_REGIONS), SiPublicReferencesResponse.class);
    }

    public static SiPublicReferencesResponse getReferencesUserGroups() {
        return parseResponseBody(given().expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.GET_REFERENCES_USER_GROUPS), SiPublicReferencesResponse.class);
    }

    public static String getRegionCode(String regionName) {
        return getReferencesRegions().getData().stream().filter(region -> region.getDescription().equals(regionName))
                .findFirst().orElseThrow(() -> new RuntimeException("Region was not found")).getCode();
    }

    public static List<String> getAvailableContactCountriesForRegion(String regionName) {
        String regionCode = getRegionCode(regionName);
        return getReferencesCountries().getData().stream()
                .filter(country -> country.getParentCodes().contains(regionCode))
                .map(SiPublicReferencesResponse.Reference::getDescription)
                .collect(Collectors.toList());
    }

    public static AssociatedPartyIndividualCreateResponse.ContactData createMyProfileContact(
            AssociatedPartyIndividualData associatedPartyIndividualData,
            String externalUserThirdPartyName) {
        String thirdPartyId = getLastCreatedThirdPartyIdByName(externalUserThirdPartyName, EMPTY);
        AssociatedPartyIndividualCreateRequest
                request = ApiRequestBuilder.buildCreateAssociatedPartyIndividualRequest(associatedPartyIndividualData,
                                                                                        thirdPartyId);
        return parseResponseBody(given()
                                         .body(request)
                                         .expect().statusCode(200)
                                         .when()
                                         .post(POST_INDIVIDUAL_ASSOCIATED_PARTY, thirdPartyId),
                                 AssociatedPartyIndividualCreateResponse.class).getData();
    }

    public static void deleteContact(String contactId, String thirdPartyId) {
        given().delete(DELETE_INDIVIDUAL_ASSOCIATED_PARTY, thirdPartyId, contactId);
    }

    public static List<ObjectsItem> getAllThirdParties(int limit, String sortBy, String sortOrder) {
        return getResponseAsObject(
                given()
                        .queryParam(FETCH_TYPE, SAME_DIVISION)
                        .queryParam(PAGE, DEFAULT_PAGE)
                        .queryParam(PAGE_SIZE, limit)
                        .queryParam(ORDER_BY, sortOrder + sortBy)
                        .body("{}")
                        .post(THIRD_PARTIES_LIST), ThirdPartiesListResponse.class).getData();
    }

    public static List<ObjectsItem> getFilteredThirdParties(ThirdPartyFilterRequest request, String fetchType,
            int pageSize) {
        return getResponseAsObject(given().queryParam(FETCH_TYPE, fetchType)
                                           .queryParam(PAGE, DEFAULT_PAGE)
                                           .queryParam(PAGE_SIZE, pageSize)
                                           .queryParam(ORDER_BY, (DASH + CREATE_TIME))
                                           .body(request)
                                           .post(THIRD_PARTIES_LIST),
                                   ThirdPartiesListResponse.class).getData();
    }

    public static void deleteThirdParty(String thirdPartyId) {
        Response deleteResponse = given().
                when().
                delete(THIRD_PARTY, thirdPartyId);
        if (deleteResponse.getStatusCode() == (HttpStatus.SC_OK)) {
            logger.info(format("Third-party with ID %s is deleted!", thirdPartyId));
        } else {
            logger.error(format("Error during deletion Third-party with ID %s!", thirdPartyId));
        }
    }

    public static ThirdPartiesListResponse getAllThirdPartiesResponse(int currentPage, int pageSize) {
        return getResponseAsObject(
                given()
                        .queryParam(FETCH_TYPE, SAME_DIVISION)
                        .queryParam(PAGE, currentPage)
                        .queryParam(PAGE_SIZE, pageSize)
                        .body("{}")
                        .post(THIRD_PARTIES_LIST), ThirdPartiesListResponse.class);
    }

    public static String getLastCreatedThirdPartyIdByName(String name, String division) {
        ObjectsItem thirdPartyByName = getThirdPartyByName(name, division, FIFTY);
        return nonNull(thirdPartyByName) ? thirdPartyByName.getId() : EMPTY;
    }

    public static ObjectsItem getThirdPartyByName(String thirdPartyName, String division, int pageSize) {
        List<ObjectsItem> filteredThirdParties = getFilteredThirdParties(
                getThirdPartyNameFilterRequest(ApiRequestBuilder.NAME, ApiRequestBuilder.LIKE, thirdPartyName),
                division, pageSize);
        return filteredThirdParties.stream()
                .filter(thirdParty -> thirdParty.getName().equals(thirdPartyName) ||
                        thirdParty.getName().contains(thirdPartyName)).findFirst()
                .orElse(null);
    }

    @SneakyThrows
    public static List<UserData> getUsersByPublicApi(int limit, int skip, String sort, String sortBy) {
        Response response = given()
                .param(FETCH_TYPE, ALL)
                .param(PAGE, skip)
                .param(PAGE_SIZE, limit)
                .param(ORDER_BY, sort + sortBy)
                .expect().statusCode(SC_OK)
                .when()
                .get(Endpoints.USERS_LIST);
        return getResponseAsObject(response, UsersPublicApiResponse.class).getData();
    }

    @SneakyThrows
    public static List<UserData> getUsersByPublicApi(int limit, int skip, String sort, String sortBy,
            String fetchType) {
        Response response = given()
                .param(FETCH_TYPE, ALL)
                .param(PAGE, skip)
                .param(PAGE_SIZE, limit)
                .param(ORDER_BY, sort + sortBy)
                .param(FETCH_TYPE, fetchType)
                .expect().statusCode(SC_OK)
                .when()
                .get(Endpoints.USERS_LIST);
        return getResponseAsObject(response, UsersPublicApiResponse.class).getData();
    }

    @SneakyThrows
    public static List<UserData> getFirstActiveUsers(int usersCount, String userType) {
        UserRequestPayload userRequestPayload = getUserRequest(usersCount, userType, SCORE, ASC, true);
        Response response = given()
                .body(userRequestPayload)
                .expect().statusCode(SC_OK)
                .when()
                .post(Endpoints.USERS_DETAILS);
        return getResponseAsObject(response, UserDetailsResponse.class).getRecords();
    }

    public static Response getUserDetailsResponse() {
        return given()
                .body("{}")
                .when()
                .post(Endpoints.USER_DETAILS);
    }

    @SuppressWarnings("unchecked")
    public static List<String> getUserDivisions() {
        return (List<String>) getResponseJsonPath(getUserDetailsResponse(), USER_DIVISIONS);
    }

    public static String createSupplier(CreateSupplierRequest request) {
        return (String) getResponseJsonPath(postSupplier(request), ID_FILTER);
    }

    public static RiskScoreEngineResponse getRiskScoreEngineRanges() {
        Response response = given()
                .when()
                .get(Endpoints.RISK_SCORE_ENGINE_RANGE);
        return getResponseAsObject(response, RiskScoreEngineResponse.class);
    }

    public static RiskScoreEngineResponse getCommodityTypes() {
        Response response = given()
                .when()
                .get(Endpoints.RISK_SCORE_ENGINE_REFERENCE_COMMODITY_TYPE);
        return getResponseAsObject(response, RiskScoreEngineResponse.class);
    }

    public static RiskScoreEngineResponse getIndustryTypes() {
        Response response = given()
                .when()
                .get(Endpoints.RISK_SCORE_ENGINE_REFERENCE_INDUSTRY_TYPE);
        return getResponseAsObject(response, RiskScoreEngineResponse.class);
    }

    public static RiskScoreEngineResponse getRiskScoreEngineReference(String endpoint) {
        Response response = given()
                .when()
                .get(Endpoints.RISK_SCORE_ENGINE_REFERENCE + endpoint);
        return getResponseAsObject(response, RiskScoreEngineResponse.class);
    }

    private static Response postSupplier(CreateSupplierRequest request) {
        return given().body(request).expect().statusCode(HttpStatus.SC_OK).when().post(Endpoints.POST_SUPPLIER);
    }

    public static void setThirdPartyGeneralInformationFieldsToRequired() {
        updateThirdPartyFieldsManagement(ThirdPartyManagementFields.setRequiredGeneralInformationFields());
    }

    public static void setRequiredGeneralInformationAndThirdPartySegmentationFields() {
        updateThirdPartyFieldsManagement(
                ThirdPartyManagementFields.setRequiredGeneralInformationAndThirdPartySegmentationFields());
    }

    public static void unsetActiveThirdPartySegmentationFields() {
        updateThirdPartyFieldsManagement(ThirdPartyManagementFields.unsetActiveThirdPartySegmentationFields());
    }

    public static void setThirdPartyFieldsManagementToDefault() {
        updateThirdPartyFieldsManagement(ThirdPartyManagementFields.setDefaults());
    }

    public static void setSubSectionsActiveFields() {
        updateThirdPartyFieldsManagement(ThirdPartyManagementFields.setSubSectionsActiveFields());
    }

    public static void setDefaultsWithRequiredBankDetailsAndContacts() {
        updateThirdPartyFieldsManagement(ThirdPartyManagementFields.setDefaultsWithRequiredBankDetailsAndContacts());
    }

    public static void setAllFieldsInactiveExceptDefaultRequired() {
        updateThirdPartyFieldsManagement(ThirdPartyManagementFields.setAllFieldsInactiveExceptDefaultRequired());
    }

    public static void updateThirdPartyFieldsManagement(ThirdPartyManagementFields thirdPartyFields){
        Object errors =
                setThirdPartyFieldsManagement(thirdPartyFields).getBody().path("errors");
        if (Objects.nonNull(errors)) {
            logger.error("Third-party fields were not updated. Error:\n " + errors);
        }
    }

    public static Response setThirdPartyFieldsManagement(ThirdPartyManagementFields fields) {
        return given().body(fields).put(Endpoints.FIELDS_MANAGEMENT);
    }

    public static ThirdPartyManagementFields getCurrentThirdPartyFieldsManagementValues() {
        return ResponseBodyParser.getResponseJsonPathAsObject(
                given().get(Endpoints.FIELDS_MANAGEMENT), "data", ThirdPartyManagementFields.class);
    }

    public static void patchScreeningManagement(ScreeningManagementRequestDTO requestDTO) {
        given().body(requestDTO).patch(Endpoints.SCREENING_MANAGEMENT);
    }

}
