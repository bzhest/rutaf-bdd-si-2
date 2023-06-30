package com.refinitiv.asts.test.ui.api;

import com.google.api.client.util.Strings;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.model.*;
import com.refinitiv.asts.test.ui.api.model.activityFilters.*;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ApproverProcessRules;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.Approvers;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ProcessRuleRequest;
import com.refinitiv.asts.test.ui.api.model.countryChecklist.CountyChecklistRequest;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.CreateCustomFieldRequest;
import com.refinitiv.asts.test.ui.api.model.externalUser.MyProfileContactsRequest;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldItem;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckRequest;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckUpdateRequest;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnaireRequest;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnairesResponseData;
import com.refinitiv.asts.test.ui.api.model.questionnaires.Reviewer;
import com.refinitiv.asts.test.ui.api.model.reviewProcess.ReviewProcessRequest;
import com.refinitiv.asts.test.ui.api.model.reviewProcess.ReviewProcessRules;
import com.refinitiv.asts.test.ui.api.model.reviewProcess.Reviewers;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ThirdPartyFilterRequest;
import com.refinitiv.asts.test.ui.api.model.user.UserRequestPayload;
import com.refinitiv.asts.test.ui.api.model.userRole.UserRoleRequest;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataRequest;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.CustomFieldData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.GroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.countryChecklist.CountryChecklistData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessDataAPI;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.*;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import io.restassured.response.Response;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.getResponseJsonPath;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getReferencesCountries;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getReferencesRegions;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getQuestionnairesReviewerConfig;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COMMA;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE_TO_REPLACE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.API_DATE_FORMAT;
import static java.lang.String.format;
import static java.util.Collections.singletonList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;

public class ApiRequestBuilder {

    private static final String WORKFLOW_ID_FILTER = "workflowGroup.find { it.name == '%s' }.id";
    public static final String REF_UID_FILTER = "payload.find { it.name == '%s' }.uid";
    private static final String STATUS_TRUE = "true";
    private static final String STATUS_FALSE = "false";
    private static final int ORDER_NUMBER = 99999;
    private static final String clientId = Config.get().value("client.id");
    public static final String NAME = "name";
    public static final String SUPPLIER_MANAGER = "supplierManager";
    public static final String LIKE = "LIKE";
    public static final String EQUAL = "EQUAL";
    public static final String AND = "AND";
    public static final String DEFAULT_REVIEWER = "responsible-party";
    public static final String ALL = "All";
    public static final String NEW_TO_OLD = "NEW_TO_OLD";
    public static final String DEFAULT_ACTIVITY_FILTER_TYPE = "SET";
    public static final String NOT_STARTED_STATUS = "Not Started";
    public static final String DONE_STATUS = "Done";
    public static final List<String> QUESTIONNAIRE_VALUES_STATUSES =
            List.of("Unresponded", "Save as Draft", "Responded", "Submitted", "In Review", "Requires Revision",
                    "Revision in Draft", "Revision Submitted");
    public static final List<String> APPROVAL_REVIEW_ACTIVITY_STATUSES =
            List.of("Pending", "Rejected", "Pending for Assignment");
    public static final List<String> DUE_DILIGENCE_STATUSES = List.of("NEW", "PENDING", "IN_PROGRESS", "ON_HOLD");
    public static final List<String> ASSIGNED_ACTIVITY_STATUSES =
            List.of("Not Started", "Deferral", "Waiting", "In Progress");
    private static final String DEFAULT_WORKFLOW_GROUP_NAME = "Default";

