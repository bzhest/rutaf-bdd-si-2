package com.refinitiv.asts.test.ui.api;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.MyOrganizationRequest;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.api.model.emailManagement.EmailTemplatesResponse;
import com.refinitiv.asts.test.ui.api.model.externalUser.MyProfileContactsRequest;
import com.refinitiv.asts.test.ui.api.model.externalUser.MyProfileContactsResponse;
import com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData.OrganizationPayload;
import com.refinitiv.asts.test.ui.api.model.organisation.clientOrganisation.ClientOrganisationResponse;
import com.refinitiv.asts.test.ui.api.model.organisation.clientOrganisation.OrganisationPayload;
import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload;
import com.refinitiv.asts.test.ui.api.model.user.UserRetrieveRequest;
import com.refinitiv.asts.test.ui.api.model.user.UsersResponse;
import com.refinitiv.asts.test.ui.api.model.userRole.UserRoleRequest;
import com.refinitiv.asts.test.ui.api.model.userRole.UserRoleResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataListRetrieveRequest;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataRequest;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.enums.Languages;
import com.refinitiv.asts.test.ui.enums.ValueTypeName;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserRoleData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.userRoleResponse.UserRoleJsonResponse;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowData;
import io.restassured.response.Response;
import lombok.NonNull;
import lombok.SneakyThrows;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.*;
import static com.refinitiv.asts.test.ui.api.Endpoints.*;
import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.SYSTEM_ADMINISTRATOR;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.ValueType.*;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.COUNTRY;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static java.lang.String.format;
import static java.util.Base64.getEncoder;
import static java.util.Collections.singletonList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.hc.core5.http.HttpStatus.SC_OK;
import static org.hamcrest.Matchers.equalTo;

public class AppApi extends BaseApi {

    private static final String CONTACT_OTHER_NAME_ID_FILTER = "data.searchId";
    private static final String CONTACT_ID_FILTER = "data.id";
    private static final String CONTACT_ID_FILTER_BY_NAME =
            "data.find {it.firstName == '%s' && it.lastName == '%s'}.id";
    private static final String DEFAULT_BILLING_ENTITY_NAME_FILTER = "payload.defaultBillingEntity.name";
    private static final String LIST_VALUE_NAMES_FILTER =
            "payload.find { it.name =~ '%s' }.listValues.findAll { it.active == true }.name";
    private static final String VALUE_TYPE_FILTER = "payload.find { it.name =~ '%s' }";
    public static final String SUPPLIER_INFORMATION = "supplierInformation";
    private static final String FIRST_ID_REGION_FILTER = "payload.find { it.name == '%s' }._id";
    private static final String FIRST_COUNTRY_BY_ID_FILTER = "payload.findAll { it.refRegions =~ '%s' }.name";
    private static final String VALUE_MANAGEMENT_TYPE_ID_FILTER = "payload.listValues.find { it.name == '%s' }._id";
    public static final String VALUE_MANAGEMENT_NAMES_FILTER = "payload.listValues.name";
    public static final String NAME_FILTER = "payload.name";
    public static final String FIRST_NAME_FILTER = "payload.firstName";
    public static final String DIVISIONS_NAME_FILTER = "payload.divisions.name";
    public static final String PAYLOAD = "payload";
    public static final String PAYLOAD_NOT_DELETED_FILTER = "payload.findAll { it.isDeleted == false }.name";
    public static final String INTERNAl_USER_TYPE = "Internal";
    public static final String EXTERNAL_USER_TYPE = "External";
    public static final String CLIENT_ORGANIZATION_ID = "oid";

    public AppApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    @NonNull
    public static String getContactOtherNameSearchId(String contactId, String otherName) {
        Response response = given().get(Endpoints.COMPLIANCE, contactId, otherName);
        return (String) getResponseJsonPath(response, CONTACT_OTHER_NAME_ID_FILTER);
    }

