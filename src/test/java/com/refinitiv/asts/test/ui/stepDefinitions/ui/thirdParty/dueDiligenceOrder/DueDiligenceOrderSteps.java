package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.dueDiligenceOrder;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.core.framework.drivers.DriverFactory;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.DashboardApi;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.dashboard.DashboardResponse;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields;
import com.refinitiv.asts.test.ui.enums.DdOrderFields;
import com.refinitiv.asts.test.ui.enums.OrderType;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.DueDiligenceOrderPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ThirdPartyInformationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.KeyPrincipleData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.OtherName;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.openqa.selenium.WebDriver;
import org.testng.AssertJUnit;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.api.AppApi.NAME_FILTER;
import static com.refinitiv.asts.test.ui.api.AppApi.getUserDataByEmail;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getIntegraCheckCustomFields;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getPsaScopeResponse;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.DueDiligenceConfirmationOrderConst.REQUESTER_EMAIL;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.Pages.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields.*;
import static com.refinitiv.asts.test.ui.enums.OrderType.ORGANISATION;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.DUE_DILIGENCE_ADD_ONS;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.DueDiligenceOrderPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;

public class DueDiligenceOrderSteps extends BaseSteps {

    public static final String CONTACT_CHANGES_NOTE =
            "Changes in subject details would not reflect in Third-party Contacts Tab";
    private static final String DEFAULT_COMPONENT_NAME = "New Component";
    private final ScenarioCtxtWrapper context;
    private final DueDiligenceOrderPage dueDiligenceOrderPage;
    private String localName = EMPTY;

    public DueDiligenceOrderSteps(ScenarioCtxtWrapper context) {
        WebDriver driver = DriverFactory.getDriver();
        this.context = context;
        this.dueDiligenceOrderPage = new DueDiligenceOrderPage(driver, context, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public Attachment attachmentEntry(Map<String, String> entry) {
        return Attachment.builder()
                .filename(entry.get(FILE_NAME.getName()))
                .description(entry.get(ActivityAttachmentFields.DESCRIPTION.getName()))
                .dateUploaded(entry.get(UPLOAD_DATE.getName()))
                .uploadedBy(entry.get(UPLOAD_BY.getName())).build();
    }

    @DataTableType
    @SuppressWarnings("unused")
    public QuestionnaireData questionnaireToAttach(Map<String, String> entry) {
        return new QuestionnaireData()
                .setQuestionnaireName(entry.get(QUESTIONNAIRE_NAME))
                .setQuestionType(entry.get(QUESTIONNAIRE_TYPE))
                .setAssignee(entry.get(ASSIGNEE))
                .setDateCompleted(entry.get(DATE_COMPLETED))
                .setOverallScore(entry.get(OVERALL_SCORE));
    }

    private List<Attachment> updateDate(List<Attachment> rows) {
        rows.forEach(row -> {
            if (nonNull(row.getDateUploaded())) {
                row.setDateUploaded(getTodayDate(REACT_FORMAT));
            }
        });
        return rows;
    }

    private String updateDate(String date) {
        return getTodayDate(date);
    }

    @When("User adds Order attachment")
    public void addOrderAttachment(List<Attachment> attachments) {
        attachments.forEach(attachment -> {
            dueDiligenceOrderPage.uploadFile(attachment.getFilename());
            dueDiligenceOrderPage.addDescription(attachment.getDescription());
            dueDiligenceOrderPage.clickUploadButton();
            dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        });
    }

    @When("User closes Key Principle creation alert")
    public void closeAlert() {
        dueDiligenceOrderPage.closeAlert();
    }

    @When("^User clicks on (Cancel|Proceed|Delete) button on Due Diligence Order page$")
    public void clickCancelButton(String buttonType) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        switch (buttonType) {
            case CANCEL:
                dueDiligenceOrderPage.clickCancelButton();
                break;
            case PROCEED:
            case DELETE:
                dueDiligenceOrderPage.clickProceedButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User clicks {string} button on Due Diligence Order page")
    public void clickOnDueDiligenceOrderPageButton(String buttonText) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.waitWhileLoadingImageIsDisappeared();
        dueDiligenceOrderPage.extractOrderId();
        dueDiligenceOrderPage.clickOnButtonWithText(dueDiligenceOrderPage.getFromDictionaryIfExists(buttonText));
    }

    @When("User clicks Back button on Due Diligence Order page")
    public void clickOnBackButton() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.extractOrderId();
        dueDiligenceOrderPage.clickBackButton();
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Dashboard link button on Due Diligence Order page")
    public void clickOnLinkBackButton() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.clickBackLinkButton();
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User gets OrderId from Due Diligence Order page URL")
    public void extractOrderIdFromUrl() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.extractOrderId();
    }

    @When("User fills City field with {string}")
    public void fillInCityFieldWithValue(String city) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.fillInCityFieldWithValue(city);
    }

