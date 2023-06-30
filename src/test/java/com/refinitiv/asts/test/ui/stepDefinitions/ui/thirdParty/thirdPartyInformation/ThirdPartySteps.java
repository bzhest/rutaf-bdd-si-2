package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.CreateSupplierRequest;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldItem;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.dataproviders.DataProvider;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.*;
import com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.CustomFieldsManagementPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.ThirdPartyFieldsPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts.ContactsPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ThirdPartyInformationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DdOrdersData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.OnboardingActivityData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.AssertJUnit;
import org.testng.TestException;
import org.testng.asserts.SoftAssert;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildCreateSupplierRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.ALL_ITEMS;
import static com.refinitiv.asts.test.ui.api.AppApi.FIFTY;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.*;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.*;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.triggerRenewalUpdate;
import static com.refinitiv.asts.test.ui.constants.APIConstants.SAME_DIVISION;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.enums.ActivityFields.ASSIGNED_TO;
import static com.refinitiv.asts.test.ui.enums.ActivityFields.DUE_DATE;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.Colors.getColorRgba;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.REFERENCE_NO;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.CURRENCY;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.*;
import static com.refinitiv.asts.test.ui.enums.WorkflowType.ONBOARDING;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.SCORE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.wc1.CaseDataBuilder.getCaseName;
import static com.refinitiv.asts.test.ui.utils.wc1.CaseDataBuilder.getCaseSecondaryFieldValue;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.getSearchId;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCaseResponseStatusFromWCo;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Arrays.stream;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.apache.http.HttpStatus.SC_NOT_FOUND;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.Assert.assertFalse;
import static org.testng.Assert.assertTrue;
import static org.testng.AssertJUnit.assertEquals;

public class ThirdPartySteps extends BaseSteps {

    private static final String BANK = "Bank ";
    private static final String EMPTY_WORD = "EMPTY";
    private final ThirdPartyInformationPage thirdPartyPage;
    private final ThirdPartyFieldsPage thirdPartyFieldsPage;
    private final CustomFieldsManagementPage customFieldsManagementPage;
    private final ContactsPage contactsPage;
    private String selectedRegionName;

    public ThirdPartySteps(ScenarioCtxtWrapper context) {
        super(context);
        this.thirdPartyPage = new ThirdPartyInformationPage(this.driver, this.context, this.translator);
        this.thirdPartyFieldsPage = new ThirdPartyFieldsPage(this.driver, this.context);
        this.customFieldsManagementPage = new CustomFieldsManagementPage(this.driver);
        this.contactsPage = new ContactsPage(this.driver, this.context, this.translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ThirdPartyData thirdPartyEntry(Map<String, String> entry) {
        return new ThirdPartyData().
                setReferenceNo(entry.get(REFERENCE_NO.getDefaultName())).
                setName(entry.get(GeneralInformationFields.NAME.getDefaultName())).
                setCompanyType(entry.get(GeneralInformationFields.COMPANY_TYPE.getDefaultName())).
                setOrganisationSize(entry.get(GeneralInformationFields.ORGANISATION_SIZE.getDefaultName())).
                setDateOfIncorporation(entry.get(GeneralInformationFields.DATE_OF_INCORPORATION.getDefaultName())).
                setResponsibleParty(entry.get(GeneralInformationFields.RESPONSIBLE_PARTY.getDefaultName())).
                setDivision(entry.get(GeneralInformationFields.DIVISION.getDefaultName())).
                setWorkflowGroup(entry.get(GeneralInformationFields.WORKFLOW_GROUP.getDefaultName())).
                setCurrency(entry.get(GeneralInformationFields.CURRENCY.getDefaultName())).
                setIndustryType(entry.get(GeneralInformationFields.INDUSTRY_TYPE.getDefaultName())).
                setBusinessCategory(entry.get(GeneralInformationFields.BUSINESS_CATEGORY.getDefaultName())).
                setRevenue(entry.get(GeneralInformationFields.REVENUE.getDefaultName())).
                setLiquidationDate(entry.get(GeneralInformationFields.LIQUIDATION_DATE.getDefaultName())).
                setAffiliation(entry.get(GeneralInformationFields.AFFILIATION.getDefaultName())).
                setSpendCategory(entry.get(ThirdPartySegmentationFields.SPEND_CATEGORY.getDefaultName())).
                setDesignAgreement(entry.get(ThirdPartySegmentationFields.DESIGN_AGREEMENT.getDefaultName())).
                setRelationshipVisibility(
                        entry.get(ThirdPartySegmentationFields.RELATIONSHIP_VISIBILITY.getDefaultName())).
                setCommodityType(entry.get(ThirdPartySegmentationFields.COMMODITY_TYPE.getDefaultName())).
                setSourcingMethod(entry.get(ThirdPartySegmentationFields.SOURCING_METHOD.getDefaultName())).
                setSourcingType(entry.get(ThirdPartySegmentationFields.SOURCING_TYPE.getDefaultName())).
                setProductImpact(entry.get(ThirdPartySegmentationFields.PRODUCT_IMPACT.getDefaultName())).
                setBankName(entry.get(BankDetailsFields.BANK_NAME.getDefaultName())).
                setAccountNo(entry.get(BankDetailsFields.ACCOUNT_NO.getDefaultName())).
                setBranchName(entry.get(BankDetailsFields.BRANCH_NAME.getDefaultName())).
                setBankAddressLine(entry.get(BANK + BankDetailsFields.ADDRESS_LINE.getDefaultName())).
                setBankCity(entry.get(BANK + BankDetailsFields.CITY.getDefaultName())).
                setBankCountry(entry.get(BANK + BankDetailsFields.COUNTRY.getDefaultName())).
                setAddressLine(entry.get(AddressFields.ADDRESS_LINE.getDefaultName())).
                setCity(entry.get(AddressFields.CITY.getDefaultName())).
                setZipCode(entry.get(AddressFields.ZIP_POSTAL_CODE.getDefaultName())).
                setStateProvince(entry.get(AddressFields.STATE_PROVINCE.getDefaultName())).
                setRegion(entry.get(AddressFields.REGION.getDefaultName())).
                setCountry(entry.get(AddressFields.COUNTRY.getDefaultName())).
                setPhoneNumber(entry.get(ContactFields.PHONE_NUMBER.getDefaultName())).
                setFax(entry.get(ContactFields.FAX.getDefaultName())).
                setWebsite(entry.get(ContactFields.WEBSITE.getDefaultName())).
                setEmailAddress(entry.get(ContactFields.EMAIL_ADDRESS.getDefaultName())).
                setDescription(entry.get(DESCRIPTION)).
                setSearchTerm(entry.get(ScreeningCriteriaFields.SEARCH_TERM.getName())).
                setCountryOfRegistration(entry.get(ScreeningCriteriaFields.COUNTRY_OF_LOCATION.getName())).
                setScore(nonNull(entry.get(SCORE)) ? Double.parseDouble(entry.get(SCORE)) : null);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public OnboardingActivityData activityEntry(Map<String, String> entry) {
        return new OnboardingActivityData(
                entry.get(ActivityFields.NAME.getName()),
                entry.get(ActivityFields.TYPE.getName()),
                entry.get(ASSIGNED_TO.getName()),
                entry.get(DUE_DATE.getName()),
                entry.get(ActivityFields.STATUS.getName()));
    }

    private List<OnboardingActivityData> updateActivityData(List<OnboardingActivityData> expectedResult) {
        expectedResult.forEach(result -> {
            if (nonNull(result.getDueDate())) {
                result.setDueDate(getDateAfterTodayDate(REACT_FORMAT, parseInt(
                        result.getDueDate().replace(TODAY, StringUtils.EMPTY))));
            }
            if (nonNull(result.getName()) && result.getName().contains(VALUE_TO_REPLACE)) {
                ThirdPartyData thirdParty =
                        (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
                result.setName(result.getName().replace(VALUE_TO_REPLACE, thirdParty.getName()));
            }
        });
        return expectedResult;
    }

    private void updateRevenueData(ThirdPartyData thirdPartyDataToEdit) {
        if (nonNull(thirdPartyDataToEdit.getRevenue()) && thirdPartyDataToEdit.getRevenue().equals(VALUE_TO_REPLACE)) {
            String revenue =
                    Arrays.stream(getRefDataPayload(getValueTypeId(REVENUE)).getListValues()).map(Value::getName)
                            .findFirst()
                            .orElse("No Available Revenue for selection!");
            thirdPartyDataToEdit.setRevenue(revenue);
        }
    }

    private void updateCommodityType(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getCommodityType()) &&
                thirdPartyTestData.getCommodityType().equals(VALUE_TO_REPLACE)) {
            String commodityType =
                    Arrays.stream(getRefDataPayload(getValueTypeId(COMMODITY_TYPE)).getListValues()).map(Value::getName)
                            .findFirst()
                            .orElse("No Available Commodity Type for selection!");
            thirdPartyTestData.setCommodityType(commodityType);
        }
    }

    private void validateButtonCondition(String buttonType, String buttonCondition, boolean result) {
        if (buttonCondition.equals(IS_NOT)) {
            assertThat(result).as(buttonType + " button is displayed").isFalse();
        } else {
            assertThat(result).as(buttonType + " button is not displayed").isTrue();
        }
    }

    /**
     * triggerRenewalUpdate() will make update Third Party status to "For Renewal" immediately without 5-10 min await
     */
    @When("User updates renewal date and waits for renewal process completion")
    public void updateRenewalDate() {
        thirdPartyPage.closeToastMessageIfDisplayed();
        thirdPartyPage.fillRenewalCurrentDate();
        thirdPartyPage.fillRenewalCycle(StringUtils.EMPTY);
        thirdPartyPage.clickAssessmentSaveButton();
        triggerRenewalUpdate();
    }

    @When("User clicks Assessment edit button")
    public void clickAssessmentEditButton() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyPage.closeToastMessageIfDisplayed();
        thirdPartyPage.clickAssessmentEditButton();
    }

    @When("User clicks {string} third-party button")
    public void clickThirdPartyButton(String elementName) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.clickOn(elementName);
    }