    public static AssociatedPartyIndividualCreateRequest buildCreateAssociatedPartyIndividualRequest(
            AssociatedPartyIndividualData associatedPartyIndividualData, String thirdPartyId) {
        return new AssociatedPartyIndividualCreateRequest()
                .setAddresses(singletonList(getAssociatedPartyAddress(associatedPartyIndividualData)))
                .setAutoScreen(nonNull(associatedPartyIndividualData.getAutoScreen()) ?
                                       associatedPartyIndividualData.getAutoScreen() : false)
                .setContactInformation(getContact(associatedPartyIndividualData))
                .setDescription(associatedPartyIndividualData.getDescription())
                .setFirstName(associatedPartyIndividualData.getFirstName())
                .setActive(nonNull(associatedPartyIndividualData.getIsEnabledAsUser()) ?
                                   associatedPartyIndividualData.getIsEnabledAsUser() : false)
                .setPrincipal(nonNull(associatedPartyIndividualData.getIsPrincipal()) ?
                                      associatedPartyIndividualData.getIsPrincipal() : false)
                .setLastName(associatedPartyIndividualData.getLastName())
                .setMiddleName(associatedPartyIndividualData.getMiddleName())
                .setParent(thirdPartyId)
                .setTitle(associatedPartyIndividualData.getTitle());
    }

    public static AssociatedPartyOranisationCreateRequest buildCreateAssociatedPartyOrganizationRequest(
            AssociatedPartyOrganisationData associatedPartyData, String thirdPartyId) {
        return new AssociatedPartyOranisationCreateRequest().setAddress(
                        getAssociatedPartyAddress(associatedPartyData))
                .setAutoScreen(
                        nonNull(associatedPartyData.getAutoScreen()) ? associatedPartyData.getAutoScreen() : false)
                .setContactInformation(getContact(associatedPartyData))
                .setDescription(associatedPartyData.getDescription())
                .setActive(false)
                .setParent(thirdPartyId)
                .setName(associatedPartyData.getName());
    }

    public static MyProfileContactsRequest buildGetContactsRequest(String thirdPartyId) {
        return new MyProfileContactsRequest()
                .setClientId(clientId)
                .setObjectId(thirdPartyId)
                .setObjectType(SUPPLIER_INFORMATION);
    }

    @SuppressWarnings("unchecked")
    public static CreateSupplierRequest buildCreateSupplierRequest(ThirdPartyData supplierData,
            Response refData,
            Response workflowGroups,
            String userName) {
        String workFlowGroupName = Objects.isNull(supplierData.getWorkflowGroup()) ?
                DEFAULT_WORKFLOW_GROUP_NAME : supplierData.getWorkflowGroup();
        String workflowGroupId =
                (String) getResponseJsonPath(workflowGroups, format(WORKFLOW_ID_FILTER, workFlowGroupName));
        List<String> divisions = Objects.isNull(supplierData.getDivision()) ?
                (List<String>) getUserDataByEmail(userName, DIVISIONS_NAME_FILTER) :
                List.of(supplierData.getDivision().split(COMMA));
        return new CreateSupplierRequest().setName(supplierData.getName())
                .setAddress(getAddress(supplierData, refData))
                .setResponsibleParty(userName)
                .setDivisions(divisions)
                .setWorkflowGroupId(workflowGroupId)
                .setAttachments(supplierData.getAttachments())
                .setIndustryType(supplierData.getIndustryType());
    }

    public static CreateCustomFieldRequest buildCreateCustomFieldRequest(CustomFieldData customField) {
        return new CreateCustomFieldRequest()
                .setName(customField.getName())
                .setDescription(customField.getDescription())
                .setStatus(customField.getStatus())
                .setType(customField.getType())
                .setOptions(customField.getOptions())
                .setRequired(customField.getRequired())
                .setUsePredefinedValues(customField.getUsePredefinedValues())
                .setOrderNumber(ORDER_NUMBER);
    }

    public static CreateCustomFieldRequest buildUpdateCustomFieldRequest(CustomFieldItem customField) {
        return new CreateCustomFieldRequest()
                .setName(customField.getName())
                .setDescription(customField.getDescription())
                .setStatus(customField.getStatus())
                .setType(customField.getType())
                .setOptions(customField.getOptions())
                .setRequired(customField.isRequired())
                .setUsePredefinedValues(customField.getUsePredefinedValues())
                .setOrderNumber(customField.getOrderNumber());
    }