    @NonNull
    public static String getContactId(String supplierId, String contactFirstName, String contactLastName) {
        Response response = given().get(Endpoints.CONTACTS_OFFSET_LIST, supplierId);
        String filter = format(CONTACT_ID_FILTER_BY_NAME, contactFirstName, contactLastName);
        return (String) getResponseJsonPath(response, filter);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public static List<String> getContactIdsList(String supplierId) {
        Response response = given().get(Endpoints.CONTACTS_OFFSET_LIST, supplierId);
        return (List<String>) getResponseJsonPath(response, CONTACT_ID_FILTER);
    }

    public static String getDefaultBillingEntityName(String email) {
        return (String) getResponseJsonPath(given().param(EMAIL, email).get(Endpoints.BILLING_ENTITY),
                                            DEFAULT_BILLING_ENTITY_NAME_FILTER);
    }

    public static MyProfileContactsResponse getMyProfileContacts(String username) {
        UserAppApiPayload userDataByEmail = getUserDataByEmail(username);
        MyProfileContactsRequest request = buildGetContactsRequest(userDataByEmail.getPayload().getSupplierId());
        return parseResponseBody(given()
                                         .when()
                                         .queryParam(CURRENT_PAGE, 1)
                                         .body(request)
                                         .post(MY_PROFILE_CONTACTS),
                                 MyProfileContactsResponse.class);
    }

    @SuppressWarnings("unchecked")
    public static List<String> getActiveListValuesNamesByValueTypeName(ValueTypeName typeName) {
        List<String> values = (List<String>) getResponseJsonPath(given().post(Endpoints.REFDATA_RETRIVE_ALL),
                                                                 format(LIST_VALUE_NAMES_FILTER, typeName.getName()));
        return values.stream().map(String::trim).collect(Collectors.toList());
    }

    public static String getValueTypeId(ValueTypeName typeName) {
        return getValueType(typeName.getName()).get_id();
    }

    public static RefDataResponse getValueType(String typeName) {
        return getResponseJsonPathAsObject(given().post(Endpoints.REFDATA_RETRIVE_ALL),
                                           format(VALUE_TYPE_FILTER, typeName), RefDataResponse.class);
    }

    @SneakyThrows
    public static List<RegionCountryRequest.RegionObject> getAllAvailableRegions() {
        Response response = getPostRefDataRetrieveListResponse(REF_REGION.getName());
        Object responseList = getResponseJsonPath(response, PAYLOAD);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @SneakyThrows
    public static List<RegionCountryRequest.RegionObject> getAllAvailableCountries() {
        Response response = getPostRefDataRetrieveListResponse(REF_COUNTRY.getName());
        Object responseList = getResponseJsonPath(response, PAYLOAD);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @SuppressWarnings("unchecked")
    public static List<String> getAvailableRegionNames() {
        return (List<String>) getResponseJsonPath(given().post(Endpoints.REFREGION_RETRIVE_ALL), NAME_FILTER);
    }

    public static String getRegionIdByName(String regionName) {
        return (String) getResponseJsonPath(given().post(Endpoints.REFREGION_RETRIVE_ALL),
                                            format(FIRST_ID_REGION_FILTER, regionName));
    }

    @SuppressWarnings("unchecked")
    public static List<String> getAvailableCountriesForRegion(String regionId) {
        return (List<String>) getResponseJsonPath(given().post(Endpoints.REFCOUNTRY_RETRIVE_ALL),
                                                  format(FIRST_COUNTRY_BY_ID_FILTER, regionId));
    }

    public static Object getUserDataByEmail(String email, String filter) {
        return getResponseJsonPath(given().post(Endpoints.USERS_RETRIEVE_BY_EMAIL, email), filter);
    }

    public static UserAppApiPayload getUserDataByEmail(String email) {
        return parseResponseBody(given().post(Endpoints.USERS_RETRIEVE_BY_EMAIL, email), UserAppApiPayload.class);
    }

    public static RefDataResponse getRefDataPayload(String typeId) {
        return getRefDataResponse(typeId).getBody().jsonPath().getObject(PAYLOAD, RefDataResponse.class);
    }

    public static String getRefDataId(String name, String id) {
        return (String) getResponseJsonPath(getRefDataResponse(id), format(VALUE_MANAGEMENT_TYPE_ID_FILTER, name));
    }

    public static List<String> getCountriesNamesList() {
        String countryRefDataId = getRefDataPayload(getValueTypeId(COUNTRY)).get_id();
        return getRefDataResponse(countryRefDataId).getBody().jsonPath().get(VALUE_MANAGEMENT_NAMES_FILTER);
    }

    @SuppressWarnings("unchecked")
    public static List<String> getListOfNamesForValueManagementType(String typeId) {
        return (List<String>) getResponseJsonPath(getRefDataResponse(typeId), VALUE_MANAGEMENT_NAMES_FILTER);
    }

    public static String deleteRefData(RefDataResponse refDataResponse, String riskRangeId) {
        RefDataRequest request = getRefDataRequest(refDataResponse, riskRangeId);
        return given().body(request).post(Endpoints.REFDATA_DELETE).getBody().asString();
    }

    @SneakyThrows
    public static List<WorkflowData> getRiskScoringList() {
        Response response = getPostRefDataRetrieveListResponse(REF_RISK_SCORING_RANGE.getName());
        Object responseList = getResponseJsonPath(response, PAYLOAD);
        return getResponseAsObject(responseList, new TypeReference<>() {
        });
    }

    @SuppressWarnings("unchecked")
    public static List<String> getActivityTypesNameList() {
        return (List<String>) getResponseJsonPath(getPostRefDataRetrieveListResponse(REF_ACTIVITY_TYPE.getName()),
                                                  PAYLOAD_NOT_DELETED_FILTER);
    }

    @SuppressWarnings("unchecked")
    public static List<String> getQuestionnaireCategoryList() {
        return (List<String>) getResponseJsonPath(
                getPostRefDataRetrieveListResponse(REF_QUESTIONNAIRE_CATEGORY.getName()),
                PAYLOAD_NOT_DELETED_FILTER);
    }

    @SuppressWarnings("unchecked")
    public static List<String> getRiskCategoriesNameList() {
        return (List<String>) getResponseJsonPath(getPostRefDataRetrieveListResponse(REF_RISK_CATEGORY.getName()),
                                                  PAYLOAD_NOT_DELETED_FILTER);
    }

    public static Response getPostRefDataRetrieveListResponse(String valueType) {
        return given().expect().statusCode(SC_OK).when().post(Endpoints.REFDATA_RETRIEVE_LIST_VALUE, valueType);
    }

    public static UserRoleResponse getAllRoles() {
        UserRoleRequest request = getUserRoleRequest(EMPTY, DEFAULT_SORT, CREATE_DATE);
        return getAllRoles(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, request);
    }

    public static UserRoleResponse getAllFilteredRoles(boolean isActive) {
        UserRoleRequest request = getUserRoleRequest(EMPTY, DEFAULT_SORT, CREATE_DATE);
        request.setActive(isActive);
        return getAllRoles(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, request);
    }

    @SneakyThrows
    public static UserRoleResponse getAllRoles(int limit, int skip, UserRoleRequest request) {
        Response response = given()
                .queryParam(LIMIT, limit)
                .queryParam(SKIP, skip)
                .body(request)
                .expect().statusCode(SC_OK)
                .when()
                .post(Endpoints.USERS_RETRIEVE_USERS_ROLES);
        return getResponseAsObject(response, UserRoleResponse.class);
    }

    @SneakyThrows
    public static UserRoleJsonResponse getAllRolesInJson(int limit, int skip, String sortType, String sortBy) {
        UserRoleRequest request = getUserRoleRequest(EMPTY, sortType, sortBy);
        Response response = given()
                .queryParam(LIMIT, limit)
                .queryParam(SKIP, skip)
                .body(request)
                .expect().statusCode(SC_OK)
                .when()
                .post(Endpoints.USERS_RETRIEVE_USERS_ROLES);
        return getResponseAsObject(response, UserRoleJsonResponse.class);
    }

    public static void deleteRole(String roleName) {
        if (roleName.equals(SYSTEM_ADMINISTRATOR)) {
            throw new IllegalArgumentException(format("%s role cannot be deleted", roleName));
        }
        String roleId = getAllRoles().getPayload().stream()
                .filter(role -> role.getName().equals(roleName))
                .findFirst()
                .orElse(new UserRoleData())
                .get_id();
        if (roleId != null) {
            UserRoleData roleToDelete = new UserRoleData().set_id(roleId).setDeleted(true);
            BaseApi.given()
                    .body(roleToDelete)
                    .expect().statusCode(SC_OK)
                    .when()
                    .post(Endpoints.USERS_UPDATE_ROLE)
                    .then().assertThat().body(APIConstants.MESSAGE, equalTo(APIConstants.SUCCESS));
        } else {
            logger.info("Role is not found");
        }
    }

    @SneakyThrows
    public static UsersResponse getUsers(int limit, int skip, String sort, String sortBy) {
        Response response = given()
                .queryParam(LIMIT, limit)
                .queryParam(SKIP, skip)
                .queryParam(SORT, sort)
                .queryParam(SORT_BY_CAMEL_CASE, sortBy)
                .body("{}")
                .expect().statusCode(SC_OK)
                .when()
                .post(Endpoints.USERS_RETRIEVE_ALL);
        return getResponseAsObject(response, UsersResponse.class);
    }

    public static ClientOrganisationResponse retrieveClientOrganization() {
        MyOrganizationRequest request = getMyOrganizationRequest();
        return parseResponseBody(given().body(request).expect().statusCode(SC_OK)
                                         .when()
                                         .post(CLIENT_ORGANIZATION), ClientOrganisationResponse.class);
    }

    public static void updateClientOrganization(OrganisationPayload request) {
        given().body(request).expect().statusCode(SC_OK).when().post(ORGANIZATION_UPDATE);
    }

    public static List<String> getAllDivisions() {
        return getMyOrganizationDetails(DIVISION + ORGANISATION_GET);
    }

    public static List<String> getAllDepartments() {
        return getMyOrganizationDetails(DEPARTMENT + ORGANISATION_GET);
    }

    public static Stream<UserData> getAllActiveInternalUsersStream(String sort) {
        return getUsers(USERS_ITEMS_PER_PAGE, ZERO, sort, DATE_CREATED).getPayload()
                .getData().stream()
                .filter(user -> ACTIVE.getStatus().equalsIgnoreCase(user.getStatus()) &&
                        INTERNAl_USER_TYPE.equals(user.getUserType()) && nonNull(user.getRole()) &&
                        nonNull(user.getUsername()));
    }

    public static Stream<UserData> getActiveUsersFromPublicApi() {
        return SIPublicApi.getUsersByPublicApi(USERS_ITEMS_PER_PAGE, ZERO, SORT_ORDER_SIGN.get(DESC), DATE_CREATED)
                .stream()
                .filter(user -> ACTIVE.getStatus().equalsIgnoreCase(user.getStatus()) &&
                        INTERNAl_USER_TYPE.equals(user.getUserType()) && nonNull(user.getRole()) &&
                        nonNull(user.getUsername()));
    }

    public static List<String> getAllActiveInternalUsers(String format) {
        return getUsers(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT_BY, DEFAULT_SORT)
                .getPayload().getData().stream().filter(userData -> userData.getStatus().equals(ACTIVE.getStatus()) &&
                        INTERNAl_USER_TYPE.equals(userData.getUserType()) && nonNull(userData.getRole()) &&
                        nonNull(userData.getUsername()))
                .map(user -> String.format(format, user.getFirstName(), user.getLastName(), user.getUsername()))
                .collect(Collectors.toList());
    }

    public static UserAppApiPayload getUserDataById(String userId) {
        UserRetrieveRequest request = new UserRetrieveRequest().setId(userId);
        return parseResponseBody(postUntilExpectedStatusCode(Endpoints.USERS_RETRIEVE_BY_ID, given().body(request)),
                                 UserAppApiPayload.class);
    }

    public static void updateUser(UserAppApiPayload.UserPayload request) {
        String encodedUrl = getEncoder().encodeToString(URL.getBytes());
        given().body(request)
                .expect().statusCode(SC_OK)
                .when().post(Endpoints.USERS_UPDATE, encodedUrl);
    }

    public static void postRefData(String typeName, String valueType, Value value) {
        RefDataRequest request = getRefDataRequest(getValueType(typeName).get_id(), valueType, value);
        given().body(request).when().post(REFDATA_APPEND);
    }

    public static EmailTemplatesResponse getEmailTemplates() {
        Response response = given().when()
                .queryParam(LIMIT, ALL_ITEMS)
                .queryParam(SKIP, ZERO)
                .queryParam(SORT, ASC)
                .queryParam(SORT_BY, APIConstants.NAME)
                .queryParam(LANGUAGE_IDS, Languages.EN.getApiCode())
                .post(EMAIL_TEMPLATE_RETRIEVE_ALL);
        return getResponseJsonPathAsObject(response, PAYLOAD, EmailTemplatesResponse.class);
    }

    public static void postEmailTemplates(EmailTemplatesResponse.EmailTemplate request) {
        given().body(singletonList(request)).expect().statusCode(SC_OK).when().post(EMAIL_TEMPLATE_UPDATE);
    }

    public static Response getRefDataResponse(String id) {
        RefDataListRetrieveRequest request = new RefDataListRetrieveRequest()
                .setSortBy(APIConstants.NAME)
                .setSortType(ASC)
                .set_id(id);
        return given().body(request).post(Endpoints.REFDATA_RETRIEVE_BY_ID_SORT);
    }

    public static List<OrganizationPayload.ObjectsItem> getMyOrganizationFullDetails(String endpoint) {
        MyOrganizationRequest request = getMyOrganizationRequest();
        Response response = given()
                .body(request)
                .queryParam(LIMIT, ALL_ITEMS)
                .queryParam(CLIENT_ORGANIZATION_ID, retrieveClientOrganization().getPayload().getId())
                .queryParam(SKIP, ZERO)
                .queryParam(SORT, ASC)
                .post(endpoint);
        return getResponseJsonPathAsObject(response, PAYLOAD, OrganizationPayload.class).getObjects();
    }

    public static List<String> getMyOrganizationDetails(String endpoint) {
        return getMyOrganizationFullDetails(endpoint).stream().map(OrganizationPayload.ObjectsItem::getName)
                .collect(Collectors.toList());
    }

    public static void deleteMyOrganization(String endpoint, String id) {
        given().body(new MyOrganizationRequest().setId(id))
                .post(endpoint)
                .then().assertThat().body(MESSAGE, equalTo(SUCCESS));
    }

}