    @When("User waits and clicks {string} third-party button")
    public void waitAndClickThirdPartyButton(String elementName) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.waitAndClickOn(elementName);
    }

    @When("User clicks on {string} tab on Third-party page")
    public void clickOnTab(String tabName) {
        thirdPartyPage.clickOn(tabName);
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks on ADD ASSOCIATED PARTY button")
    public void clickOnAddContactButton() {
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
        contactsPage.clickAddAssociatedPartyButton();
        contactsPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on Create Order under Due Diligence Order section")
    public void clickOnCreateOrderUnderDueDiligenceOrderSection() {
        thirdPartyPage.clickOnCreateOrderButton();
    }

    @When("User clicks {string} component tab")
    public void clickNewComponentTab(String componentName) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.clickComponentTab(componentName);
    }

    @When("^User clicks General and Other Information section \"(Save|Edit|Cancel)\" button$")
    public void clicksGeneralInformationSectionButton(String buttonType) {
        thirdPartyPage.closeToastMessageIfDisplayed();
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        switch (buttonType) {
            case SAVE:
                thirdPartyPage.clickGeneralInformationSectionSaveButton();
                break;
            case EDIT:
                thirdPartyPage.clickGeneralInformationSectionEditButton();
                break;
            case CANCEL:
                thirdPartyPage.clickGeneralInformationSectionCancelButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        if (thirdPartyPage.isDuplicateCheckPopupDisplayed()) {
            thirdPartyPage.clickDuplicateCheckConfirmButton();
        }
    }

    @When("^User (expands|collapses) \"(Other Information|Third-party Segmentation|General Information|Address|Contact|Bank Details|Description|Related Files|General and Other Information)\" section$")
    public void expandOtherNameSection(String state, String section) {
        if (state.contains(EXPAND)) {
            thirdPartyPage.expandSectionIfCollapsed(section);
        } else {
            thirdPartyPage.collapseSection(section);
        }
    }

    @When("User clicks Bank Details section \"Add\" button$")
    public void clicksBankDetailsSectionSaveButton() {
        thirdPartyPage.clickBankDetailsSectionAddButton();
    }

    @When("^User clicks Assessment Details section \"(Save|Edit|Cancel)\" button$")
    public void clickAssessmentDetailsSectionButton(String buttonType) {
        switch (buttonType) {
            case SAVE:
                thirdPartyPage.clickAssessmentDetailsSaveButton();
                break;
            case EDIT:
                thirdPartyPage.clickAssessmentDetailsEditButton();
                break;
            case CANCEL:
                thirdPartyPage.clickAssessmentDetailsCancelButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User fills third-party creation form with third-party's test data {string}")
    public void fillInThirdPartyForm(String thirdPartyReference) {
        ThirdPartyData thirdPartyTestData =
                new JsonUiDataTransfer<ThirdPartyData>(DataProvider.THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        if (thirdPartyTestData.getName().isEmpty()) {
            thirdPartyTestData.setName(AUTO_TEST_NAME_PREFIX + randomUUID().toString().replaceAll("-", "_"));
        }
        if (nonNull(thirdPartyTestData.getReferenceNo())
                && thirdPartyTestData.getReferenceNo().isEmpty()) {
            thirdPartyTestData.setReferenceNo("Test_Ref_No_" + randomUUID());
        }
        if (nonNull(thirdPartyTestData.getRegion())
                && (thirdPartyTestData.getRegion().isEmpty()
                || thirdPartyTestData.getRegion().contains(VALUE_TO_REPLACE))) {
            thirdPartyTestData.setRegion(getAvailableRegionNames().get(0));
        }
        selectedRegionName = thirdPartyTestData.getRegion();
        if (nonNull(thirdPartyTestData.getCountry())
                && thirdPartyTestData.getCountry().isEmpty()) {
            thirdPartyTestData
                    .setCountry(
                            getAvailableCountriesForRegion(getRegionIdByName(thirdPartyTestData.getRegion())).get(0));
        }
        if (nonNull(thirdPartyTestData.getWorkflowGroup()) &&
                thirdPartyTestData.getWorkflowGroup().equals(WORKFLOW_GROUP_NAME_CONTEXT)) {
            thirdPartyTestData.setWorkflowGroup(
                    (String) context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT));
        }
//        TODO remove this part when RMS-28297 will be fixed
        if (System.getProperty("os.name").equalsIgnoreCase("LINUX")) {
            thirdPartyTestData.setDateOfIncorporation(null).setLiquidationDate(null);
        }
        updateRevenueData(thirdPartyTestData);
        updateCommodityType(thirdPartyTestData);
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyPage.waitWhileLoadingImageIsDisappeared();
        thirdPartyPage.fillInGeneralInformationDetails(thirdPartyTestData);
        thirdPartyPage.fillInThirdPartySegmentationDetails(thirdPartyTestData);
        thirdPartyPage.fillInBankDetails(thirdPartyTestData);
        thirdPartyPage.fillInAddressDetails(thirdPartyTestData);
        thirdPartyPage.fillInContactDetails(thirdPartyTestData);
        thirdPartyPage.fillInDescription(thirdPartyTestData.getDescription());
        if (TODAY_LABEL.equals(thirdPartyTestData.getLiquidationDate())) {
            thirdPartyTestData.setLiquidationDate(getDateAfterTodayDate(REACT_FORMAT, 0));
        }
        if (TODAY_LABEL.equals(thirdPartyTestData.getDateOfIncorporation())) {
            thirdPartyTestData.setDateOfIncorporation(getDateAfterTodayDate(REACT_FORMAT, 0));
        }
        this.context.getScenarioContext().setContext(THIRD_PARTY_DATA_CONTEXT, thirdPartyTestData);
        this.context.getScenarioContext().setContext(THIRD_PARTY_NAME, thirdPartyTestData.getName());
        this.context.getScenarioContext().setContext(thirdPartyReference, thirdPartyTestData.getName());

    }

    @When("User expands the add third-party screening criteria accordion if it is collapsed")
    public void expandThirdPartyScreeningCriteriaAccordion() {
        if (thirdPartyPage.isScreeningAccordionCollapsed()) {
            thirdPartyPage.clickOnScreeningAccordion();
        }
    }

    @When("User submits Third-party creation form")
    public void submitThirdPartyForm() {
        thirdPartyPage.clickSaveThirdPartyButton();
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        if (thirdPartyPage.isDuplicateCheckPopupDisplayed()) {
            thirdPartyPage.clickDuplicateCheckConfirmButton();
        }
    }

    @When("User clicks 'Save and New' Add Third-party button")
    public void clickSaveAndNew() {
        thirdPartyPage.clickSaveAndNewButton();
    }

    @When("User clicks 'Cancel' Add Third-party button")
    public void clickCancel() {
        thirdPartyPage.clickCancelButton();
    }

    @When("User clicks Start Onboarding for third-party")
    public void clickStartThirdPartyOnboarding() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        int count = 0;
        int maxTries = 5;
        while (!ONBOARDING.getType().toUpperCase().equals(thirdPartyPage.getThirdPartyStatus()) &&
                !thirdPartyPage.isElementInvisible(START_ONBOARDING_BUTTON) && count++ < maxTries) {
            thirdPartyPage.clickOn(START_ONBOARDING_BUTTON);
            thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        }
        if (!thirdPartyPage.isElementInvisible(START_ONBOARDING_BUTTON)) {
            throw new TestException("Onboarding is not started. Update Third-party's workflow settings");
        }
        context.getScenarioContext().setContext(IS_ONBOARDING_STARTED, true);
        if (context.getScenarioContext().isContains(THIRD_PARTY_ID)) {
            String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
            context.getScenarioContext().setContext(ACTIVITY_ID, getLastActivityId(thirdPartyId));
        }
    }

    @When("User clicks {string} for third-party")
    public void clickRenewSupplier(String buttonName) {
        thirdPartyPage.clickOn(buttonName);
    }

    @When("^User (collapses|expands) section \"((.*))\" for third-party$")
    public void collapseOrExpandSectionForThirdParty(String state, String sectionName) {
        if (state.contains(EXPAND)) {
            thirdPartyPage.expandSectionIfCollapsed(sectionName);
        } else {
            thirdPartyPage.collapseSection(sectionName);
        }
    }

    @When("User clicks Offboard button")
    public void clickOffboardButton() {
        thirdPartyPage.clickOn(OFFBOARD_BUTTON);
    }

    @When("User clicks on {string} activity")
    public void clickOnActivity(String activity) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(10);
        thirdPartyPage.clickActivity(activity);
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(10);
    }

    @When("User clicks edit {string} activity row button")
    public void clickEditActivity(String activity) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.clickEditActivity(activity);
    }

    @When("User updates General Information section with values")
    public void updatesGeneralInformation(ThirdPartyData thirdPartyDataToEdit) {
        if (nonNull(thirdPartyDataToEdit.getReferenceNo())) {
            thirdPartyDataToEdit.setReferenceNo(AUTO_TEST_NAME_PREFIX + randomUUID());
        }
        //        TODO remove this part when RMS-28297 will be fixed
        if (System.getProperty("os.name").equalsIgnoreCase("LINUX")) {
            thirdPartyDataToEdit.setDateOfIncorporation(null).setLiquidationDate(null);
        }
        updateRevenueData(thirdPartyDataToEdit);
        thirdPartyPage.fillInGeneralInformationDetails(thirdPartyDataToEdit);
        if (TODAY_LABEL.equals(thirdPartyDataToEdit.getLiquidationDate())) {
            thirdPartyDataToEdit.setLiquidationDate(getDateAfterTodayDate(REACT_FORMAT, 0));
        }
        if (TODAY_LABEL.equals(thirdPartyDataToEdit.getDateOfIncorporation())) {
            thirdPartyDataToEdit.setDateOfIncorporation(getDateAfterTodayDate(REACT_FORMAT, 0));
        }
        context.getScenarioContext().setContext(GENERAL_INFORMATION_DATA_REFERENCE, thirdPartyDataToEdit);
    }

    @When("User updates Third-party Segmentation section with values")
    public void updateThirdPartySegmentationSection(ThirdPartyData thirdPartyDataToEdit) {
        updateCommodityType(thirdPartyDataToEdit);
        thirdPartyPage.fillInThirdPartySegmentationDetails(thirdPartyDataToEdit);
        context.getScenarioContext().setContext(THIRD_PARTY_SEGMENTATION_DATA_REFERENCE, thirdPartyDataToEdit);
    }

    @When("User updates Bank Details on position {int} with values")
    public void updateBankDetailsFieldsSection(int bankPosition, ThirdPartyData thirdPartyDataToEdit) {
        thirdPartyPage.closeToastMessageIfDisplayed();
        thirdPartyPage.fillInProfileEditBankDetails(thirdPartyDataToEdit, bankPosition);
        context.getScenarioContext().setContext(BANK_DETAILS_DATA_REFERENCE + bankPosition, thirdPartyDataToEdit);
    }

    @When("User updates Address section with values")
    public void updateAddressSection(ThirdPartyData thirdPartyDataToEdit) {
        if (nonNull(thirdPartyDataToEdit.getRegion()) && !thirdPartyDataToEdit.getRegion().isEmpty()) {
            thirdPartyDataToEdit.setRegion(getAvailableRegionNames().get(0));
        }
        if (isNull(thirdPartyDataToEdit.getCountry()) || thirdPartyDataToEdit.getCountry().isEmpty()
                && nonNull(thirdPartyDataToEdit.getRegion())) {
            thirdPartyDataToEdit
                    .setCountry(
                            getAvailableCountriesForRegion(getRegionIdByName(thirdPartyDataToEdit.getRegion())).get(0));
        }
        thirdPartyPage.fillInAddressDetails(thirdPartyDataToEdit);
        context.getScenarioContext().setContext(ADDRESS_DATA_REFERENCE, thirdPartyDataToEdit);
    }

    @When("User updates Contact section with values")
    public void updatesContactSection(ThirdPartyData thirdPartyDataToEdit) {
        thirdPartyPage.fillInContactDetails(thirdPartyDataToEdit);
        context.getScenarioContext().setContext(CONTACT_DATA_REFERENCE, thirdPartyDataToEdit);
    }

    @When("User updates Description section with text {string}")
    public void updateDescriptionSection(String description) {
        thirdPartyPage.fillInDescription(description);
        context.getScenarioContext().setContext(DESCRIPTION_REFERENCE, description);
    }

    @When("User clicks 'i' icon button")
    public void clickIIconButton() {
        thirdPartyPage.clickInfoAddressIcon();
    }

    @When("^User clicks Add File \"(Add|Browse)\" button$")
    public void clicksAddFileModalButton(String buttonType) {
        switch (buttonType) {
            case ADD:
                thirdPartyPage.clickUploadFileButton();
                break;
            case BROWSE:
                thirdPartyPage.clickBrowseFileButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User populates file description with text {string}")
    public void populateFileDescriptionWithText(String description) {
        thirdPartyPage.fillInFileDescription(description);
    }

    @When("User clicks close component button")
    public void clickCloseComponentButton() {
        thirdPartyPage.clickCloseActivityOverview();
    }

    @When("User updates Renewal Cycle with value {string}")
    public void updateRenewalCycleWithValue(String value) {
        thirdPartyPage.fillInRenewalCycle(value);
    }

    @When("User clears 'Division' Add Third-party form field")
    public void clearDivisionField() {
        thirdPartyPage.cleanDivisionField();
    }

    @When("User selects {string} country in Country drop-down")
    public void selectCountry(String countryName) {
        thirdPartyPage.selectThirdPartyAddressCountry(countryName);
    }

    @When("User selects {string} country in Bank Details Country drop-down")
    public void selectBankDetailsCountry(String countryName) {
        thirdPartyPage.selectBankCountry(countryName);
    }

    @When("User selects {string} country in Edit Profile Country drop-down")
    public void selectCountryEditProfile(String countryName) {
        thirdPartyPage.selectThirdPartyAddressCountry(countryName);
    }

    @When("User selects Country that doesn't belong to any Country Checklist")
    public void selectCountryNotBelongToCountryChecklist() {
        String countryName = getCountryWithoutChecklist();
        selectCountry(countryName);
    }

    @When("User selects Bank Details Country that doesn't belong to any Country Checklist")
    public void selectBankDetailsCountryNotBelongToCountryChecklist() {
        String countryName = getCountryWithoutChecklist();
        thirdPartyPage.selectBankCountry(countryName);
    }

    @When("User opens DD order with status {string}")
    public void openLastDDOrder(String status) {
        thirdPartyPage.openOrderWithStatus(status);
    }

    @When("User clicks 'sort DD orders icon' on {string}")
    public void clickSortDdOrdersIcon(String columnName) {
        thirdPartyPage.sortDdOrders(columnName);
    }

    @When("User clicks Same as address country checkbox of Country of Registration")
    public void checkSameAsAddressCountry() {
        thirdPartyPage.clickSameAsAddressCountryCheckbox();
    }

    @When("User fills Country Of Registration {string} Value")
    public void fillInCountryOfRegistration(String country) {
        thirdPartyPage.fillInScreeningCriteria(country);
    }

    @When("User fills Phone number {string} Value Row {string} of Contact section")
    public void fillInPhoneNumberRow(String phoneNumber, String row) {
        thirdPartyPage.fillInPhoneNumber(phoneNumber, row);
    }

    @When("User clicks Add Phone Number")
    public void checkAddPhoneNumber() {
        thirdPartyPage.clickAddPhoneNumber();
    }

    @When("User changes Search Term current value {string} with value {string}")
    public void changeSearchCriteriaWithValue(String currentValue, String newValue) {
        thirdPartyPage.updateSearchTermValue(currentValue, newValue);
    }

    @When("User clicks on Ongoing Screening {string}")
    public void clickOngoingScreening(String ongoingName) {
        thirdPartyPage.clickOngoingScreening(ongoingName);
    }

    @When("User clicks on Third-party Information tab")
    public void clickThirdPartyInformationTab() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.clickThirdPartyInformationTab();
    }

    @When("User deletes Third-Party name current value {string}")
    public void deleteThirdPartyName(String currentValue) {
        thirdPartyPage.clearThirdPartyNameValue(currentValue);
    }

    @When("User saves third-party data")
    public void saveThirdPartyData() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        context.getScenarioContext()
                .setContext(THIRD_PARTY_DATA_CONTEXT, thirdPartyPage.getThirdPartyInformationDetails());
    }

    @When("User clicks Remove Bank Details button for bank on position {int}")
    public void clickRemoveBankDetailsButtonForBankOnPosition(int bankPosition) {
        thirdPartyPage.clickRemoveBankButton(bankPosition);
    }

    @When("User clicks delete button for {string} division")
    public void clickDeleteButtonForDivision(String divisionName) {
        thirdPartyPage.clickDeleteDivisionButton(divisionName);
    }

    @When("User fills in {string} custom field value {string}")
    public void fillInCustomFieldValue(String customFieldName, String customFieldValue) {
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        if (customFieldName.equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            customFieldName = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        }
        thirdPartyPage.fillInCustomField(customFieldName, customFieldValue);
    }

    @When("User selects {string} custom field value {string}")
    public void selectCustomFieldValue(String customFieldName, String customFieldValue) {
        if (customFieldName.equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            customFieldName = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        }
        if (customFieldName.contains(CUSTOM_FIELD_NAME_NUMBER_CONTEXT)) {
            String customFieldIndex = customFieldName.substring(21);
            customFieldName = (String) context.getScenarioContext()
                    .getContext(CUSTOM_FIELD_NAME_NUMBER_CONTEXT + customFieldIndex);
        }
        thirdPartyPage.selectCustomFieldOption(customFieldName, customFieldValue);
    }

    @When("User adds {string} value to {string} custom field")
    public void addCustomFieldValue(String customFieldValue, String customFieldName) {
        if (customFieldName.equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            customFieldName = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        }
        if (customFieldName.contains(CUSTOM_FIELD_NAME_NUMBER_CONTEXT)) {
            String customFieldIndex = customFieldName.substring(21);
            customFieldName = (String) context.getScenarioContext()
                    .getContext(CUSTOM_FIELD_NAME_NUMBER_CONTEXT + customFieldIndex);
        }
        thirdPartyPage.selectCustomFieldOptionWithoutClearing(customFieldName, customFieldValue);
    }

    @When("User fills in Reference No. existing data")
    public void fillInReferenceNoExistingData() {
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyPage.fillInReferenceNo(thirdPartyData);
    }

    @When("User adds Third-party attachment")
    public void addThirdPartyAttachment(List<Attachment> attachments) {
        attachments.forEach(attachment -> {
            thirdPartyPage.uploadFile(attachment.getFilename());
            thirdPartyPage.addModalDescription(attachment.getDescription());
            thirdPartyPage.clickUploadFileButton();
        });
    }

    @When("User selects first Address Region")
    public void selectFirstAddressRegion() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyPage.expandSectionIfCollapsed(PageElementNames.ADDRESS);
        selectedRegionName = getAvailableRegionNames().get(0);
        thirdPartyPage.selectRegion(selectedRegionName);
    }

    @When("User changes Notification Recipients assignee to {string}")
    public void changeNotificationRecipientsAssignee(String recipientName) {
        thirdPartyPage.changeNotificationRecipient(recipientName);
    }

    @When("User selects other group {int}")
    public void selectOtherGroup(int groupIndex) {
        thirdPartyPage.selectGroup(groupIndex);
    }

    @When("User hovers to Groups field")
    public void hoverToGroupsField() {
        thirdPartyPage.hoverToGroups();
    }

    @When("User hovers to groups dropdown {int}")
    public void hoverToGroupsDropDown(int groupIndex) {
        thirdPartyPage.hoverToGroupsDropDown(groupIndex);
    }

    @When("User creates third-parties with name and data {string} via API if it is absent")
    public void createThirdPartiesWithNameViaAPIIfItIsAbsent(String thirdPartyReference, List<String> names) {
        thirdPartyFieldsPage.setDefaultThirdPartyFieldsManagementValues();
        customFieldsManagementPage.unsetRequiredFromCustomFieldsViaApi();
        ThirdPartyData thirdPartyData =
                new JsonUiDataTransfer<ThirdPartyData>(THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        Response refDataResponse;
        if (context.getScenarioContext().isContains(REF_DATA_RESPONSE)) {
            refDataResponse = (Response) context.getScenarioContext().getContext(REF_DATA_RESPONSE);
        } else {
            refDataResponse = getPostRefDataRetrieveListResponse(ValueType.REF_COUNTRY.getName());
            context.getScenarioContext().setContext(REF_DATA_RESPONSE, refDataResponse);
        }
        Response workflowGroup;
        if (context.getScenarioContext().isContains(WORKFLOW_GROUP)) {
            workflowGroup = (Response) context.getScenarioContext().getContext(WORKFLOW_GROUP);
        } else {
            workflowGroup = getWorkflowGroupResponse();
            context.getScenarioContext().setContext(WORKFLOW_GROUP, workflowGroup);
        }
        UserData userData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        names.forEach(name -> {
            if (isNull(getThirdPartyByName(name, SAME_DIVISION, FIFTY))) {
                thirdPartyData.setName(name);
                CreateSupplierRequest request = buildCreateSupplierRequest(thirdPartyData,
                                                                           refDataResponse,
                                                                           workflowGroup,
                                                                           userData.getUsername());
                if (isNull(createSupplier(request))) {
                    throw new RuntimeException(format("Third-party with name %s is not created ", name));
                }
            } else {
                logger.info(format("Third-party with name %s already exist", name));
            }
        });
    }

    @When("User clicks all Close alert icon buttons")
    public void clickCloseAlertIcon() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        int count = 1;
        int maxTries = 5;
        while (count++ <= maxTries && thirdPartyPage.isCloseAlertIconButtonDisplayed()) {
            thirdPartyPage.closeAlertIconIfDisplayed();
            thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        }
    }

    @Then("WC1 case contains {string} provided {string} {string} secondary field")
    public void wcCaseContainsProvidedSecondaryField(String expectedSecondaryField, String secondaryFieldName,
            String resultsFor) {
        String actualSecondaryField = getCaseSecondaryFieldValue(context, resultsFor,
                                                                 SecondaryFieldType.valueOf(secondaryFieldName)
                                                                         .getTypeId());
        assertEquals("WC1 case secondary field doesn't match expected ", expectedSecondaryField, actualSecondaryField);
    }

    @Then("WC1 case contains empty {string} {string} secondary field")
    public void wcCaseContainsEmptySecondaryField(String secondaryFieldName, String resultsFor) {
        String actualSecondaryField = getCaseSecondaryFieldValue(context, resultsFor,
                                                                 SecondaryFieldType.valueOf(secondaryFieldName)
                                                                         .getTypeId());
        assertEquals("WC1 case secondary field doesn't match expected ", StringUtils.EMPTY, actualSecondaryField);
    }

    @Then("WC1 case contains {string} {string} name")
    public void wcCaseContainsName(String expectedName, String resultsFor) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String actualName = getCaseName(context, resultsFor);
        assertEquals("WC1 case name doesn't match expected ", expectedName, actualName);
    }

    @Then("The case {string} is deleted from WC1")
    public void theCaseIsDeletedFromWC(String referenceId) {
        final String searchId;
        if (referenceId.equals(OTHER_NAME_ID)) {
            searchId = (String) context.getScenarioContext().getContext(referenceId);
        } else {
            searchId = getSearchId(context, referenceId);
        }
        assertThat(getCaseResponseStatusFromWCo(searchId))
                .as("Case with ID: %s is still present in WC1", searchId)
                .isEqualTo(SC_NOT_FOUND);
    }

    @Then("User verifies third-party is created")
    public void verifyThirdPartyWasCreated() {
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        AssertJUnit.assertTrue("Third-party page is not loaded or Third-party is not saved",
                               thirdPartyPage.isPageLoaded());
        String thirdPartyId = getLastCreatedThirdPartyIdByName(thirdPartyData.getName(), SAME_DIVISION);
        this.context.getScenarioContext().setContext(THIRD_PARTY_ID, thirdPartyId);
        logger.info("New third-party with name '" + thirdPartyData.getName() + "' added successful");
        logger.info("New third-party ID: " + thirdPartyId);
    }

    @Then("Save button is disappeared")
    public void saveButtonIsDisappeared() {
        AssertJUnit.assertTrue("Save button is visible still", thirdPartyPage.isSaveButtonDisappeared());
    }

    @Then("{string} section for third-party is displayed between {string} and {string} sections")
    public void forThirdPartyIsDisplayedBetweenAndSections(String testedSection, String beforeSection,
            String afterSection) {
        AssertJUnit.assertTrue("Other Names section is not right after Description Section",
                               thirdPartyPage.isSectionBeforeOtherSection(beforeSection, testedSection));
        AssertJUnit.assertTrue("Other Names section is not right before Screening Section",
                               thirdPartyPage.isSectionBeforeOtherSection(testedSection, afterSection));
    }

    @Then("{string} section for add contact is displayed between {string} and {string} sections")
    public void forAddContactIsDisplayedBetweenAndSections(String testedSection, String beforeSection,
            String afterSection) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        AssertJUnit.assertTrue(testedSection + " for add contact section is not right after " + beforeSection,
                               thirdPartyPage.isAddContactSectionBeforeOtherSection(beforeSection, testedSection));
        AssertJUnit.assertTrue(testedSection + " for add contact section is not right before " + afterSection,
                               thirdPartyPage.isAddContactSectionBeforeOtherSection(testedSection, afterSection));
    }

    @Then("{string} section for add third-party is displayed between {string} and {string} sections")
    public void forAddThirdPartyIsDisplayedBetweenAndSections(String testedSection, String beforeSection,
            String afterSection) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        AssertJUnit.assertTrue("Other Names section is not right before Description Section",
                               thirdPartyPage.isSectionBeforeOtherSectionOnAddThirdParty(beforeSection, testedSection));
        AssertJUnit.assertTrue("Other Names section is not right after Screening Section",
                               thirdPartyPage.isSectionBeforeOtherSectionOnAddThirdParty(testedSection, afterSection));
    }

    @Then("Third-party {string} address details contains {string}")
    public void thirdPartyAddressDetailsContains(String fieldName, String expectedValue) {
        assertEquals(fieldName + " third-party address details doesn't contain expected data",
                     expectedValue, thirdPartyPage.getAddressDetailsValue(fieldName));
    }

    @Then("Third-party Information details are displayed with populated data")
    public void thirdPartyInformationDetailsAreDisplayedWithPopulatedData() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(10);
        ThirdPartyData expectedResult =
                (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        ThirdPartyData actualResult = thirdPartyPage.getThirdPartyInformationDetails();
        assertThat(actualResult).as("Third-party Information details are not expected").usingRecursiveComparison()
                .ignoringExpectedNullFields().isEqualTo(expectedResult);
    }

    @Then("Third-party {string} General Information section's field contains {string}")
    public void validateThirdPartyGeneralInformationFieldValue(String fieldName, String expectedValue) {
        thirdPartyPage.scrollToGeneralInformation();
        assertEquals(fieldName + " third-party General Information section doesn't contain expected data",
                     expectedValue, thirdPartyPage.getGeneralInformationValue(fieldName));
    }

    @Then("General Information section details are displayed with populated data")
    public void validateGeneralInformationSectionData() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(GENERAL_INFORMATION_DATA_REFERENCE);
        ThirdPartyData actualResult = thirdPartyPage.getGeneralInformationSectionDetails();
        assertThat(actualResult).as("General Information section details are not expected").usingRecursiveComparison()
                .ignoringExpectedNullFields().isEqualTo(expectedResult);
    }

    @Then("General Information section details are displayed with populated data ignoring null fields")
    public void validateGeneralInformationSectionDataIgnoringFields(List<String> ignoreFields) {
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(GENERAL_INFORMATION_DATA_REFERENCE);
        expectedResult.setDateOfIncorporation(convertDateFormat(DATE_OF_INCORPORATION_FORMAT, REACT_FORMAT,
                                                                expectedResult.getDateOfIncorporation()));
        ThirdPartyData actualResult = thirdPartyPage.getGeneralInformationSectionDetails();
        assertThat(actualResult).as("General Information section details are not expected").usingRecursiveComparison()
                .ignoringFields(ignoreFields.toArray(new String[0])).isEqualTo(expectedResult);
    }

    @Then("Third-party Segmentation section details are displayed with populated data")
    public void validateThirdPartySegmentationSectionData() {
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_SEGMENTATION_DATA_REFERENCE);
        ThirdPartyData actualResult = thirdPartyPage.getThirdPartySegmentationSectionDetails();
        assertThat(actualResult)
                .as("Third-party Segmentation section details are not expected")
                .isEqualTo(expectedResult);
    }

    @Then("Bank Details section details are displayed with populated data on position {int}")
    public void validateBankDetailsSectionData(int bankPosition) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(BANK_DETAILS_DATA_REFERENCE + bankPosition);
        List<ThirdPartyData> actualResults = thirdPartyPage.getBankSectionDetails();
        assertThat(actualResults)
                .as("Bank Details section details are not displayed with populated data on position " + bankPosition)
                .contains(expectedResult);
    }

    @Then("Bank Details section details are not displayed with populated data on position {int}")
    public void validateBankDetailsSectionDataAreNotDisplayed(int bankPosition) {
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(BANK_DETAILS_DATA_REFERENCE + bankPosition);
        List<ThirdPartyData> actualResults = thirdPartyPage.getBankSectionDetails();
        assertThat(actualResults)
                .as("Bank Details section details are displayed with populated data on position " + bankPosition)
                .doesNotContain(expectedResult);
    }

    @Then("Address section details are displayed with populated data")
    public void validateAddressSectionData() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(ADDRESS_DATA_REFERENCE);
        ThirdPartyData actualResult = thirdPartyPage.getAddressSectionDetails();
        assertThat(actualResult)
                .as("Address section details are not expected")
                .isEqualTo(expectedResult);
    }

    @Then("Contact section details are displayed with populated data")
    public void validateContactSectionData() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(CONTACT_DATA_REFERENCE);
        ThirdPartyData actualResult = thirdPartyPage.getContactSectionDetails();
        assertEquals("Description section details are not expected", expectedResult, actualResult);
    }

    @Then("Screening Criteria section details are displayed with populated data")
    public void validateScreeningCriteriaSectionData() {
        ThirdPartyData expectedResult =
                (ThirdPartyData) context.getScenarioContext().getContext(SCREENING_CRITERIA_DATA_REFERENCE);
        ThirdPartyData actualResult = thirdPartyPage.getScreeningCriteriaSectionDetails();
        assertEquals("Screening Criteria section details are not expected", expectedResult, actualResult);
    }

    @Then("Description section details are displayed with populated data")
    public void validateDescriptionSectionData() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        String expectedResult = (String) context.getScenarioContext().getContext(DESCRIPTION_REFERENCE);
        String actualResult = thirdPartyPage.getDescription();
        assertEquals("Description section details are not expected", expectedResult, actualResult);
    }

    @Then("Onboarding Activities section is not displayed")
    public void validateOnboardingRenewalSectionDisappeared() {
        AssertJUnit.assertTrue("Onboarding/Renewal Activities section is displayed",
                               thirdPartyPage.isOnboardingRenewalDisappeared());
    }

    @Then("Alert Icon is displayed with text")
    public void alertIconIsDisplayedWithText(DataTable dataTable) {
        alertIconIsDisplayedWithText(thirdPartyPage, dataTable);
        thirdPartyPage.closeAlertIconIfDisplayed();
    }

    @Then("Alert Icons are displayed with text")
    public void alertIconsAreDisplayedWithText(List<String> alerts) {
        List<String> actualAlertMessages = thirdPartyPage.getAlertsIconText();
        assertThat(actualAlertMessages).as("Alert Icons are not displayed").isNotEmpty();
        assertThat(actualAlertMessages)
                .as("Actual alert message '%s' doesn't contain expected text '%s'", actualAlertMessages, alerts)
                .containsAll(alerts);
    }

    @Then("^\"((.*))\" 'i' icon button (is|is not) displayed beside add \"((.*))\" section$")
    public void iIconButtonIsDisplayedBesideBankDetailsSection(String iconType, String buttonState, String section) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        boolean result = thirdPartyPage.isSectionIconDisplayed(iconType, section);
        if (buttonState.equals(IS_NOT)) {
            assertThat(result).as(format("%s 'i' icon button is displayed beside add 'Address' section", iconType))
                    .isFalse();
        } else {
            assertThat(result).as(format("%s 'i' icon button is not displayed beside add 'Address' section", iconType))
                    .isTrue();
        }
    }

    @Then("^(?:Edit Address|Address) Country alert toast message is displayed$")
    public void countryAlertMessageToastMessageIsDisplayed() {
        List<String> actualAlertMessagedList = thirdPartyPage.getAddressCountryAlertToastMessage();
        assertThat(actualAlertMessagedList).as("Actual alert messages list is null").isNotNull();
    }

    @Then("^(?:Edit Address|Address) Country alert message (is|is not) displayed$")
    public void isCountryAlertMessageToastMessageIsDisplayed(String buttonState) {
        if (IS_NOT.equals(buttonState)) {
            assertThat(thirdPartyPage.isAddressCountryAlertToastMessageDisplayed())
                    .as("Alert message is displayed")
                    .isFalse();
        } else {
            assertThat(thirdPartyPage.isAddressCountryAlertToastMessageDisplayed())
                    .as("Alert message is not displayed")
                    .isTrue();
        }
    }

    @Then("^(?:Edit Address|Address) Country alert toast message (is|is not) displayed with text$")
    public void countryAlertMessageToastMessageIsDisplayedWithText(String buttonState,
            List<String> expectedAlertMessagesList) {
        List<String> actualAlertMessagedList = thirdPartyPage.getAddressCountryAlertToastMessage();
        SoftAssertions softAssert = new SoftAssertions();
        if (IS_NOT.equals(buttonState)) {
            expectedAlertMessagesList.forEach(
                    message -> softAssert.assertThat(actualAlertMessagedList)
                            .as("Actual alert messages: '%s' contain expected message '%s'", actualAlertMessagedList,
                                message)
                            .doesNotContain(message));
        } else {
            expectedAlertMessagesList.forEach(
                    message -> softAssert.assertThat(actualAlertMessagedList)
                            .as("Actual alert messages: '%s' doesn't contain expected message '%s'",
                                actualAlertMessagedList,
                                message)
                            .contains(message));
        }

        softAssert.assertAll();
    }

    @Then("Address Country alert toast message is not displayed")
    public void isCountryAlertMessageToastMessageDisplayed() {
        assertThat(thirdPartyPage.isAddressAlertMessageInvisible()).as("Alert Message toast message is displayed!")
                .isTrue();
    }

    @Then("Address Country alert toast message is disappeared")
    public void isCountryAlertMessageToastMessageDisappeared() {
        AssertJUnit.assertFalse("Alert Message toast message is still displayed!",
                                thirdPartyPage.isAddressAlertMessageDisappeared());
    }

    @Then("Created Custom Field is displayed in Other Information section")
    public void isCreatedCustomFieldDisplayedInOtherInfoSection() {
        String name = (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT);
        isCustomFieldDisplayedInOtherInfoSection(name);
    }

    @Then("Created Custom Field is displayed in Other Information section with value")
    public void isCreatedCustomFieldDisplayedWithValueInOtherInfoSection(String expectedValue) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String customFieldName = (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT);
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        assertThat(thirdPartyPage.getCustomFieldValue(customFieldName))
                .as("Custom Field " + customFieldName + " doesn't have expected value or not displayed")
                .isEqualTo(expectedValue);
    }

    @Then("Custom Field {string} is displayed in Other Information section")
    public void isCustomFieldDisplayedInOtherInfoSection(String name) {
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        if (VALUE_TO_REPLACE.equals(name)) {
            name = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT);
        }
        AssertJUnit.assertTrue("Custom Field is not displayed in Other Information section",
                               thirdPartyPage.isCustomFieldDisplayedInOtherInfoSection(name));
    }

    @Then("Related Files table displays column names")
    public void validateRelatedFilesTableDisplaysColumnNames(List<String> expectedColumnNames) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> files =
                expectedColumnNames.stream().map(translator::getValue).map(String::toUpperCase).collect(toList());
        assertEquals("Related Files table doesn't display expected column names", files,
                     thirdPartyPage.getFileTableColumnNames());
    }

    @Then("Related Files table displays file details")
    public void validateRelatedFilesTableDisplaysFileDetails(List<Attachment> attachments) {
        attachments.forEach(value -> value.setDateUploaded(getTodayDate(REACT_FORMAT)));
        assertThat(attachments)
                .as("Related Files table doesn't display expected file details")
                .isEqualTo(thirdPartyPage.getFileTableRowValues());
    }

    @Then("Third-party sections color should be highlighted red")
    public void checkThirdPartySectionColor(DataTable dataTable) {
        SoftAssertions softAssert = new SoftAssertions();
        dataTable.asList().forEach(section -> softAssert.assertThat(thirdPartyPage.getSectionTextColor(section))
                .as("Section '%s' is not red", section)
                .isEqualTo(REACT_RED.getColorRgba()));
        softAssert.assertAll();
    }

    @Then("Download icon is displayed for file with name {string}")
    public void downloadIconIsDisplayedForFileWithName(String fileName) {
        AssertJUnit.assertTrue("Download icon is not displayed for file with name " + fileName,
                               thirdPartyPage.isDownloadIconIsDisplayed(fileName));
    }

    @Then("Delete icon is displayed for file with name {string}")
    public void deleteIconIsDisplayedForFileWithName(String fileName) {
        AssertJUnit.assertTrue("Delete icon is displayed for file with name " + fileName,
                               thirdPartyPage.isDeleteIconIsDisplayed(fileName));
    }

    @Then("^\"(Browse|Description|Upload|Cancel)\" \"(button|input)\" in Related Files section is displayed$")
    public void validateRelatedFilesSectionElements(String element, String elementType) {
        boolean isElementDisplayed;
        switch (element) {
            case BROWSE:
                isElementDisplayed = thirdPartyPage.isBrowseButtonDisplayed();
                break;
            case DESCRIPTION:
                isElementDisplayed = thirdPartyPage.isDescriptionInputDisplayed();
                break;
            case UPLOAD:
                isElementDisplayed = thirdPartyPage.isUploadFileButtonDisplayed();
                break;
            case CANCEL:
                isElementDisplayed = thirdPartyPage.isCancelFileButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + element + " is unexpected");
        }
        AssertJUnit.assertTrue(element + SPACE + elementType + " Add File modal's is not displayed",
                               isElementDisplayed);
    }

    @Then("^(Renew|Stop Renewal|Decline Renewal) button should be invisible$")
    public void renewButtonShouldBeDisabled(String buttonName) {
        AssertJUnit.assertFalse(buttonName + " button is visible", thirdPartyPage.isButtonPresent(buttonName));
    }

    @Then("{string} button should disappear")
    public void buttonShouldDisappear(String buttonName) {
        assertThat(thirdPartyPage.isButtonDisappeared(buttonName))
                .as(buttonName + " button is not disappeared")
                .isTrue();
    }

    @Then("^(.* Date?) should be (EMPTY|TODAY\\+\\d*)$")
    public void checkOnboardingDate(String fieldName, String date) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String expectedDate = null;
        if (!date.equals(EMPTY_WORD)) {
            expectedDate = getDateAfterTodayDate(REACT_FORMAT,
                                                 parseInt(date.replace(TODAY, StringUtils.EMPTY)));
        }
        assertEquals(fieldName + " isn't correct -  " + thirdPartyPage.getOnboardingDate(fieldName),
                     expectedDate, thirdPartyPage.getOnboardingDate(fieldName));
    }

    @Then("^(.* Date?) field should be (shown|hidden)$")
    public void renewalStartDateField(String fieldName, String status) {
        if (status.equals(HIDDEN)) {
            AssertJUnit.assertTrue(fieldName + "field isn't hidden",
                                   thirdPartyPage.isOnboardingDateFieldDisappeared(fieldName));
        } else {
            AssertJUnit.assertTrue(fieldName + " field is not displayed",
                                   thirdPartyPage.isOnboardingDateDisplayed(fieldName));
        }
    }

    @Then("Third-party's onboarding workflow should be shown - {string}")
    public void checkThirdPartyOnboardingWorkflow(String workflow) {
        if (context.getScenarioContext().isContains(workflow)) {
            workflow = (String) context.getScenarioContext().getContext(workflow);
        }
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(thirdPartyPage.getThirdPartyOnboardingWorkflow())
                .as("Onboarding workflow is incorrect").isEqualTo(workflow);
    }

    @Then("Third-party's onboarding workflow description should be shown - {string}")
    public void checkThirdPartyOnboardingWorkflowDescription(String workflowDescription) {
        assertEquals("Onboarding workflow is incorrect", workflowDescription,
                     thirdPartyPage.getThirdPartyOnboardingWorkflowDescription());
    }

    @Then("Third-party's status should be shown - {string}")
    public void checkThirdPartyStatus(String thirdPartyStatus) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertEquals("Third-party status is incorrect", thirdPartyStatus,
                     thirdPartyPage.getThirdPartyStatus(thirdPartyStatus));
    }

    @Then("Third-party Information should have status field {string}")
    public void checkThirdPartyStatusField(String statusField) {
        assertThat(thirdPartyPage.getThirdPartyStatusField()).as("Status field is incorrect")
                .contains(statusField);
    }

    @Then("Activities table should contain the following columns")
    public void activitiesTableShouldContainTheFollowingColumns(DataTable dataTable) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> expectedResult = dataTable.asList();
        List<String> actualResult = thirdPartyPage.getActivityTableColumns();
        assertEquals("Activities table doesn't contain expected columns", expectedResult, actualResult);
    }

    @Then("Activities table should contain the following activity")
    public void activitiesTableShouldContainTheFollowingActivity(List<OnboardingActivityData> expectedResult) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(10);
        assertThat(thirdPartyPage.getActivityTableRows())
                .as("Activities table doesn't contain expected activity")
                .containsAll(updateActivityData(expectedResult));
    }

    @Then("Activities table doesn't contain the following activity")
    public void activitiesTableDoesNotTContainTheFollowingActivity(List<OnboardingActivityData> resultList) {
        assertThat(thirdPartyPage.getActivityTableRows())
                .as("Activities table contains unexpected activities")
                .doesNotContainAnyElementsOf(updateActivityData(resultList));
    }

    @Then("^Component Activity \"(.*)\" is (enabled|disabled)$")
    public void activityIsEnabled(String activityName, String activityStatus) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        boolean isDisabled = activityStatus.equalsIgnoreCase(DISABLED);
        assertThat(thirdPartyPage.isComponentActivityDisabled(activityName))
                .as("%s is not %s", activityName, activityStatus)
                .isEqualTo(isDisabled);
    }

    @Then("Component is closed")
    public void componentIsClosed() {
        AssertJUnit.assertFalse("Component is not closed", thirdPartyPage.isComponentDisplayed());
    }

    @Then("Activities table displays Activity {string} with Assignee {string}")
    public void activitiesTableDisplayCorrectAssignee(String activityName, String assignee) {
        OnboardingActivityData activityRowByActivityName = thirdPartyPage.getActivityRowByActivityName(activityName);
        assertThat(activityRowByActivityName.getAssignedTo())
                .as("Activity field 'Assigned to' is incorrect")
                .isEqualTo(assignee);
    }

    @Then("^Third-party's element \"(.*)\" should (be|not be) shown$")
    public void thirdPartyElementShouldNotBeShown(String element, String condition) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        if (condition.contains(NOT)) {
            assertThat(thirdPartyPage.isElementVisible(element))
                    .as("Element is shown on page -  " + element)
                    .isFalse();
        } else {
            assertThat(thirdPartyPage.isElementVisible(element))
                    .as("Element is not shown on page -  " + element)
                    .isTrue();
        }
    }

    @Then("^Third-party's button \"(.*)\" color is \"(.*)\"$")
    public void verifyThirdPartyButtonColor(String button, String colorName) {
        assertThat(thirdPartyPage.getElementColor(button))
                .as("Button %s color is unexpected")
                .isEqualTo(getColorRgba(colorName));
    }

    @Then("Assessment section field {string} is displayed")
    public void checkAssessmentSectionFieldIsDisplayed(String field) {
        assertTrue(thirdPartyPage.getAssessmentDetailsSectionText().contains(field),
                   format("Field '%s' is not displayed", field));
    }

    @Then("Assessment section field {string} is not displayed")
    public void checkAssessmentSectionFieldIsNotDisplayed(String field) {
        assertFalse(thirdPartyPage.getAssessmentDetailsSectionText().contains(field),
                    format("Field '%s' is displayed", field));
    }

    @Then("Component's {string} header swimlane text color is {string}")
    public void componentSHeaderSwimlaneTextColorIs(String componentName, String colorName) {
        String expectedColorRgba = getColorRgba(colorName);
        String actualColorRgba = thirdPartyPage.getComponentTabCSS(COLOR, componentName);
        assertEquals("Component's text color is unexpected", expectedColorRgba, actualColorRgba);
    }

    @Then("All component's activities have transparency coefficient {string}")
    public void allComponentsActivitiesHaveCorrectTransparency(String opacity) {
        SoftAssertions soft = new SoftAssertions();
        List<String> rowsOpacity = thirdPartyPage.getTableRowsCSS(OPACITY, opacity);
        rowsOpacity
                .forEach(rowColor -> soft.assertThat(rowColor)
                        .as("Component's rows opacity is unexpected")
                        .isEqualTo(opacity));
        soft.assertAll();
    }

    @Then("All component's activities are {string} color")
    public void allComponentSActivitiesAre(String colorName) {
        String expectedColorRgba = getColorRgba(colorName);
        List<String> actualColorsRgba = thirdPartyPage.getTableRowsCSS(BACKGROUND_COLOR, expectedColorRgba);
        actualColorsRgba
                .forEach(rowColor -> assertEquals("Component's rows color is unexpected", expectedColorRgba, rowColor));

    }

    @Then("{string} component's activity has opacity {string}")
    public void componentActivityHasCorrectOpacity(String activityName, String expectedOpacity) {
        String actualOpacity = thirdPartyPage.getTableRowCSS(activityName, OPACITY, expectedOpacity);
        assertThat(actualOpacity).as("Component's row opacity is unexpected").isEqualTo(expectedOpacity);
    }

    @Then("{string} component's activity is {string} color")
    public void componentSActivityIsColor(String activityName, String colorName) {
        String expectedColorRgba = getColorRgba(colorName);
        String actualColorsRgba = thirdPartyPage.getTableRowCSS(activityName, BACKGROUND_COLOR, expectedColorRgba);
        assertEquals("Component's row " + activityName + " color is unexpected", expectedColorRgba, actualColorsRgba);
    }

    @Then("Component's {string} tooltip is shown: {string}")
    public void componentSTooltipIsShown(String componentName, String expectedText) {
        assertEquals(format("Component's %s tooltip %s is not shown", componentName, expectedText), expectedText,
                     thirdPartyPage.getTooltipText(componentName));
    }

    @Then("General and Other Information section is not allowed for editing, as edit icon is disabled")
    public void verifyGeneralInfoSectionIsNotEditable() {
        assertThat(thirdPartyPage.isGeneralInfoSectionNotEditable())
                .as("General and Other Information section is editable")
                .isTrue();
    }

    @Then("Third-party Information tab is loaded")
    public void informationTabIsLoaded() {
        assertThat(thirdPartyPage.isPageLoaded()).as("Third-party Information tab is not displayed").isTrue();
    }

    @Then("Associated Parties tab is loaded")
    public void contactsTabIsLoaded() {
        assertThat(thirdPartyPage.isAssociatedPartiesTabLoaded()).as("Contacts tab is not displayed").isTrue();
    }

    @Then("Activity details table is loaded")
    public void checkActivityDetailsTableIsLoaded() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyPage.isComponentDisplayed();
    }

    @Then("Button {string} should be displayed and active on Third-party page")
    public void buttonShouldBeDisplayed(String buttonName) {
        assertThat(thirdPartyPage.isButtonPresent(buttonName))
                .as(buttonName + " is not present on Third-party screen")
                .isTrue();
        assertThat(thirdPartyPage.isButtonActive(buttonName))
                .as(buttonName + " is not active on Third-party screen")
                .isTrue();
    }

    @Then("Error message {string} in red color is displayed on field")
    public void errorMessageInRedColorIsDisplayedNearField(String errorMessage, DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        dataTable.asList().forEach(text -> {
            softAssert.assertTrue(thirdPartyPage.isFieldInvalidAriaDisplayed(text),
                                  "Input field invalid aria is not displayed");
            softAssert.assertEquals(thirdPartyPage.getElementErrorMessage(text), errorMessage,
                                    "Input field error message is not displayed");
            softAssert.assertEquals(thirdPartyPage.getErrorMessageElementCSS(text, COLOR),
                                    REACT_RED.getColorRgba(),
                                    "Input field error message is not red");
        });
        softAssert.assertAll();
    }

    @Then("Error message {string} in red color is displayed on Reference No. field")
    public void errorMessageInRedColorIsDisplayedNearField(String errorMessage) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(thirdPartyPage.getElementErrorMessage(REFERENCE_NO.getName()), errorMessage,
                                "Input field error message is not displayed");
        softAssert.assertEquals(thirdPartyPage.getErrorMessageElementCSS(REFERENCE_NO.getName(), COLOR),
                                REACT_RED.getColorRgba(),
                                "Input field error message is not red");
        softAssert.assertAll();
    }

    @Then("Error message {string} in red color is displayed on Address section on field")
    public void errorMessageInRedColorIsDisplayedNearAddressSectionField(String errorMessage, DataTable dataTable) {
        SoftAssert softAssert = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(ADDRESS);
        dataTable.asList()
                .forEach(text -> {
                    softAssert.assertTrue(thirdPartyPage.isAddressSectionFieldInvalidAriaDisplayed(text),
                                          "Address section input field invalid aria is not displayed");
                    softAssert.assertEquals(thirdPartyPage.getAddressSectionElementErrorMessage(text), errorMessage,
                                            "Address section input field error message is not displayed");
                    softAssert.assertEquals(thirdPartyPage.getAddressSectionErrorMessageElementCSS(text, COLOR),
                                            REACT_RED.getColorRgba(),
                                            "Address section input field error message is not red");
                });
        softAssert.assertAll();
    }

    @Then("Error message {string} in red color is displayed near on Screening Criteria section on field")
    public void errorMessageInRedColorIsDisplayedNearScreeningCriteriaSectionField(String errorMessage,
            String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(thirdPartyPage.isScreeningCriteriaSectionFieldInvalidAriaDisplayed(fieldName),
                              "Address section input field invalid aria is not displayed");
        softAssert.assertEquals(thirdPartyPage.getScreeningCriteriaSectionElementErrorMessage(fieldName), errorMessage,
                                "Address section input field error message is not displayed");
        softAssert.assertEquals(thirdPartyPage.getScreeningCriteriaSectionErrorMessageColor(fieldName, COLOR),
                                REACT_RED.getColorRgba(),
                                "Address section input field error message is not red");
        softAssert.assertAll();
    }

    @Then("Add Third-party window is displayed")
    public void addThirdPartyWindowIsDisplayed() {
        assertTrue(thirdPartyPage.isAddThirdPartyWindowDisplayed(), "Add Third-party window is not displayed");
    }

    @Then("Add Third-party window's button with name {string} is displayed and enabled")
    public void addThirdPartyWindowSButtonWithNameIsDisplayedAndEnabled(String buttonName) {
        assertTrue(thirdPartyPage.isAddThirdPartyWindowButtonDisplayed(buttonName),
                   "Add Third-party window's button is not displayed");
    }

    @Then("Third-party Information should have Assessment Details fields")
    public void checkThirdPartyInformationBlockHasAssessmentDetailsFields(DataTable table) {
        SoftAssert soft = new SoftAssert();
        table.asList().forEach(text -> soft.assertTrue(thirdPartyPage.isAssessmentDetailsFieldDisplayed(text),
                                                       "Field '" + text + "' isn't shown"));
        soft.assertAll();
    }

    @Then("^Third-Party section should be in correct state$")
    public void isThirdPartySectionCollapsed(DataTable dataTable) {
        Map<String, String> sectionStates = dataTable.asMap(String.class, String.class);
        SoftAssertions softAssertions = new SoftAssertions();
        sectionStates.forEach((sectionName, state) -> {
            if (HIDDEN.equals(state)) {
                softAssertions.assertThat(thirdPartyPage.isSectionDisplayed(sectionName))
                        .as("Section '%s' is displayed", sectionName, state)
                        .isFalse();
            } else {
                softAssertions.assertThat(thirdPartyPage.isSectionExpanded(sectionName))
                        .as("Section '%s' is not %s", sectionName, state)
                        .isEqualTo(EXPANDED.equals(state));
            }
        });
        softAssertions.assertAll();
    }

    @Then("^Third-Party section should be hidden$")
    public void isThirdPartySectionHidden(DataTable dataTable) {
        SoftAssertions softAssertions = new SoftAssertions();
        dataTable.asList()
                .forEach((sectionName) -> softAssertions.assertThat(thirdPartyPage.isSectionDisplayed(sectionName))
                        .as("Section '%s' is displayed", sectionName)
                        .isFalse());
        softAssertions.assertAll();
    }

    @Then("^General and Other Information inner sections are (displayed|not displayed)$")
    public void areAllGeneralAndOtherInformationSectionsAreHidden(String state) {
        assertThat(thirdPartyPage.areGeneralAndOtherInformationInnerSectionsDisplayed())
                .as("'General and Other Information' inner sections are not '%s'", state)
                .isEqualTo(DISPLAYED.equalsIgnoreCase(state));
    }

    @Then("^Third-party Information should (have|not have) General Information fields$")
    public void checkThirdPartyInformationBlockHasGeneralInformationFields(String state, DataTable table) {
        SoftAssert soft = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(GENERAL_INFORMATION);
        if (state.contains(NOT)) {
            table.asList().forEach(text -> soft.assertFalse(thirdPartyPage.isGeneralInformationFieldDisplayed(text),
                                                            "Field '" + text + "' is shown"));
        } else {
            table.asList().forEach(text -> soft.assertTrue(thirdPartyPage.isGeneralInformationFieldDisplayed(text),
                                                           "Field '" + text + "' isn't shown"));
        }
        soft.assertAll();
    }

    @Then("^Third-party Information should (have|not have) Third-party Segmentation fields$")
    public void checkThirdPartyInformationBlockHasThirdPartySegmentationFields(String state, DataTable table) {
        SoftAssert soft = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(THIRD_PARTY_SEGMENTATION);
        if (state.contains(NOT)) {
            table.asList().forEach(text -> soft.assertFalse(thirdPartyPage.isThirdPartySegmentationFieldDisplayed(text),
                                                            "Field '" + text + "' is shown"));
        } else {
            table.asList().forEach(text -> soft.assertTrue(thirdPartyPage.isThirdPartySegmentationFieldDisplayed(text),
                                                           "Field '" + text + "' isn't shown"));
        }
        soft.assertAll();
    }

    @Then("Third-party Information should have all Active Custom Fields fields")
    public void checkThirdPartyInformationBlockHasOtherInformationFields() {
        SoftAssert soft = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        List<String> customFieldsList = getCustomFields(ALL_ITEMS, ACTIVE.toUpperCase()).getObjects().stream()
                .map(CustomFieldItem::getName)
                .collect(Collectors.toList());
        customFieldsList.forEach(text -> soft.assertTrue(thirdPartyPage.isOtherInformationFieldDisplayed(text),
                                                         "Field '" + text + "' isn't shown"));
        soft.assertAll();
    }

    @Then("^Third-party Information \"((.*))\" field is (displayed|invisible)$")
    public void checkThirdPartyInformationContainsField(String expectedCustomField, String state) {
        if (expectedCustomField.equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            expectedCustomField = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        }
        if (state.equalsIgnoreCase(DISPLAYED)) {
            assertThat(thirdPartyPage.isOtherInformationFieldDisplayed(expectedCustomField))
                    .as("Field '" + expectedCustomField + "' isn't displayed")
                    .isTrue();
        } else {
            assertThat(thirdPartyPage.isOtherInformationFieldDisplayed(expectedCustomField))
                    .as("Field '" + expectedCustomField + "' isn't invisible")
                    .isFalse();
        }
    }

    @Then("^Third-party Information should (have|not have) Bank Details fields$")
    public void checkThirdPartyInformationBlockHasBankDetailsFields(String state, DataTable table) {
        SoftAssert soft = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(THIRD_PARTY_BANK_DETAILS);
        if (state.contains(NOT)) {
            table.asList().forEach(text -> soft.assertFalse(thirdPartyPage.isBankDetailsFieldDisplayed(text),
                                                            "Field '" + text + "' is shown"));
        } else {
            table.asList().forEach(text -> soft.assertTrue(thirdPartyPage.isBankDetailsFieldDisplayed(text),
                                                           "Field '" + text + "' isn't shown"));
        }
        soft.assertAll();
    }

    @Then("^Third-party Information should (have|not have) Address fields$")
    public void checkThirdPartyInformationBlockHasAddressFields(String state, DataTable table) {
        SoftAssert soft = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(ADDRESS);
        if (state.contains(NOT)) {
            table.asList().forEach(text -> soft.assertFalse(thirdPartyPage.isAddressFieldDisplayed(text),
                                                            "Field '" + text + "' is shown"));
        } else {
            table.asList().forEach(text -> soft.assertTrue(thirdPartyPage.isAddressFieldDisplayed(text),
                                                           "Field '" + text + "' isn't shown"));
        }
        soft.assertAll();
    }

    @Then("^Third-party Information should (have|not have) Contact fields$")
    public void checkThirdPartyInformationBlockHasContactFields(String state, DataTable table) {
        SoftAssert soft = new SoftAssert();
        thirdPartyPage.expandSectionIfCollapsed(CONTACT);
        if (state.contains(NOT)) {
            table.asList().forEach(text -> soft.assertFalse(thirdPartyPage.isContactFieldDisplayed(text),
                                                            "Field '" + text + "' is shown"));
        } else {
            table.asList().forEach(text -> soft.assertTrue(thirdPartyPage.isContactFieldDisplayed(text),
                                                           "Field '" + text + "' isn't shown"));
        }
        soft.assertAll();
    }

    @Then("Third-party Information should have Description for data {string}")
    public void checkThirdPartyInformationBlockHasDescription(String thirdPartyReference) {
        ThirdPartyData thirdPartyTestData =
                new JsonUiDataTransfer<ThirdPartyData>(DataProvider.THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        thirdPartyPage.expandSectionIfCollapsed(DESCRIPTION);
        assertThat(thirdPartyPage.getDescriptionValueText())
                .as("Description value '" + thirdPartyTestData.getDescription() + "' isn't correct")
                .isEqualTo(thirdPartyTestData.getDescription());
    }

    @Then("^Renewal Cycle input field should be (editable|not editable)")
    public void checkRenewalCycleInputIsShown(String isDisplayed) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        switch (isDisplayed) {
            case EDITABLE:
                assertThat(thirdPartyPage.isRenewalCycleReadonly())
                        .as("Renewal Cycle input field isn't editable")
                        .isFalse();
                break;
            case NOT_EDITABLE:
                assertThat(thirdPartyPage.isRenewalCycleReadonly())
                        .as("Renewal Cycle input field is editable")
                        .isTrue();
                break;
            default:
                throw new IllegalArgumentException("Field state: " + isDisplayed + " is unexpected");
        }
    }

    @Then("^Assessment Details button \"(Save|Cancel)\" (is not|is) displayed")
    public void checkAssessmentDetailsButtonVisibility(String buttonType, String buttonCondition) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        boolean result;
        switch (buttonType) {
            case SAVE:
                result = thirdPartyPage.isAssessmentDetailsSaveButtonDisplayed();
                break;
            case CANCEL:
                result = thirdPartyPage.isAssessmentDetailsCancelButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        validateButtonCondition(buttonType, buttonCondition, result);
    }

    @Then("^General and Other Information button \"(Save|Cancel)\" (is not|is) displayed")
    public void checkGeneralInformationButtonVisibility(String buttonType, String buttonCondition) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(20);
        boolean result;
        switch (buttonType) {
            case SAVE:
                result = thirdPartyPage.isGeneralInformationSaveButtonDisplayed();
                break;
            case CANCEL:
                result = thirdPartyPage.isGeneralInformationCancelButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        validateButtonCondition(buttonType, buttonCondition, result);
    }

    @Then("^General and Other Information button \"(Save|Cancel)\" is (enabled|disabled)$")
    public void checkGeneralInformationButtonEnabled(String buttonType, String buttonCondition) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(20);
        boolean isEnabled = buttonCondition.equalsIgnoreCase(ENABLED);
        boolean result;
        switch (buttonType) {
            case SAVE:
                result = thirdPartyPage.isGeneralInformationSaveButtonEnabled();
                break;
            case CANCEL:
                result = thirdPartyPage.isGeneralInformationCancelButtonEnabled();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(result).as("%s button is not %s", buttonType, buttonCondition).isEqualTo(isEnabled);
    }

    @Then("Search Term Value on Screening Criteria section is pre-populated with third-party's Name from test data {string}")
    public void checkSearchTermIsPrePopulated(String thirdPartyReference) {
        ThirdPartyData thirdPartyTestData =
                new JsonUiDataTransfer<ThirdPartyData>(DataProvider.THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        if (thirdPartyTestData.getName().equals(StringUtils.EMPTY)) {
            String thirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
            thirdPartyTestData.setName(thirdPartyName);
        }
        assertThat(thirdPartyTestData.getName())
                .as("Search Term value '" + thirdPartyPage.isSearchTermValueDisplayed(thirdPartyTestData.getName()) +
                            "' isn't correct")
                .isEqualTo(thirdPartyTestData.getName());
    }

    @Then("Country of Registration Value on Screening Criteria section is pre-populated with Country from test data {string}")
    public void checkCountryOfRegistrationIsPrePopulated(String thirdPartyReference) {
        ThirdPartyData thirdPartyTestData =
                new JsonUiDataTransfer<ThirdPartyData>(DataProvider.THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        assertThat(thirdPartyTestData.getCountry())
                .as("Country Of Registration value '" +
                            thirdPartyPage.isCountryOfRegistrationDisplayed(thirdPartyTestData.getCountry()) +
                            "' isn't correct")
                .isEqualTo(thirdPartyTestData.getCountry());
    }

    @Then("Search Term Value {string} on Screening Criteria section is displayed")
    public void checkSearchTermValueIsDisplayed(String searchTerm) {
        assertTrue(thirdPartyPage.isSearchTermValueDisplayed(searchTerm),
                   "Search Term: '" + searchTerm + "' is not displayed");
    }

    @Then("Country Value {string} in Country Of Registration on Screening Criteria section is displayed")
    public void checkCountryValueIsDisplayed(String country) {
        assertTrue(thirdPartyPage.isCountryValueDisplayed(country),
                   "Country: '" + country + "' is not displayed");
    }

    @Then("^Ongoing Screening \"(.*)\" is (checked|unchecked)$")
    public void uncheckOngoingScreening(String ongoingName, String checkType) {
        if (checkType.equals(CHECKED)) {
            assertTrue(thirdPartyPage.isOngoingScreeningChecked(ongoingName),
                       "Ongoing Screening '" + ongoingName + "' is unchecked");
        } else {
            assertFalse(thirdPartyPage.isOngoingScreeningChecked(ongoingName),
                        "Ongoing Screening '" + ongoingName + "' is checked");
        }
    }

    @Then("Notification Recipients {string} is checked")
    public void checkRecipients(String recipients) {
        assertTrue(thirdPartyPage.isRecipientsTypeChecked(recipients),
                   "Notification Recipients '" + recipients + "' is not checked");
    }

    @Then("User {string} was assigned to Notification Recipients")
    public void userWasAssignedToNotificationRecipients(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        String expectedAssignee =
                format(USER_FORMAT, (userData.getFirstName()), userData.getLastName());
        assertTrue(thirdPartyPage.isRecipientsNameDisplayed(expectedAssignee), "Notification Recipients is unexpected");
    }

    @Then("Text is shown when hover over Risk Rating help icon on DDO section")
    public void helpTextIsShown(DataTable dataTable) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyPage.hoverOverRiskRatingHelpIcon();
        dataTable.asList().forEach(textLine -> assertThat(thirdPartyPage.getRiskRatingHelpText())
                .as("Help text is not matched or missed")
                .contains(textLine));
        thirdPartyPage.clickOnBlankArea();
    }

    @Then("Last created order is on the top of DDO list")
    public void lastOrderIsOnTheTopOfDDOList() {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(thirdPartyPage.getDdOrdersTable().getOrders().get(0).getOrderId())
                .as("Oder ID is different from expected one")
                .isEqualTo((String) this.context.getScenarioContext().getContext(ORDER_ID));
    }

    @Then("DD orders are sorted by {string} in {string} order")
    public void ordersAreSorted(String columnName, String orderType) {
        Function<DdOrdersData.DdOrder, String> fieldName;
        switch (columnName) {
            case "Order Id":
                fieldName = DdOrdersData.DdOrder::getOrderId;
                break;
            case "Order Type":
                fieldName = DdOrdersData.DdOrder::getOrderType;
                break;
            case "Subject Name":
                fieldName = DdOrdersData.DdOrder::getSubjectName;
                break;
            case "Scope":
                fieldName = DdOrdersData.DdOrder::getScope;
                break;
            case "Status":
                fieldName = DdOrdersData.DdOrder::getStatus;
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + columnName);
        }
        List<String> valueList = thirdPartyPage.getDdOrdersTable().getOrders()
                .stream()
                .map(fieldName)
                .collect(Collectors.toList());
        valueList.removeAll(Collections.singleton(null));
        assertThat(valueList)
                .as("Orders are not sorted correctly")
                .isSortedAccordingTo(getStringComparator(orderType, false));
    }

    @Then("Add third-party Currency dropdown contains expected values")
    public void addThirdPartyCurrencyDropdownIsSortedInTheOrderThatWasConfiguredEarlier() {
        List<String> expectedList = Arrays.stream(getRefDataPayload(getValueTypeId(CURRENCY)).getListValues())
                .map(currency -> currency.getCurrencyCode() + SPACE + currency.getDescription())
                .collect(Collectors.toList());
        assertThat(thirdPartyPage.getCurrenciesList())
                .as("Currencies sorting is unexpected")
                .isEqualTo(expectedList);
    }

    @Then("Add third-party Country dropdown contains expected values")
    public void addThirdPartyCountryDropdownIsSortedInTheOrderThatWasConfiguredEarlier() {
        List<String> expectedList = Arrays.stream(getRefDataPayload(getValueTypeId(COUNTRY)).getListValues())
                .map(Value::getName)
                .collect(Collectors.toList());
        assertThat(thirdPartyPage.getCountryList())
                .as("Country sorting is unexpected")
                .isEqualTo(expectedList);
    }

    @Then("Add third-party Countries dropdown contains only countries for selected region")
    public void addThirdPartyCountriesDropdownContainsOnlyCountriesForSelectedRegion() {
        List<String> selectedCountriesForRegion = getAvailableCountriesForRegion(getRegionIdByName(selectedRegionName));
        assertThat(thirdPartyPage.getCountryList())
                .as("Country list for region is unexpected")
                .isEqualTo(selectedCountriesForRegion);
    }

    @Then("Add third-party {string} dropdown contains expected values")
    public void addThirdPartyDropdownContainsExpectedData(String dropDownType, List<String> expectedValues) {
        assertThat(thirdPartyPage.getDropDownList(dropDownType))
                .as("%s list is unexpected", dropDownType)
                .isEqualTo(expectedValues);
    }

    @Then("Add third-party {string} dropdown contains all sorted values")
    public void addThirdPartyDropdownContainsExpectedData(String dropDownType) {
        List<String> expectedValues = stream(getRefDataPayload(getValueType(dropDownType).get_id()).getListValues())
                .map(value -> nonNull(value.getName()) ? value.getName() : value.getDescription())
                .collect(Collectors.toList());
        expectedValues.removeAll(Collections.singleton(null));
        List<String> actualValues = thirdPartyPage.getDropDownList(dropDownType).stream()
                .map(option -> option.replaceAll(COMMA, EMPTY))
                .collect(Collectors.toList());
        assertThat(actualValues)
                .as("%s list is unexpected", dropDownType)
                .isEqualTo(expectedValues);
    }

    @Then("^All Assessment Details section (input|view) fields are displayed$")
    public void checkAssessmentDetailsSectionFields(String fieldsState, List<String> fieldNames) {
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewAssessmentDetailsFieldsDisplayed(fieldNames))
                    .as("Assessment Details section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputAssessmentDetailsFieldsDisplayed(fieldNames))
                    .as("Assessment Details section input fields are not displayed").isTrue();
        }
    }

    @Then("^All General Information section (input|view) fields are displayed$")
    public void checkGeneralInformationSectionFields(String fieldsState, List<String> fieldNames) {
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyPage.expandSectionIfCollapsed(GENERAL_INFORMATION);
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewGeneralInformationFieldsDisplayed(fieldNames))
                    .as("General Information section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputGeneralInformationFieldsDisplayed(fieldNames))
                    .as("General Information section input fields are not displayed").isTrue();
        }
    }

    @Then("^All Third-party Segmentation section (input|view) fields are displayed$")
    public void checkThirdPartySegmentationSectionFields(String fieldsState, List<String> fieldNames) {
        thirdPartyPage.expandSectionIfCollapsed(THIRD_PARTY_SEGMENTATION);
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewThirdPartySegmentationFieldsDisplayed(fieldNames))
                    .as("Third-party Segmentation section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputThirdPartySegmentationFieldsDisplayed(fieldNames))
                    .as("Third-party Segmentation section input fields are not displayed").isTrue();
        }
    }

    @Then("^All Other Information section (input|view) fields are displayed$")
    public void checkOtherInformationSectionFields(String fieldsState) {
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewOtherInformationFieldsDisplayed())
                    .as("Other Information section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputOtherInformationFieldsDisplayed())
                    .as("Other Information section input fields are not displayed").isTrue();
        }
    }

    @Then("^All Bank Details section (input|view) fields are displayed$")
    public void checkBankDetailsSectionFields(String fieldsState, List<String> fieldNames) {
        thirdPartyPage.expandSectionIfCollapsed(THIRD_PARTY_BANK_DETAILS);
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewBankDetailsFieldsDisplayed(fieldNames))
                    .as("Bank Details section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputBankDetailsFieldsDisplayed(fieldNames))
                    .as("Bank Details section input fields are not displayed").isTrue();
        }
    }

    @Then("^All Address section (input|view) fields are displayed$")
    public void checkAddressSectionFields(String fieldsState, List<String> fieldNames) {
        thirdPartyPage.expandSectionIfCollapsed(ADDRESS);
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewAddressFieldsDisplayed(fieldNames))
                    .as("Address section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputAddressFieldsDisplayed(fieldNames))
                    .as("Address section input fields are not displayed").isTrue();
        }
    }

    @Then("^All Contact section (input|view) fields are displayed$")
    public void checkContactSectionFields(String fieldsState, List<String> fieldNames) {
        thirdPartyPage.expandSectionIfCollapsed(CONTACT);
        if (fieldsState.equalsIgnoreCase(VIEW)) {
            assertThat(thirdPartyPage.areAllViewContactFieldsDisplayed(fieldNames))
                    .as("Contact section view fields are not displayed").isTrue();
        } else {
            assertThat(thirdPartyPage.areAllInputContactFieldsDisplayed(fieldNames))
                    .as("Contact section input fields are not displayed").isTrue();
        }
    }

    @Then("^Contact add fields button should be in next states$")
    public void isContactAddFieldButtonDisabled(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class).forEach(
                (field, state) -> soft.assertThat(thirdPartyPage.isContactAddFieldButtonDisabled((String) field))
                        .as("Field '%s' is incorrect state - '%s'", field, state).
                        isEqualTo(DISABLED.equals(state)));
    }

    @Then("All Phone Number of Contact section view fields are displayed")
    public void checkPhoneNumberFieldsOfContactSection(List<String> phoneNumber) {
        thirdPartyPage.expandSectionIfCollapsed(CONTACT);
        assertThat(thirdPartyPage.areAllViewPhoneNumberFieldsDisplayed(phoneNumber))
                .as("All Phone Number of Contact section view fields are not displayed").isTrue();
    }

    @Then("^Description section input (is not|is) displayed$")
    public void checkDescriptionSectionField(String fieldsState) {
        if (fieldsState.equals(IS_NOT)) {
            assertThat(thirdPartyPage.isInputDescriptionFieldDisplayed())
                    .as("Description section input field is displayed").isFalse();
        } else {
            assertThat(thirdPartyPage.isInputDescriptionFieldDisplayed())
                    .as("Description section input fields is not displayed").isTrue();
        }
    }

    @Then("^Description section text input area (is not|is) editable")
    public void checkDescriptionSectionIsEditable(String fieldsState) {
        thirdPartyPage.expandSectionIfCollapsed(DESCRIPTION);
        if (fieldsState.equals(IS_NOT)) {
            assertThat(thirdPartyPage.isInputDescriptionFieldEditable())
                    .as("Description section input field is editable").isFalse();
        } else {
            assertThat(thirdPartyPage.isInputDescriptionFieldEditable())
                    .as("Description section input fields is not editable").isTrue();
        }
    }

    @Then("^Add Bank Details button (?:becomes|is?) (active|inactive)$")
    public void addBankDetailsButtonBecomeActive(String state) {
        assertThat(thirdPartyPage.isAddBankDetailsButtonActive())
                .as("Add Bank Details button is not is state '%s'", state)
                .isEqualTo(state.equals(ACTIVE));
    }

    @Then("Remove Bank Details button for bank on position {int} is displayed")
    public void removeBankDetailsButtonForBankOnPositionIsDisplayed(int bankPosition) {
        assertThat(thirdPartyPage.isRemoveBankDetailsButtonActive(bankPosition))
                .as("Remove Bank Details button for bank on position %s is not displayed", bankPosition).isTrue();
    }

    @Then("^Division drop-down list contains (enabled|disabled) options$")
    public void divisionDropDownListContainsOnly(String optionStatus, List<String> expectedResult) {
        if (optionStatus.equals(ENABLED)) {
            assertThat(thirdPartyPage.getDivisionDropDownList(false))
                    .as("Enabled Division drop-down list is unexpected").isEqualTo(expectedResult);
        } else {
            assertThat(thirdPartyPage.getDivisionDropDownList(true))
                    .as("Disabled Division drop-down list is unexpected").isEqualTo(expectedResult);
        }
    }

    @Then("^Delete button for \"((.*))\" division is (enabled|disabled)$")
    public void checkDeleteButtonForDivisionState(String divisionName, String buttonState) {
        if (buttonState.equals(DISABLED)) {
            assertThat(thirdPartyPage.isDeleteButtonForDivisionDisabled(divisionName))
                    .as("Delete button for %s division is not disabled", divisionName).isFalse();
        } else {
            assertThat(thirdPartyPage.isDeleteButtonForDivisionDisabled(divisionName))
                    .as("Delete button for %s division is not enabled", divisionName).isTrue();
        }
    }

    @Then("Division {string} is not selected")
    public void divisionIsNotSelected(String divisionName) {
        assertThat(thirdPartyPage.getSelectedDivisionList())
                .as("Division %s is selected", divisionName).doesNotContain(divisionName);
    }

    @Then("Renewal Cycle is {string}")
    public void renewalCycleIs(String value) {
        assertThat(thirdPartyPage.getRenewalCycle()).as("Renewal Cycle is not " + value).isEqualTo(value);
    }

    @Then("Custom field {string} is empty")
    public void customFieldIsEmpty(String customFieldName) {
        if (customFieldName.equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            customFieldName = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        }
        assertThat(thirdPartyPage.getCustomFieldValue(customFieldName))
                .as("Custom field %s is not empty", customFieldName).isNullOrEmpty();
    }

    @Then("^Third-party creation form (Cancel|Save|Save and New) button is (disabled|enabled)$")
    public void thirdPartyCreationFormButtonIsDisabled(String buttonType, String buttonState) {
        boolean result;
        switch (buttonType) {
            case SAVE:
                result = thirdPartyPage.isSaveButtonDisabled();
                break;
            case CANCEL:
                result = thirdPartyPage.isCancelButtonDisabled();
                break;
            case SAVE_AND_NEW:
                result = thirdPartyPage.isSaveAndNewButtonDisabled();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        if (buttonState.equals(DISABLED)) {
            assertThat(result).as("%s button is not disabled", buttonType).isTrue();
        } else {
            assertThat(result).as("%s button is not enabled", buttonType).isFalse();
        }
    }

    @Then("Remove Third-party from context")
    public void removeThirdPartyFromContext() {
        context.getScenarioContext().setContext(THIRD_PARTY_ID, null);
    }

    @Then("Groups field is displayed in Screening Criteria with default value {string}")
    public void groupsFieldIsDisplayedWithDefaultValue(String groupValue) {
        assertTrue(thirdPartyPage.isGroupsNameDisplayed(groupValue), "Default value in Groups field is not correct");
    }

    @Then("Groups tooltip {string} is displayed")
    public void groupsTooltipIsDisplayed(String groupToolTip) {
        assertThat(thirdPartyPage.getTooltipText())
                .as("Expected Group Tooltip is not displayed")
                .isEqualTo(groupToolTip);
    }

    @Then("Groups dropdown tooltip {string} is displayed")
    public void groupsDropDownTooltipIsDisplayed(String groupDropDownToolTip) {
        assertThat(thirdPartyPage.getTooltipText())
                .as("Expected Group Drop down Tooltip is not displayed")
                .isEqualTo(groupDropDownToolTip);
    }

    @Then("Risk Model value is displayed")
    public void riskModelValueIsDisplayed() {
        assertThat(thirdPartyPage.isRiskModelValueIsDisplayed()).as(
                "Risk model value is not displayed").isTrue();
    }

    @Then("^Asterisk is (displayed|not displayed) for \"(.*)\" field of \"(.*)\" section$")
    public void isAsteriskDisplayedForField(String state, String fieldName, String sectionName) {
        if (state.equalsIgnoreCase(DISPLAYED)) {
            assertThat(thirdPartyPage.isAsteriskDisplayedForField(fieldName, sectionName))
                    .as("Asterisk is not displayed for '" + fieldName + "' field")
                    .isTrue();
        } else {
            assertThat(thirdPartyPage.isAsteriskDisplayedForField(fieldName, sectionName))
                    .as("Asterisk is displayed for '" + fieldName + "' field")
                    .isFalse();
        }
    }

    @Then("Third-party's 'General Information' section fields contain values")
    public void isGeneralInformationFieldsContainValues(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class)
                .forEach((field, value) -> soft.assertThat(thirdPartyPage.getGeneralInformationValue(field.toString()))
                        .as(field + " field value is incorrect")
                        .isEqualToIgnoringCase(value.toString()));
        soft.assertAll();
    }

    @Then("Third-party's 'Third-party Segmentation' section fields contain values")
    public void isThirdPartySegmentationFieldsContainValues(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class).forEach(
                (field, value) -> soft.assertThat(thirdPartyPage.getThirdPartySegmentationValue(field.toString()))
                        .as(field + " field value is incorrect")
                        .isEqualToIgnoringCase(value.toString()));
        soft.assertAll();
    }

    @Then("Third-party's 'Bank Details' section fields on position {int} contain values")
    public void isBankDetailsFieldsContainValues(int bankPosition, DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class).forEach(
                (field, value) -> soft.assertThat(thirdPartyPage.getBankDetailsValue(field.toString(), bankPosition))
                        .as(field + " field value is incorrect")
                        .isEqualToIgnoringCase(value.toString()));
        soft.assertAll();
    }

    @Then("Third-party's 'Address' section fields contain values")
    public void isAddressFieldsContainValues(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class)
                .forEach((field, value) -> soft.assertThat(thirdPartyPage.getAddressDetailsValue(field.toString()))
                        .as(field + " field value is incorrect")
                        .isEqualToIgnoringCase(value.toString()));
        soft.assertAll();
    }

    @Then("Third-party's 'Contact' section fields contain values")
    public void isContactFieldsContainValues(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class)
                .forEach((field, value) -> soft.assertThat(thirdPartyPage.getContactValue(field.toString()))
                        .as(field + " field value is incorrect")
                        .isEqualToIgnoringCase(value.toString()));
        soft.assertAll();
    }

    @Then("Third-party's 'Description' section contain value")
    public void isDescriptionSectionContainValue(String expectedDescription) {
        assertThat(thirdPartyPage.getDescription())
                .as("Description value is not expected")
                .isEqualTo(expectedDescription);
    }

    @Then("^Fields asterisk should be shown according to table$")
    public void isAsteriskDisplayedForField(DataTable dataTable) {
        SoftAssertions soft = new SoftAssertions();
        dataTable.asLists().forEach(data -> {
            String fieldName = data.get(0);
            String section = data.get(1);
            String state = data.get(2);
            if (context.getScenarioContext().isContains(data.get(0))) {
                fieldName = (String) context.getScenarioContext().getContext(data.get(0));
            }
            thirdPartyPage.expandSectionIfCollapsed(section);
            soft.assertThat(thirdPartyPage.isAsteriskDisplayedForField(fieldName, section))
                    .as("Field '" + fieldName + " is not corresponds to asterisk table")
                    .isEqualTo(state.equalsIgnoreCase(DISPLAYED));
        });
        soft.assertAll();
    }

    @Then("Edit button for {string} activity row is not displayed")
    public void verifyEditActivityButton(String activity) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(thirdPartyPage.isEditActivityButtonDisplayed(activity))
                .as("Activity %s edit button is displayed", activity)
                .isFalse();
    }

    @Then("{string} is displayed between Status and Risk Tier field")
    public void isFinalAssessmentDisplayed(String text) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(thirdPartyPage.isFinalAssessmentDisplayed(text)).isTrue();
    }

    @Then("{string} is not displayed between Status and Risk Tier field")
    public void isFinalAssessmentHidden(String text) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(thirdPartyPage.isFinalAssessmentDisplayed(text)).isFalse();
    }

    @Then("^Custom field is (displayed|not displayed) in Other Information section in (view|edit) mode$")
    public void isCustomFieldValueDisplayed(String state, String mode) {
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        String name = this.context.getScenarioContext().isContains(CUSTOM_FIELD_NAME_CONTEXT)
                ? (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT)
                : (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        assertThat(thirdPartyPage.isCustomFieldDisplayed(name, mode))
                .as("Custom field has unexpected state")
                .isEqualTo(DISPLAYED.equalsIgnoreCase(state));
    }

    @Then("^Custom field is (required|not required) in Other Information section in (view|edit) mode$")
    public void isCustomRequiredFieldValueDisplayed(String state, String mode) {
        thirdPartyPage.expandSectionIfCollapsed(OTHER_INFORMATION);
        String name = this.context.getScenarioContext().isContains(CUSTOM_FIELD_NAME_CONTEXT)
                ? (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT)
                : (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        assertThat(thirdPartyPage.isCustomFieldRequired(name, mode))
                .as("Custom field has unexpected 'required' state")
                .isEqualTo(REQUIRED.equalsIgnoreCase(state));
    }

}