    public static UserManagementGroup buildUserGroupRequest(GroupData userGroup) {
        List<UserManagementGroup.Users> users = new ArrayList<>();
        int bound = userGroup.getEmail().size();
        for (int i = 0; i < bound; i++) {
            UserManagementGroup.Users setName = new UserManagementGroup.Users().setEmail(userGroup.getEmail().get(i))
                    .setName(userGroup.getUsername().get(i));
            users.add(setName);
        }
        return new UserManagementGroup()
                .setName(userGroup.getGroupName())
                .setDescription(userGroup.getDescription())
                .setStatus(userGroup.getStatus())
                .setUsers(users);
    }

    public static ProcessRuleRequest buildProcessRuleRequest(ApprovalProcessData processRule) {
        ApproverProcessRules[] approverProcessRules =
                {
                        processRule.getApproverProcessRules()
                                .setApprovers(processRule.getApproverProcessRules().getApprovers())
                                .setCoverage(processRule.getApproverProcessRules().getCoverage())
                                .setMethod(processRule.getApproverProcessRules().getMethod())
                };
        Approvers[] approvers = {
                processRule.getApprovers()
                        .setEmail(processRule.getApprovers().getEmail())
                        .setName(processRule.getApprovers().getName())
        };
        return new ProcessRuleRequest()
                .setName(processRule.getName())
                .setDescription(processRule.getDescription())
                .setType(processRule.getType())
                .setStatus(processRule.getStatus())
                .setApproverProcessRules(approverProcessRules)
                .setApprovers(approvers);
    }

    public static ReviewProcessRequest buildReviewProcessRequest(ReviewProcessDataAPI processRule) {
        ReviewProcessRules[] reviewProcessRules =
                {
                        processRule.getReviewProcessRules()
                                .setReviewers(processRule.getReviewProcessRules().getReviewers())
                                .setMethod(processRule.getReviewProcessRules().getMethod())
                                .setCoverage(processRule.getReviewProcessRules().getCoverage())
                };
        Reviewers[] reviewers = {
                processRule.getReviewers()
                        .setEmail(processRule.getReviewers().getEmail())
                        .setName(processRule.getReviewers().getName())
        };
        return new ReviewProcessRequest()
                .setName(processRule.getName())
                .setDescription(processRule.getDescription())
                .setType(processRule.getType())
                .setStatus(processRule.getStatus())
                .setReviewProcessRules(reviewProcessRules)
                .setReviewers(reviewers);
    }

    public static CountyChecklistRequest buildCountyChecklistRequest(CountryChecklistData countryChecklistData) {
        return new CountyChecklistRequest()
                .setAlertMessage(countryChecklistData.getAlertMessage())
                .setAlertType(countryChecklistData.getAlertType())
                .setListName(countryChecklistData.getListName())
                .setStatus(countryChecklistData.getStatus())
                .setCountryList(countryChecklistData.getCountryList());
    }

    public static QuestionnaireRequest buildInactivateQuestionnaireRequest(QuestionnairesResponseData questionnaire) {
        return new QuestionnaireRequest()
                .setAction(STATUS_TRUE)
                .setCategoryId(questionnaire.getCategoryId())
                .setDescription(questionnaire.getDescription())
                .setDraft(true)
                .setHeader(questionnaire.getHeader())
                .setInternal(Boolean.toString(questionnaire.getInternal()))
                .setIsDraft(true)
                .setLanguageIds(questionnaire.getLanguageIds())
                .setMaxScore(questionnaire.getMaxScore())
                .setMinScore(questionnaire.getMinScore())
                .setName(questionnaire.getName())
                .setQuestionnaireScores(questionnaire.getQuestionnaireScores())
                .setQuestionnaireTabs(questionnaire.getQuestionnaireTabs())
                .setReviewer(new Reviewer().setType(DEFAULT_REVIEWER))
                .setReviewerProcessRules(questionnaire.getReviewerProcessRules())
                .setStatus(STATUS_FALSE)
                .setQuestionnaireReviewerId(questionnaire.getQuestionnaireReviewerId())
                .setQuestionnaireReviewer(getQuestionnairesReviewerConfig(questionnaire.getQuestionnaireReviewerId()));
    }