    @When("User clicks none selected scope")
    public void clickNoneRecommendedOption() {
        dueDiligenceOrderPage.clickUncheckedScope();
    }

    @When("User fills in Po No.")
    public void fillInPoNo() {
        dueDiligenceOrderPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String orderPoNo = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
        context.getScenarioContext().setContext(ORDER_PO_NO, orderPoNo);
        dueDiligenceOrderPage.fillInPoNo(orderPoNo);
    }

    @When("User fills in Requester on behalf {string}")
    public void userFillsInRequesterOnBehalf(String value) {
        dueDiligenceOrderPage.fillInRequesterOnBehalf(value);
    }

    @When("User selects {string} Due Diligence Order Type")
    public void selectDueDiligenceOrderType(String orderType) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.selectOrderType(orderType);
    }

    @When("User fills in Subject Name in Local Language {string}")
    public void fillInSubjectNameInLocalLanguage(String subjectName) {
        dueDiligenceOrderPage.fillInSubjectNameInLocalLanguage(subjectName);
        localName = subjectName;
    }

    @When("User fills in Address section values")
    public void fillInAddressSectionValues(ThirdPartyData addressDetails) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.fillInAddressSection(addressDetails);
    }

    @When("User selects Add-ons on position {int}")
    public void selectAddOnsOnPosition(int addOnsPosition) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.selectAddOns(addOnsPosition);
    }

    @When("User selects Subject Full name {string}")
    public void selectSubjectFullName(String subjectName) {
        dueDiligenceOrderPage.fillInFullName(subjectName);
    }

    @When("User fills scope option with value {string}")
    public void fillScopeWithValue(String optionName) {
        dueDiligenceOrderPage.selectScopeOption(optionName);
    }

    @When("User selects {string} Due Diligence Order Approver")
    public void selectDueDiligenceOrderApprover(String approver) {
        dueDiligenceOrderPage.selectApprover(approver);
    }

    @When("User clicks view questionnaire with name {string}")
    public void clickViewQuestionnaireWithName(String questionnaireName) {
        dueDiligenceOrderPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        dueDiligenceOrderPage.clickViewQuestionnaireWithName(questionnaireName);
    }

    @When("User clicks checkbox for {string} questionnaire")
    public void clickCheckboxForQuestionnaire(String questionnaireName) {
        dueDiligenceOrderPage.clickQuestionnaireCheckboxWithName(questionnaireName);
    }

    @When("User creates an order for activity {string}")
    public void createOrder(String activity) {
        ThirdPartyInformationPage thirdPartyPage = new ThirdPartyInformationPage(driver, context, translator);
        thirdPartyPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyPage.clickComponentTab(DEFAULT_COMPONENT_NAME);
        thirdPartyPage.clickActivity(activity);
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        ActivityInformationDisplayPage activityInformationDisplayPage =
                new ActivityInformationDisplayPage(driver, context, translator);
        activityInformationDisplayPage.clickEditButton().clickCreateOrderButton();
    }

    @Then("Alert Icon for Due Diligence Order page is displayed with text")
    public void alertIconIsDisplayedWithText(DataTable dataTable) {
        String actualAlertMessage = dueDiligenceOrderPage.getAlertIconText();
        List<String> expectedAlertMessage = dataTable.asList();
        expectedAlertMessage.forEach(text ->
                                             AssertJUnit.assertTrue("Actual alert message " + actualAlertMessage +
                                                                            " doesn't contain expected text '"
                                                                            + text + "'",
                                                                    actualAlertMessage.contains(text)));

    }

    @Then("^Create Due Diligence Order page should be shown with default values for \"(Individual|Organisation)\" order type$")
    @SuppressWarnings("unchecked")
    public void dueDiligenceOrderPageShouldBeShown(String orderType) {
        ThirdPartyData thirdPartyTestData = (ThirdPartyData) context.getScenarioContext().getContext(
                THIRD_PARTY_DATA_CONTEXT);
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        String expectedLocalName = context.getScenarioContext().isContains(OTHER_NAME_DATA)
                ? ((GenericTestData<OtherName>) context.getScenarioContext().getContext(OTHER_NAME_DATA))
                .getDataToEnter().getName() : localName;
        validateHeaderSectionDisplayedWithExpectedValues(orderType);
        validateSubjectDetailsSectionDisplayedWithExpectedValues(orderType, expectedLocalName);
        boolean isOrganisation = orderType.toUpperCase().equals(ORGANISATION.toString());
        validateAddressSectionDisplayedWithExpectedValues(isOrganisation ? thirdPartyTestData : null);
        if (context.getScenarioContext().isContains(KEY_PRINCIPLE_DATA) && isOrganisation) {
            KeyPrincipleData data = (KeyPrincipleData) this.context.getScenarioContext().getContext(KEY_PRINCIPLE_DATA);
            List<KeyPrincipleData> expectedData = List.of(new KeyPrincipleData()
                                                                  .setFullName(
                                                                          join(new String[]{data.getTitle(),
                                                                                  data.getFirstName(),
                                                                                  data.getLastName()}, SPACE))
                                                                  .setAddressLine(
                                                                          join(new String[]{data.getAddressLine(),
                                                                                  data.getCity(),
                                                                                  data.getState(),
                                                                                  data.getZip(),
                                                                                  data.getCountry()}, SPACE))
                                                                  .setEmail(data.getEmail()));
            validateKeyPrincipalTableDisplayedWithExpectedValues(expectedData);
        }
        validateAvailableDisplayedWithExpectedValues(orderType);
        validateAdditionalAddOnsSectionDisplayedWithExpectedValues();
        validateCommentDisplayedWithExpectedValues();
        validateAttachmentSectionDisplayedWithExpectedValues();
        if (isOrganisation) {
            noAvailableDataIsNotDisplayedInKeyPrincipalSection();
        } else {
            isButtonWithNameDisplayed(MANAGE_KAY_PRINCIPAL);
        }
    }

    @Then("Create Order page Header section should be shown with provided {string} Order Type and selected Billing Entity and default values")
    public void validateHeaderSectionDisplayedWithExpectedValues(String orderType) {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        String expectedBillingEntity = getIntegraCheckCustomFields().getBillToEntity()
                ? AppApi.getDefaultBillingEntityName(userTestData.getUsername())
                : EMPTY;
        SoftAssert softAssert = new SoftAssert();
        dueDiligenceOrderPage.checkOrderTypeScopeIsSwitched(orderType);
        softAssert.assertEquals(dueDiligenceOrderPage.isFieldPoNoRequired(),
                                getIntegraCheckCustomFields().getPurchaseOrderNumber(),
                                "Po No. field require status is not equals the setup");
        softAssert
                .assertEquals(dueDiligenceOrderPage.getRequester(),
                              getUserDataByEmail(userTestData.getUsername(), NAME_FILTER),
                              "Requester field is not auto-populated by current user's full name");
        softAssert.assertEquals(dueDiligenceOrderPage.getRequesterEmail().toUpperCase(),
                                userTestData.getUsername().toUpperCase(),
                                "Requester Email is not auto-populated by current user's email");
        if (expectedBillingEntity.isEmpty()) {
            softAssert
                    .assertTrue(!dueDiligenceOrderPage.isBillingEntityFieldDisplayed(), "Billing Entity is displayed");
        } else {
            softAssert.assertEquals(dueDiligenceOrderPage.getBillingEntity(), expectedBillingEntity,
                                    "Default Billing Entity is not expected");
        }
        softAssert.assertEquals(dueDiligenceOrderPage.getOrderType().toUpperCase(), orderType.toUpperCase(),
                                "Order Type is not expected");
        softAssert.assertTrue(dueDiligenceOrderPage.isFieldRequesterOnBehalfEnabledByDefault(),
                              "Field requester on behalf is disabled");
        softAssert.assertAll();
    }

    @Then("^Create Order page Subject Details section for \"(Individual|Organisation)\" order type should be shown with \"((.*))\" Subject Local Name expected values$")
    public void validateSubjectDetailsSectionDisplayedWithExpectedValues(String orderType, String subjectLocalName) {
        String thirdParty = "Third-party information";
        String thirdPartyPlaceholder = "${ thirdParty }";
        SoftAssert softAssert = new SoftAssert();
        ThirdPartyData thirdPartyTestData = (ThirdPartyData) context.getScenarioContext().getContext(
                THIRD_PARTY_DATA_CONTEXT);
        if (orderType.toUpperCase().equals(ORGANISATION.toString())) {
            String changesNote = dueDiligenceOrderPage.getFromDictionaryIfExists("ddoActivity.changesInSubjectMessage")
                    .replace(thirdPartyPlaceholder, thirdParty);
            softAssert.assertTrue(dueDiligenceOrderPage.getSubjectDetailsCaptionText()
                                          .equals(changesNote),
                                  "Third-party Details note " + dueDiligenceOrderPage.getSubjectDetailsCaptionText() +
                                          " not equals " + changesNote);
            softAssert.assertEquals(dueDiligenceOrderPage.getSubjectName(), thirdPartyTestData.getName(),
                                    "Subject Name is not auto-populated with Third-party Name");
            softAssert.assertTrue(dueDiligenceOrderPage.isSubjectNameRequired(),
                                  "Subject Name is not required field");
            softAssert.assertTrue(dueDiligenceOrderPage.isFieldSubjectNameInLocalLanguageEnabledByDefault(),
                                  "Subject Name in Local Language Language is disabled");
            softAssert.assertEquals(dueDiligenceOrderPage.getSubjectNameInLocalLanguage(), subjectLocalName,
                                    "Subject Name in Local Language is not auto-populated with Third-party other name type");
        } else {
            softAssert.assertTrue(
                    dueDiligenceOrderPage.getIndividualSubjectDetailsCaptionText().contains(CONTACT_CHANGES_NOTE),
                    "Third-party Details note is not displayed");
            softAssert.assertTrue(dueDiligenceOrderPage.getIndividualSubjectDetailsAssociatedCompanyText()
                                          .contains(thirdPartyTestData.getName()),
                                  "Third-party Details Associated Company is not displayed");
            KeyPrincipleData data = (KeyPrincipleData) this.context.getScenarioContext().getContext("keyPrincipleData");
            if (data != null) {
                softAssert.assertEquals(dueDiligenceOrderPage.getSubjectTitle(), data.getTitle(),
                                        "Subject Details Title is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getSubjectFullName(),
                                        data.getFirstName() + SPACE + data.getLastName(),
                                        "Subject Details fullName is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getSubjectNameInLocalLanguage(),
                                        data.getLocalLanguageName(),
                                        "Subject Details Local Language Name is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getSubjectEmail(), data.getEmail(),
                                        "Subject Details email is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getIndividualSubjectDetailsAssociatedCompanyText(),
                                        thirdPartyTestData.getName(),
                                        "Subject Details associated company is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getAddressLine(), data.getAddressLine(),
                                        "Address line is incorrect");
            }
        }
        softAssert.assertAll();
    }

    @Then("^Create Order page Address section should be shown with expected values$")
    public void validateAddressSectionDisplayedWithExpectedValues(ThirdPartyData expected) {
        SoftAssert softAssert = new SoftAssert();
        if (nonNull(expected)) {
            softAssert.assertEquals(dueDiligenceOrderPage.getAddressLine(), expected.getAddressLine(),
                                    "Address Line is not auto-populated with Third-party address details");
            softAssert.assertEquals(dueDiligenceOrderPage.getCity(), expected.getCity(),
                                    "City is not auto-populated with Third-party address details");
            softAssert.assertEquals(dueDiligenceOrderPage.getStateProvince(), expected.getStateProvince(),
                                    "State/Province is not auto-populated with Third-party address details");
            softAssert.assertEquals(dueDiligenceOrderPage.getZipCode(), expected.getZipCode(),
                                    "Zip/Postal Code is not auto-populated with Third-party address details");
            softAssert.assertEquals(dueDiligenceOrderPage.getCountry(), expected.getCountry(),
                                    "Country is not auto-populated with Third-party address details");
        } else {
            KeyPrincipleData data = (KeyPrincipleData) this.context.getScenarioContext().getContext(KEY_PRINCIPLE_DATA);
            if (data != null) {
                softAssert.assertEquals(dueDiligenceOrderPage.getAddressLine(), data.getAddressLine(),
                                        "Address line is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getZipCode(), data.getZip(),
                                        "Zip is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getCity(), data.getCity(),
                                        "City is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getStateProvince(), data.getState(),
                                        "State is incorrect");
                softAssert.assertEquals(dueDiligenceOrderPage.getCountry(), data.getCountry(),
                                        "Country is incorrect");
            }
        }
        softAssert.assertAll();
    }

    @Then("Order Key Principal table contains records")
    public void validateKeyPrincipalTableDisplayedWithExpectedValues(List<KeyPrincipleData> expectedResult) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        expectedResult.forEach(data -> {
            if (data.getEmail().equals(VALUE_TO_REPLACE)) {
                String email = (String) context.getScenarioContext().getContext(EMAIL_CONTEXT);
                data.setEmail(email);
            }
        });
        assertThat(dueDiligenceOrderPage.getOrderKeyPrincipalTableValues())
                .as("Order Key Principal table doesn't contain expected records")
                .usingRecursiveComparison()
                .isEqualTo(expectedResult);
    }

    @Then("Create Order page Available Scope section for {string} should be shown with expected values")
    public void validateAvailableDisplayedWithExpectedValues(String orderType) {
        assertThat(dueDiligenceOrderPage.getAllScopesList())
                .as("Available Scope section values are unexpected")
                .usingComparatorForType(String.CASE_INSENSITIVE_ORDER, String.class)
                .usingRecursiveComparison().ignoringCollectionOrder().asList()
                .containsAll(getPsaScopeResponse(OrderType.valueOf(orderType.toUpperCase())));
    }

    @Then("Create Order page Additional Add-Ons section should be shown with expected values")
    public void validateAdditionalAddOnsSectionDisplayedWithExpectedValues() {
        List<String> expectedAddOns =
                AppApi.getActiveListValuesNamesByValueTypeName(DUE_DILIGENCE_ADD_ONS).stream().map(String::trim)
                        .collect(toList());
        assertThat(dueDiligenceOrderPage.getAddOnsList()).as("Add-ons list is different")
                .isEqualTo(expectedAddOns);
    }

    @Then("Create Order page Comment section should be should")
    public void validateCommentDisplayedWithExpectedValues() {
        assertTrue(dueDiligenceOrderPage.isFieldCommentAppears(), "Field Comments not appears");
    }

    @Then("Create Order page Attachment section should be shown")
    public void validateAttachmentSectionDisplayedWithExpectedValues() {
        assertTrue(dueDiligenceOrderPage.isAttachmentUploadAppears(), "Attachment upload is not displayed");
    }

    @Then("Create Due Diligence Order page is opened")
    public void createDueDiligenceOrderPageIsOpened() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue(dueDiligenceOrderPage.isPageLoaded(), "Due Diligence Order page is not opened");
    }

    @Then("Modal window with text {string} appears")
    public void declineOrderConfirmationPopUpAppears(String text) {
        assertTrue(dueDiligenceOrderPage.isModalWindowWithTextAppears(
                           dueDiligenceOrderPage.getFromDictionaryIfExists(text)),
                   "Text " + text + "not appears on modal window");
    }

    @Then("Modal window disappears")
    public void isModalWindowVisible() {
        assertTrue(dueDiligenceOrderPage.isModalWindowDisappeared(), "Modal window still visible");
    }

    @Then("City field is displayed with {string}")
    public void isCityFieldDisplayedWithValue(String expectedCity) {
        assertEquals(dueDiligenceOrderPage.getCity(), expectedCity, expectedCity + " city is not displayed");
    }

    @Then("{string} button on Due Diligence page is displayed")
    public void isButtonWithNameDisplayed(String button) {
        assertTrue(dueDiligenceOrderPage.isButtonWithNameDisplayed(
                dueDiligenceOrderPage.getFromDictionaryIfExists(button)), button + " button is not displayed!");
    }

    @Then("Due Diligence Subject Full Name is populated with {string}")
    public void isSubjectFullNameDisplayed(String expectedName) {
        assertEquals(dueDiligenceOrderPage.getSubjectFullName(), expectedName,
                     expectedName + " Subject Full Name is not displayed");
    }

    @Then("Due Diligence Country {string} is displayed")
    public void isCountryDisplayed(String expectedCountry) {
        assertEquals(dueDiligenceOrderPage.getCountry(), expectedCountry,
                     expectedCountry + " Subject Full Name is not displayed");
    }

    @Then("Order type is {string}")
    public void orderTypeShouldBe(String orderType) {
        assertThat(dueDiligenceOrderPage.getOrderType().toUpperCase())
                .as("Order type is not matched")
                .isEqualTo(orderType.toUpperCase());
    }

    @Then("^\"((.*))\" button on Due Diligence page is (enabled|disabled)$")
    public void buttonOnDueDiligencePageIsEnabled(String buttonName, String buttonState) {
        if (buttonState.equals(DISABLED)) {
            assertThat(dueDiligenceOrderPage.isButtonWithTextEnabled(buttonName))
                    .as("%s button is enabled!", buttonName).isFalse();
        } else {
            assertThat(dueDiligenceOrderPage.isButtonWithTextEnabled(buttonName))
                    .as("%s button is disabled!", buttonName).isTrue();
        }
    }

    @Then("The Due Diligence order screen is displayed with the following details")
    public void ddOrderPageContainsDetails(DataTable dataTable) {
        SoftAssertions softAssertions = new SoftAssertions();
        List<List<String>> ddOrderPage = dataTable.asLists();
        ddOrderPage.forEach(line -> {
            String fieldName = line.get(0);
            String value = line.get(1);
            softAssertions.assertThat(dueDiligenceOrderPage.isFieldWithNamePresent(fieldName))
                    .as(fieldName + " input field is not present")
                    .isTrue();
            if (fieldName.equalsIgnoreCase(DdOrderFields.ORDER_ID.getName())) {
                String orderId = (String) context.getScenarioContext().getContext(ORDER_ID);
                softAssertions.assertThat(dueDiligenceOrderPage.getFieldValue(fieldName))
                        .as("Order ID field value is unexpected")
                        .contains(orderId);
            } else if (fieldName.equalsIgnoreCase(DdOrderFields.ORDER_PO_NUMBER.getName())) {
                String orderPoNo = (String) context.getScenarioContext().getContext(ORDER_PO_NO);
                softAssertions.assertThat(dueDiligenceOrderPage.getFieldValue(fieldName))
                        .as("Order PO NO field value is unexpected")
                        .isEqualTo(orderPoNo);
            } else if (fieldName.equalsIgnoreCase(DdOrderFields.ORDER_DATE.getName())) {
                softAssertions.assertThat(dueDiligenceOrderPage.getFieldValue(fieldName))
                        .as("Order Date field value is unexpected")
                        .contains(getTodayDate(REACT_FORMAT));
            } else if (fieldName.equalsIgnoreCase(DdOrderFields.DUE_DILIGENCE_SCOPE.getName())) {
                softAssertions.assertThat(dueDiligenceOrderPage.getDueDiligenceScopeName())
                        .as("Due Diligence Scope field value is unexpected")
                        .contains(value);
            } else if (fieldName.equalsIgnoreCase(REQUESTER_EMAIL)) {
                value = Config.get().value(value);
                softAssertions.assertThat(dueDiligenceOrderPage.getFieldValue(fieldName))
                        .as(fieldName + " field value is unexpected")
                        .contains(value);

            } else if (value != null) {
                softAssertions.assertThat(dueDiligenceOrderPage.getFieldValue(fieldName))
                        .as(fieldName + " field value is unexpected")
                        .contains(value);
            }
        });
        softAssertions.assertAll();
    }

    @Then("Text is shown when hover over Risk Rating help icon on DDO page")
    public void helpTextIsShown(DataTable dataTable) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        dueDiligenceOrderPage.hoverOverRiskRatingHelpIcon();
        dataTable.asList().forEach(line -> assertThat(dueDiligenceOrderPage.getRiskRatingHelpText())
                .as("Help text is not matched or missed")
                .contains(line));
        dueDiligenceOrderPage.clickOnBlankArea();
    }

    @Then("Create Order page Attachment table row appears")
    public void checkNewAttachmentAppearsOnActivityInformationPage(List<Attachment> expectedResult) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(dueDiligenceOrderPage.getAttachmentAllFieldsValues())
                .as("Create Order page Attachment table is not expected")
                .isEqualTo(updateDate(expectedResult));
    }

    @Then("'No Available data' is displayed in 'Key Principal' section")
    public void noAvailableDataIsNotDisplayedInKeyPrincipalSection() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(dueDiligenceOrderPage.getKeyPrincipleValueText()).as(
                        "'No Available data' is not displayed in 'Key Principal'")
                .contains(translator.getValue("ddoActivity.noDataSign").toUpperCase());
    }

    @Then("Order Key Principal table contains columns")
    public void orderKeyPrincipalTableContainsColumns(List<String> expectedResult) {
        assertThat(dueDiligenceOrderPage.getOrderKeyPrincipalTableColumns())
                .as("Order Key Principal table doesn't contains expected columns").isEqualTo(expectedResult);
    }

    @Then("Create Order Available Questionnaire table contains records")
    public void createOrderAvailableQuestionnaireTableContainsRecords(List<QuestionnaireData> expectedResult) {
        expectedResult.forEach(
                record -> record.setQuestionnaireName(record.getQuestionnaireName())
                        .setDateCompleted(updateDate(record.getDateCompleted())));
        assertThat(dueDiligenceOrderPage.getAvailableQuestionnaires())
                .as("Create Order Available Questionnaire table doesn't contains contains records")
                .isEqualTo(expectedResult);
    }

    @Then("Order Selected Questionnaire table contains records")
    public void createOrderSelectedQuestionnaireTableContainsRecords(List<QuestionnaireData> expectedResult) {
        expectedResult.forEach(
                record -> record.setQuestionnaireName(record.getQuestionnaireName())
                        .setDateCompleted(updateDate(record.getDateCompleted())));
        assertThat(dueDiligenceOrderPage.getSelectedQuestionnaires())
                .as("Create Order Selected Questionnaire table doesn't contains contains records")
                .isEqualTo(expectedResult);
    }

    @Then("Create Order Questionnaires are sorted by {string} in {string} order")
    public void createOrderQuestionnairesAreSortedByInOrder(String sortedBy, String order) {
        List<String> valuesList = dueDiligenceOrderPage.getListValuesForColumn(sortedBy);
        tableIsSortedByInOrder("Create Order Questionnaires", sortedBy, order, REACT_FORMAT, valuesList, false);
    }

    @Then("Due Diligence Order form is opened")
    public void dueDiligenceOrderFormIsLoaded() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(dueDiligenceOrderPage.isPageLoaded()).as("Due Diligence Order form is not opened").isTrue();
    }

    @Then("^(Cancel|Proceed) button is displayed on Decline Order modal$")
    public void isModalButtonDisplayed(String buttonType) {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        switch (buttonType) {
            case CANCEL:
                assertThat(dueDiligenceOrderPage.isModalCancelButtonDisplayed()).as("Cancel button is not displayed!")
                        .isTrue();
                break;
            case PROCEED:
                assertThat(dueDiligenceOrderPage.isModalProceedButtonDisplayed()).as("Proceed button is not displayed!")
                        .isTrue();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @Then("Once Onboarding started user should have new activity assigned")
    public void checkAssignedActivityAppears() {
        dueDiligenceOrderPage.waitWhilePreloadProgressbarIsDisappeared();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        final String userEmail = userTestData.getUsername();
        DashboardResponse assignedActivitiesResponse = DashboardApi.getAssignedActivities(userEmail);
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        assignedActivitiesResponse.getPayload().getRecords()
                .stream()
                .filter(obj -> obj.getSupplierId().equals(thirdPartyId))
                .findFirst()
                .orElseThrow(
                        () -> new RuntimeException(
                                format("Activity wasn't assigned to Third-party ID: %s", thirdPartyId)));
    }

    @Then("Due Diligence Order form contains expected URL")
    public void dueDiligenceOrderFormContainsExpectedURL() {
        dueDiligenceOrderPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String thirdPartyId = (String) context.getScenarioContext().getContext(ContextConstants.THIRD_PARTY_ID);
        String orderId = (String) context.getScenarioContext().getContext(ContextConstants.ORDER_ID);
        String expectedUrl = BasePage.URL + THIRD_PARTY + SLASH + thirdPartyId + Pages.DD_ORDER + orderId;
        assertThat(driver.getCurrentUrl().replaceAll(HTTPS, HTTP))
                .as("Due Diligence Order form activity URL is incorrect")
                .contains(expectedUrl);
    }

}