    public static RefDataRequest getRefDataRequest(RefDataResponse refDataResponse, String riskRangeId) {
        return new RefDataRequest().setCategory(refDataResponse.getCategory())
                .setDateCreated(refDataResponse.getDateCreated())
                .setDateUpdated(refDataResponse.getDateUpdated())
                .setIsDeleted(refDataResponse.getIsDeleted())
                .setListValues(singletonList(new Value().set_id(riskRangeId)))
                .setName(refDataResponse.getName())
                .setSortable(refDataResponse.getSortable())
                .setValueType(refDataResponse.getValueType())
                .set_id(refDataResponse.get_id());
    }

    public static MyOrganizationRequest getMyOrganizationRequest() {
        return new MyOrganizationRequest().setClientId(clientId);
    }

    public static UserRoleRequest getUserRoleRequest(String name, String sortType, String sortBy) {
        return new UserRoleRequest().setName(name)
                .setSort(new UserRoleRequest.Sort().setSortBy(sortBy).setSortType(sortType));
    }

    public static RefDataRequest getRefDataRequest(String id, String valueType, Value value) {
        return new RefDataRequest()
                .set_id(id)
                .setValueType(valueType)
                .setListValues(singletonList(value));
    }

    private static Address getAddress(ThirdPartyData supplierData, Response refData) {
        String countryCode = (String) getResponseJsonPath(refData, format(REF_UID_FILTER,
                                                                          supplierData.getCountry()));
        return new Address().setCountry(countryCode)
                .setCity(supplierData.getCity())
                .setAddressLine(supplierData.getAddressLine())
                .setCountryObj(getCountryObject(supplierData, countryCode))
                .setPostalCode(supplierData.getZipCode())
                .setProvince(supplierData.getStateProvince());
    }

    private static Address.CountryObject getCountryObject(ThirdPartyData supplierData, String countryCode) {
        return new Address.CountryObject()
                .setObject(new Reference()
                                   .setCode(countryCode)
                                   .setDescription(supplierData.getCountry()));
    }

    private static Contact getContact(AssociatedPartyContactInterface associatedPartyContactInterface) {
        List<String> email = Strings.isNullOrEmpty(associatedPartyContactInterface.getEmailAddress()) ? null :
                singletonList(associatedPartyContactInterface.getEmailAddress());
        return new Contact().setEmail(email);
    }

    private static AssociatedPartyAddress getAssociatedPartyAddress(
            AssociatedPartyAddressInterface associatedPartyAddressData) {
        String regionCode = null;
        String countryCode = null;
        SiPublicReferencesResponse referencesRegions = getReferencesRegions();
        SiPublicReferencesResponse referencesCountries = getReferencesCountries();
        if (nonNull(
                associatedPartyAddressData.getRegion()) &&
                associatedPartyAddressData.getRegion().equals(VALUE_TO_REPLACE)) {
            regionCode = referencesRegions.getData().get(0).getCode();
        } else if (nonNull(associatedPartyAddressData.getRegion())) {
            SiPublicReferencesResponse.Reference regionData = referencesRegions.getData().stream()
                    .filter(region -> region.getDescription().equals(associatedPartyAddressData.getRegion()))
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException(
                            "Region wasn't find with name " + associatedPartyAddressData.getRegion()));
            regionCode = regionData.getCode();
        }
        if (nonNull(associatedPartyAddressData.getAddressCountry())) {
            SiPublicReferencesResponse.Reference countryData = referencesCountries.getData().stream()
                    .filter(country -> country.getDescription().equals(associatedPartyAddressData.getAddressCountry()))
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException(
                            "Country wasn't find with name " + associatedPartyAddressData.getAddressCountry()));
            countryCode = countryData.getCode();
        }
        return new AssociatedPartyAddress().setAddressLine(associatedPartyAddressData.getAddressLine())
                .setCity(associatedPartyAddressData.getCity())
                .setProvince(associatedPartyAddressData.getStateProvince())
                .setPostalCode(associatedPartyAddressData.getZipCode())
                .setRegion(regionCode)
                .setCountry(countryCode);
    }

    public static UserRequestPayload getUserRequest(int userCount, String userType, String sortBy, String sortOrder,
            boolean isActive) {
        return new UserRequestPayload()
                .setFields(Collections.emptyList())
                .setCurrentPage(1)
                .setFilter(new UserRequestPayload.Filter().setUserType_name(userType).setActive(isActive))
                .setLimit(userCount)
                .setSortOrder(sortOrder)
                .setSortBy(sortBy);
    }

    public static ThirdPartyFilterRequest.CriteriaItem getCriteriaItem(String field, String func, String pvalue) {
        return new ThirdPartyFilterRequest.CriteriaItem().setField(field)
                .setCustomField(false)
                .setFunc(func)
                .setPvalue(pvalue);
    }

    public static ThirdPartyFilterRequest getThirdPartyNameFilterRequest(String field, String func, String pvalue) {
        ThirdPartyFilterRequest.CriteriaItem criteriaItem = getCriteriaItem(field, func, pvalue);
        return getThirdPartyNameFilterRequest(singletonList(criteriaItem));
    }

    public static ThirdPartyFilterRequest getThirdPartyNameFilterRequest(
            List<ThirdPartyFilterRequest.CriteriaItem> criteriaItems) {
        return new ThirdPartyFilterRequest()
                .setCriteria(criteriaItems)
                .setDefaultOperator(AND);
    }

    public static MediaCheckUpdateRequest turnOnAllCheckTypes(String searchName, String countryCode) {
        return new MediaCheckUpdateRequest().setCheckType(
                        new MediaCheckUpdateRequest.CheckType().setMediaCheck(true).setWorldCheck(true).setWatchList(true))
                .setCountry(countryCode)
                .setName(searchName);
    }

    public static MediaCheckRequest getMediaCheckRequest(int paginationNumber) {
        String nowAsISO = DateUtil.getTodayDate(API_DATE_FORMAT);
        String minDate = DateUtil.getDateTimeBeforeYear(API_DATE_FORMAT, 2);
        MediaCheckRequest.PublicationDate publicationDate = new MediaCheckRequest.PublicationDate()
                .setMax(nowAsISO)
                .setMin(minDate);
        MediaCheckRequest.BaseFilter baseFilter = new MediaCheckRequest.BaseFilter()
                .setReviewRequiredArticles(true)
                .setSmartFilter(true)
                .setQuery(EMPTY)
                .setPublicationDate(publicationDate);
        MediaCheckRequest.Pagination pagination = new MediaCheckRequest.Pagination()
                .setItemsPerPage(paginationNumber)
                .setSort(NEW_TO_OLD)
                .setPageReference(EMPTY);
        return new MediaCheckRequest()
                .setBaseFilter(baseFilter)
                .setPagination(pagination);
    }

    public static MediaCheckRequest getMediaCheckRequestWithPublicationDate(int paginationNumber, String minDate,
            String maxDate) {
        MediaCheckRequest.PublicationDate publicationDate = new MediaCheckRequest.PublicationDate()
                .setMax(maxDate)
                .setMin(minDate);
        MediaCheckRequest.BaseFilter baseFilter = new MediaCheckRequest.BaseFilter()
                .setReviewRequiredArticles(true)
                .setSmartFilter(true)
                .setQuery(EMPTY)
                .setPublicationDate(publicationDate);
        MediaCheckRequest.Pagination pagination = new MediaCheckRequest.Pagination()
                .setItemsPerPage(paginationNumber)
                .setSort(NEW_TO_OLD)
                .setPageReference(EMPTY);
        return new MediaCheckRequest()
                .setBaseFilter(baseFilter)
                .setPagination(pagination);
    }

    public static MediaCheckRequest getMediaCheckPageReferenceRequest(int paginationNumber, String pageReference,
            String minDate, String maxDate) {
        MediaCheckRequest.PublicationDate publicationDate = new MediaCheckRequest.PublicationDate()
                .setMax(maxDate)
                .setMin(minDate);
        MediaCheckRequest.BaseFilter baseFilter = new MediaCheckRequest.BaseFilter()
                .setReviewRequiredArticles(true)
                .setSmartFilter(true)
                .setQuery(EMPTY)
                .setPublicationDate(publicationDate);
        MediaCheckRequest.Pagination pagination = new MediaCheckRequest.Pagination()
                .setItemsPerPage(paginationNumber)
                .setSort(NEW_TO_OLD)
                .setPageReference(pageReference);
        return new MediaCheckRequest()
                .setBaseFilter(baseFilter)
                .setPagination(pagination);
    }

    public static ActivityMetricsFiltersRequest getAssignedActivitiesFiltersRequest(String apiActivityReportType) {
        Status status = new Status().setValues(ASSIGNED_ACTIVITY_STATUSES)
                .setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ActivityMetricsFiltersRequest requestBody = new ActivityMetricsFiltersRequest();
        requestBody.setType(apiActivityReportType);
        requestBody.setFilters(new Filters().setStatus(status));
        return requestBody;
    }

    public static ActivityMetricsFiltersRequest getApprovalsActivitiesFiltersRequest(String apiActivityReportType) {
        List<String> statuses = List.of(NOT_STARTED_STATUS);
        Status status = new Status().setValues(statuses).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ApprovalStatus approvalStatus = new ApprovalStatus().setValues(
                APPROVAL_REVIEW_ACTIVITY_STATUSES).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ActivityMetricsFiltersRequest requestBody = new ActivityMetricsFiltersRequest();
        requestBody.setType(apiActivityReportType);
        requestBody.setFilters(new Filters().setStatus(status).setApprovalStatus(approvalStatus));
        return requestBody;
    }

    public static ActivityMetricsFiltersRequest getReviewsActivitiesFiltersRequest(String apiActivityReportType) {
        List<String> statuses = List.of(DONE_STATUS);
        Status status = new Status().setValues(statuses).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ReviewStatus reviewStatus = new ReviewStatus().setValues(
                APPROVAL_REVIEW_ACTIVITY_STATUSES).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ActivityMetricsFiltersRequest requestBody = new ActivityMetricsFiltersRequest();
        requestBody.setType(apiActivityReportType);
        requestBody.setFilters(new Filters().setStatus(status).setReviewStatus(reviewStatus));
        return requestBody;
    }

    public static ActivityMetricsFiltersRequest getQuestionnaireFiltersRequest(String questionnaireTypeValue,
            String apiActivityReportType) {
        Status status =
                new Status().setValues(QUESTIONNAIRE_VALUES_STATUSES).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        QuestionnaireType questionnaireType = new QuestionnaireType().setValues(
                List.of(questionnaireTypeValue)).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ActivityMetricsFiltersRequest requestBody = new ActivityMetricsFiltersRequest();
        requestBody.setType(apiActivityReportType);
        requestBody.setFilters(new Filters().setStatus(status).setQuestionnaireType(questionnaireType));
        return requestBody;
    }

    public static ActivityMetricsFiltersRequest getDueDiligenceFiltersRequest(String apiActivityReportType) {
        Status status = new Status().setValues(DUE_DILIGENCE_STATUSES).setFilterType(DEFAULT_ACTIVITY_FILTER_TYPE);
        ActivityMetricsFiltersRequest requestBody = new ActivityMetricsFiltersRequest();
        requestBody.setType(apiActivityReportType);
        requestBody.setFilters(new Filters().setStatus(status));
        return requestBody;
    }

}
