package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.google.api.client.util.Strings;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.DmsApi;
import com.refinitiv.asts.test.ui.api.model.*;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.ValueType;
import com.refinitiv.asts.test.ui.enums.WCOEntityType;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.FilePage;
import com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.CustomFieldsManagementPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.ThirdPartyFieldsPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts.ContactPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts.ContactsPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ThirdPartyInformationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.home.HomeSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.login.LoginSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.ThirdPartyOverviewSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.contacts.ContactSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation.ThirdPartySteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MessageManagementData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyOrganisationData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import com.refinitiv.asts.test.utils.FileUtil;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import lombok.SneakyThrows;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;
import org.testng.AssertJUnit;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.*;
import static com.refinitiv.asts.test.ui.api.AppApi.getPostRefDataRetrieveListResponse;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getWorkflowGroupResponse;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.ASSOCIATED_PARTIES_TAB;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.*;
import static com.refinitiv.asts.test.ui.enums.WCOEntityType.INDIVIDUAL;
import static com.refinitiv.asts.test.ui.enums.WCOEntityType.ORGANISATION;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getCurrentMillis;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static com.refinitiv.asts.test.utils.FileUtil.getCreatedFile;
import static com.refinitiv.asts.test.utils.FileUtil.getLastDownloadedFile;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static java.util.Objects.requireNonNull;
import static java.util.UUID.randomUUID;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class CommonSteps extends BaseSteps {

    public static final String COLON = ":";
    public static final String UI = "/ui/";
    public static final char SLASH = '/';
    public static final String DOUBLE_SLASH = "//";
    public static final char QUESTION = '?';
    public static final int ONE = 1;
    public static final String THIRD_PARTY_REFERENCE = "Third-party Reference";
    private final LoginSteps loginSteps;
    private final HomeSteps homeSteps;
    private final ThirdPartyOverviewSteps thirdPartyOverviewSteps;
    private final ThirdPartySteps thirdPartySteps;
    private final ThirdPartyInformationPage thirdPartyPage;
    private final ThirdPartyFieldsPage thirdPartyFieldsPage;
    private final CustomFieldsManagementPage customFieldsManagementPage;
    private final ContactsPage contactsPage;
    private final ContactSteps contactSteps;
    private final FilePage filePage;

    public CommonSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.loginSteps = new LoginSteps(this.context);
        this.thirdPartySteps = new ThirdPartySteps(this.context);
        this.thirdPartyOverviewSteps = new ThirdPartyOverviewSteps(this.context);
        this.homeSteps = new HomeSteps(this.context);
        this.thirdPartyPage = new ThirdPartyInformationPage(driver, context, translator);
        this.thirdPartyFieldsPage = new ThirdPartyFieldsPage(driver, context);
        this.customFieldsManagementPage = new CustomFieldsManagementPage(driver);
        this.contactSteps = new ContactSteps(this.context);
        this.filePage = new FilePage(driver);
        this.contactsPage = new ContactsPage(driver, context, translator);
    }

    @Given("User logs into RDDC as {string}")
    public void logInAs(String userReference) {
        driver.manage().deleteAllCookies();
        loginSteps.userLaunchLoginPage();
        loginSteps.entersUsernameAndPassword(userReference);
        homeSteps.acceptNoticeIfDisplayed();
        homeSteps.verifyNoticeIsNotDisplayed();
        homeSteps.validateUserHeaderDisplayed();
        context.getScenarioContext().setContext(COOKIES, driver.manage().getCookies());
    }

    @Given("The test is Failed due to the bug: {string}")
    public void markTestAsFailed(String bugNumber) {
        Assert.fail(format("The test is %s: %s", FAILED_DUE_TO_THE_BUG, bugNumber));
    }

    @Given("The test is Blocked due to the issue: {string}")
    public void markTestAsBlocked(String bugNumber) {
        Assert.fail(format("The test is %s: %s", BLOCKED_DUE_TO_THE_ISSUE, bugNumber));
    }

    @When("User creates third-party {string}")
    public void createThirdPartyUI(String thirdPartyReference) {
        if (!context.getScenarioContext().isContains(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED)) {
            thirdPartyFieldsPage.setDefaultThirdPartyFieldsManagementValues();
            customFieldsManagementPage.unsetRequiredFromCustomFieldsViaApi();
        }
        thirdPartyOverviewSteps.navigateToThirdPartyOverviewPage();
        thirdPartyOverviewSteps.clickAddThirdParty();
        thirdPartySteps.fillInThirdPartyForm(thirdPartyReference);
        thirdPartySteps.submitThirdPartyForm();
        thirdPartySteps.verifyThirdPartyWasCreated();
    }

    @When("Revert Fields management settings to defaults")
    public void revertFieldsManagementToDefaults() {
        thirdPartyFieldsPage.setDefaultThirdPartyFieldsManagementValues();
        customFieldsManagementPage.unsetRequiredFromCustomFieldsViaApi();
    }

    @When("User creates third-party {string} via API and open it")
    public void createdThirdPartyAPIAndOpenIt(String thirdPartyReference) {
        thirdPartyFieldsPage.setDefaultThirdPartyFieldsManagementValues();
        customFieldsManagementPage.unsetRequiredFromCustomFieldsViaApi();
        ThirdPartyData thirdPartyData =
                new JsonUiDataTransfer<ThirdPartyData>(THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        if (thirdPartyData.getName().isEmpty() || (thirdPartyData.getName().equals(THIRD_PARTY_NAME_SIMILAR)
                && !context.getScenarioContext().isContains(THIRD_PARTY_NAME_SIMILAR))) {
            String randomName = AUTO_TEST_NAME_PREFIX + randomUUID();
            if (thirdPartyData.getName().equals(THIRD_PARTY_NAME_SIMILAR)) {
                context.getScenarioContext().setContext(THIRD_PARTY_NAME_SIMILAR, randomName);
            }
            thirdPartyData.setName(randomName);
        } else if (context.getScenarioContext().isContains(THIRD_PARTY_NAME_SIMILAR)) {
            thirdPartyData.setName((String) context.getScenarioContext().getContext(THIRD_PARTY_NAME_SIMILAR));
        }
        if (nonNull(thirdPartyData.getWorkflowGroup()) &&
                thirdPartyData.getWorkflowGroup().equals(WORKFLOW_GROUP_NAME_CONTEXT)) {
            thirdPartyData.setWorkflowGroup(
                    (String) context.getScenarioContext().getContext(WORKFLOW_GROUP_NAME_CONTEXT));
        }
        if (nonNull(thirdPartyData.getAttachments()) && !thirdPartyData.getAttachments().isEmpty()) {
            Attachment attachment =
                    DmsApi.postFile(getCreatedFile(thirdPartyData.getAttachments().get(0).getFilename()),
                                    thirdPartyData.getAttachments().get(0).getMimeType()).getPayload();
            thirdPartyData.getAttachments().get(0).setFileFolder(attachment.getFileFolder())
                    .setCategoryFolder(attachment.getCategoryFolder())
                    .setLocation(attachment.getLocation())
                    .setDateUploaded(getCurrentMillis());
        }
        this.context.getScenarioContext().setContext(THIRD_PARTY_DATA_CONTEXT, thirdPartyData);
        this.context.getScenarioContext().setContext(thirdPartyReference, thirdPartyData.getName());
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
        CreateSupplierRequest request = buildCreateSupplierRequest(thirdPartyData,
                                                                   refDataResponse,
                                                                   workflowGroup,
                                                                   userData.getUsername());
        String thirdPartyId = createSupplier(request);
        this.context.getScenarioContext().setContext(THIRD_PARTY_ID, thirdPartyId);
        this.context.getScenarioContext().setContext(THIRD_PARTY_NAME, thirdPartyData.getName());
        logger.info("New Third-party with name '" + thirdPartyData.getName() + "' added successful");
        logger.info("New Third-party ID: " + thirdPartyId);
        logger.info("Open Third-party information");
        thirdPartyOverviewSteps.openPreviouslyCreatedThirdParty();
        assertTrue("Third-party page is not loaded or Third-party is not saved", thirdPartyPage.isPageLoaded());
    }

    @When("User creates Associated Party {string}")
    public void createContact(String contactReference) {
        AssociatedPartyIndividualData contactTestData =
                new JsonUiDataTransfer<AssociatedPartyIndividualData>(
                        ASSOCIATED_PARTY_INDIVIDUAL).getTestData().get(contactReference).getDataToEnter();
        if (nonNull(contactTestData.getEmailAddress()) && contactTestData.getEmailAddress().isEmpty()) {
            contactTestData.setEmailAddress((String) context.getScenarioContext().getContext(EMAIL_CONTEXT));
        }
        this.context.getScenarioContext().setContext(CONTACT_TEST_DATA, contactTestData);
        this.context.getScenarioContext().setContext(contactReference, contactTestData.getFirstName());
        ContactsPage contactsPage = new ContactsPage(driver, context, translator);
        ContactPage contactPage = new ContactPage(driver, translator);
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (!contactPage.isAssociatedPartyCurrentPage()) {
            thirdPartyPage.clickOn(ASSOCIATED_PARTIES_TAB);
            contactsPage.waitWhilePreloadProgressbarIsDisappeared();
            contactsPage.clickAddAssociatedPartyButton();
        }
        contactPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        contactPage.fillInAllMandatoryContactData(contactTestData);
        contactPage.selectAutoScreen(contactTestData.getAutoScreen());
        if (nonNull(contactTestData.getIsPrincipal()) && contactTestData.getIsPrincipal()) {
            contactPage.checkKeyPrincipalCheckbox();
        }
        if (nonNull(contactTestData.getAddressCountry()) &&
                contactTestData.getAddressCountry().isEmpty()) {
            contactTestData.setAddressCountry(getCountryWithoutChecklist());
        }
        if (nonNull(contactTestData.getIsEnabledAsUser()) && contactTestData.getIsEnabledAsUser()) {
            contactPage.clickEnabledAsUserCheckbox();
        }
        if (nonNull(contactTestData.getScreeningCriteriaCountry())) {
            contactPage.fillInScreeningCriteriaCountryOfLocation(contactTestData.getScreeningCriteriaCountry());
        }
        if (nonNull(contactTestData.getRegion())) {
            context.getScenarioContext().setContext(SELECTED_REGION_NAME, contactTestData.getRegion());
        }
        contactPage.fillInAddressDetails(1, contactTestData);
        contactPage.fillScreeningCitizenship(contactTestData.getNationality());
        contactPage.fillScreeningPlaceOfBirth(contactTestData.getPlaceOfBirth());
        contactPage.clickSaveContactButton();
        contactPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertTrue("Add contact page is not disappeared", contactsPage.isCreateContactPageDisappeared());
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String contactId =
                AppApi.getContactId(thirdPartyId, contactTestData.getFirstName(), contactTestData.getLastName());
        this.context.getScenarioContext().setContext(USER_FIRST_NAME, contactTestData.getFirstName());
        this.context.getScenarioContext().setContext(CONTACT_ID, contactId);
        contactPage.waitWhileLoadingImageIsDisappeared();
        assertTrue("Contact page is not loaded or Contact is not saved", contactPage.isPageLoaded());
        logger.info("New contact added successful");
        logger.info("New contact ID: " + contactId);
    }

    @When("User creates Associated Party {string} {string} via API and open it")
    public void createContactViaAPI(String associatedPartyType, String contactReference) {
        if (WCOEntityType.INDIVIDUAL.name().equals(associatedPartyType.toUpperCase())) {
            AssociatedPartyIndividualData contactTestData =
                    new JsonUiDataTransfer<AssociatedPartyIndividualData>(
                            ASSOCIATED_PARTY_INDIVIDUAL).getTestData().get(contactReference).getDataToEnter();
            if (Strings.isNullOrEmpty(contactTestData.getEmailAddress()) &&
                    nonNull(context.getScenarioContext().getContext(EMAIL_CONTEXT))) {
                contactTestData.setEmailAddress((String) context.getScenarioContext().getContext(EMAIL_CONTEXT));
            }
            this.context.getScenarioContext().setContext(CONTACT_TEST_DATA, contactTestData);
            this.context.getScenarioContext().setContext(contactReference, contactTestData.getFirstName());
            context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, contactTestData.getFirstName());
            context.getScenarioContext().setContext(USER_EDITED_LAST_NAME, contactTestData.getLastName());
            String thirdPartyId = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_ID);
            AssociatedPartyIndividualCreateRequest
                    request = buildCreateAssociatedPartyIndividualRequest(contactTestData, thirdPartyId);
            AssociatedPartyIndividualCreateResponse
                    contactResponse = postIndividualAssociatedParty(request, thirdPartyId);
            this.context.getScenarioContext().setContext(CONTACT_ID, contactResponse.getData().getId());
            this.context.getScenarioContext()
                    .setContext(ASSOCIATED_PARTY_INDIVIDUAL_ID, contactResponse.getData().getId());
            logger.info("New Associated Party added successful");
            logger.info("New Associated Party ID: " + contactResponse.getData().getId());
            contactsPage.openCreatedContactForThirdParty(INDIVIDUAL);
        } else {
            AssociatedPartyOrganisationData contactTestData =
                    new JsonUiDataTransfer<AssociatedPartyOrganisationData>(
                            ASSOCIATED_PARTY_ORGANISATION).getTestData().get(contactReference).getDataToEnter();
            if (Strings.isNullOrEmpty(contactTestData.getEmailAddress()) &&
                    nonNull(context.getScenarioContext().getContext(EMAIL_CONTEXT))) {
                contactTestData.setEmailAddress((String) context.getScenarioContext().getContext(EMAIL_CONTEXT));
            }
            this.context.getScenarioContext().setContext(CONTACT_TEST_DATA, contactTestData);
            this.context.getScenarioContext().setContext(contactReference, contactTestData.getName());
            String thirdPartyId = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_ID);
            AssociatedPartyOranisationCreateRequest
                    request = buildCreateAssociatedPartyOrganizationRequest(contactTestData, thirdPartyId);
            AssociatedPartyOrganisationCreateResponse
                    contactResponse = postOrganizationAssociatedParty(request, thirdPartyId);
            this.context.getScenarioContext().setContext(CONTACT_ID, contactResponse.getData().getId());
            this.context.getScenarioContext()
                    .setContext(ASSOCIATED_PARTY_ORGANIZATIONAL_ID, contactResponse.getData().getId());
            contactsPage.turnOnAllCheckTypes(contactTestData.getName(), contactTestData.getAddressCountry());
            logger.info("New Associated Party added successful");
            logger.info("New Associated Party ID: " + contactResponse.getData().getId());
            contactsPage.openCreatedContactForThirdParty(ORGANISATION);
        }
        contactSteps.contactPageIsLoaded();
    }

    @When("^User clicks (?:Close) Toast message button$")
    public void clickCloseToastMessageButton() {
        thirdPartyPage.closeToastMessageIfDisplayed();
    }

    @When("User waits for progress bar to disappear from page")
    public void progressBarOnPageIsFullyDisappeared() {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User waits for progress bar to appear and disappear from page")
    public void waitForProgressBarsToAppearAndDisappear() {
        thirdPartyPage.waitWhilePreloadProgressBarsAreDisplayedAndDisappeared();
    }

    @When("User clicks back browser button")
    public void clickBackBrowserButton() {
        thirdPartyPage.clickBackBrowserButton();
    }

    @When("User opens a new tab and switches to new tab")
    public void opensANewTabAndSwitchToNewTab() {
        thirdPartyPage.openNewTab();
        thirdPartyPage.switchToTab(1);
    }

    @When("User switches to a new tab")
    public void switchToNewTab() {
        thirdPartyPage.switchToTab(1);
    }

    @When("User unsets all required Custom Fields via API")
    public void unsetRequiredFromCustomFieldsViaApi() {
        customFieldsManagementPage.unsetRequiredFromCustomFieldsViaApi();
    }

    @When("User saves current URL in context")
    public void saveCurrentURL() {
        context.getScenarioContext().setContext(ContextConstants.URL_CONTEXT, driver.getCurrentUrl());
    }

    @When("User navigate saved URL in context")
    public void navigateSavedURL() {
        driver.get((String) context.getScenarioContext().getContext(ContextConstants.URL_CONTEXT));
    }

    @When("User updates test start date")
    public void updateTestStartDate() {
        context.getScenarioContext().setContext(START_TIME, getCurrentMillis());
    }

    @Then("Current URL contains {string} endpoint")
    public void currentURLContainsEndpoint(String expectedEndpoint) {
        progressBarOnPageIsFullyDisappeared();

        String expectedURL = BasePage.URL + expectedEndpoint;
        String expectedUrlWithoutProtocol = expectedURL.substring(expectedURL.indexOf(COLON) + ONE);
        String actualUrlWithoutProtocol = driver.getCurrentUrl()
                .substring(driver.getCurrentUrl().indexOf(COLON) + ONE);
        if (!expectedEndpoint.contains(UI)) {
            actualUrlWithoutProtocol = actualUrlWithoutProtocol.replaceAll(UI, String.valueOf(SLASH));
        }
        char lastSymbol = expectedEndpoint.charAt(expectedEndpoint.length() - ONE);
        if (expectedUrlWithoutProtocol.contains(THIRD_PARTY_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(THIRD_PARTY_ID,
                                                                            (String) this.context.getScenarioContext()
                                                                                    .getContext(THIRD_PARTY_ID));
        }
        if (expectedUrlWithoutProtocol.contains(CONTACT_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(CONTACT_ID,
                                                                            (String) this.context.getScenarioContext()
                                                                                    .getContext(CONTACT_ID));
        }
        if (expectedUrlWithoutProtocol.contains(ASSOCIATED_PARTY_INDIVIDUAL_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(ASSOCIATED_PARTY_INDIVIDUAL_ID,
                                                                            (String) this.context.getScenarioContext()
                                                                                    .getContext(
                                                                                            ASSOCIATED_PARTY_INDIVIDUAL_ID));
        }
        if (expectedUrlWithoutProtocol.contains(ASSOCIATED_PARTY_ORGANIZATIONAL_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(ASSOCIATED_PARTY_ORGANIZATIONAL_ID,
                                                                            (String) this.context.getScenarioContext()
                                                                                    .getContext(
                                                                                            ASSOCIATED_PARTY_ORGANIZATIONAL_ID));
        }
        if (expectedUrlWithoutProtocol.contains(ARTICLE_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(ARTICLE_ID,
                                                                            (String) this.context.getScenarioContext()
                                                                                    .getContext(ARTICLE_ID));
        }
        if (expectedUrlWithoutProtocol.contains(RESULT_ID)) {
            Map<String, String> selectedReferenceIdResults =
                    (Map<String, String>) context.getScenarioContext().getContext(SCREENING_REFERENCE_IDS_CONTEXT);
            String referenceId = selectedReferenceIdResults.get(THIRD_PARTY_REFERENCE);
            List<ResultsResponseDTO> screeningResultsBeforeReview =
                    (List<ResultsResponseDTO>) context.getScenarioContext().getContext(SCREENING_RESULTS_BEFORE_REVIEW);
            String resultId =
                    screeningResultsBeforeReview.stream()
                            .filter(result -> result.getReferenceId().endsWith(referenceId))
                            .findFirst().get().getResultId();
            String thirdPartyId = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_ID);
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol
                    .replace(THIRD_PARTY_ID, thirdPartyId)
                    .replace(ContextConstants.REFERENCE_ID, referenceId)
                    .replace(RESULT_ID, resultId);

        }
        if (expectedUrlWithoutProtocol.contains(USER_ROLE_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(
                    USER_ROLE_ID, (String) this.context.getScenarioContext().getContext(USER_ROLE_ID));
        }
        if (expectedUrlWithoutProtocol.contains(MESSAGE_ID)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(
                    MESSAGE_ID, ((MessageManagementData) this.context.getScenarioContext().getContext(
                            MESSAGE_MANAGEMENT_DATA)).getId());
        }
        if (expectedUrlWithoutProtocol.contains(USER_GROUP_ID_CONTEXT)) {
            expectedUrlWithoutProtocol = expectedUrlWithoutProtocol.replace(
                    USER_GROUP_ID_CONTEXT, (String) this.context.getScenarioContext()
                            .getContext(USER_GROUP_ID_CONTEXT));
        }
        if (lastSymbol == SLASH || lastSymbol == QUESTION) {
            assertThat(actualUrlWithoutProtocol).as("Current URL is not expected")
                    .contains(expectedUrlWithoutProtocol);
        } else {
            assertEquals("Current URL is not expected", expectedUrlWithoutProtocol, actualUrlWithoutProtocol);
        }
    }

    @Then("Current URL matches {string} endpoint regex")
    public void currentURLMatchesEndpoint(String expectedEndpointRegex) {
        thirdPartyPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(driver.getCurrentUrl()).as("Current URL is not expected")
                .matches(expectedEndpointRegex);
    }

    @Then("Current URL contains Domain name")
    public void currentUrlContainsBaseUrl() {
        String currentUrl = driver.getCurrentUrl();
        String domainUrl = BasePage.URL;
        String domainName = domainUrl.substring(domainUrl.indexOf(DOUBLE_SLASH) + DOUBLE_SLASH.length());
        assertThat(currentUrl).as("Current Url does not contain Domain name").contains(domainName);
    }

    @Then("Toast message is displayed with text")
    public void toastMessageIsDisplayedWithText(List<String> expectedToastMessage) {
        String actualToastMessage = thirdPartyPage.getToastMessageText(
                expectedToastMessage.size() > 1 ? expectedToastMessage.get(0) : StringUtils.EMPTY);
        expectedToastMessage.forEach(text -> {
            text = adjustMessageWithTranslations(text);
            if (text.contains(COUNTRY_CHECKLIST_NAME_CONTEXT)) {
                text = text.replace(COUNTRY_CHECKLIST_NAME_CONTEXT,
                                    (String) context.getScenarioContext()
                                            .getContext(COUNTRY_CHECKLIST_NAME_CONTEXT));
            } else if (text.contains(WORKFLOW_GROUP_NAME_CONTEXT)) {
                text = text.replace(WORKFLOW_GROUP_NAME_CONTEXT,
                                    (String) context.getScenarioContext()
                                            .getContext(WORKFLOW_GROUP_NAME_CONTEXT));
            } else if (text.contains(ALREADY_EXIST_NAME)) {
                text = text.replace(ALREADY_EXIST_NAME,
                                    (String) context.getScenarioContext()
                                            .getContext(ALREADY_EXIST_NAME));
            }
            AssertJUnit.assertTrue(
                    "Toast message " + actualToastMessage + " doesn't contain expected text '" + text + "'",
                    actualToastMessage.contains(text));
        });
    }

    @Then("Toast message is not displayed")
    public void toastMessageIsNotDisplayed() {
        assertThat(thirdPartyPage.isToastMessageDisappeared())
                .as("Toast message is displayed")
                .isTrue();
    }

    @Then("Close Toast message button is displayed")
    public void closeToastMessageButtonIsPresent() {
        assertThat(thirdPartyPage.isToastMessageCloseButtonDisplayed())
                .as("Close Toast message button is not displayed")
                .isTrue();
    }

    @Then("{string} File with name {string} and date format {string} downloaded")
    public void fileDownloaded(String fileFormat, String fileName, String dateFormat) {
        String valueToReplace = StringUtils.substringBetween(fileName, "<", ">");
        if (nonNull(valueToReplace) && context.getScenarioContext().isContains(valueToReplace)) {
            String contextValue = (String) context.getScenarioContext().getContext(valueToReplace);
            fileName = fileName.replace(format("<%s>", valueToReplace), contextValue);
        }
        String expectedFullFileName = context.getScenarioContext().isContains(CSV_FULL_FILE_NAME)
                ? (String) context.getScenarioContext().getContext(CSV_FULL_FILE_NAME)
                : fileName + getTodayDate(dateFormat) + fileFormat;
        filePage.waitForFileToDownload(expectedFullFileName);
        String downloadedFileName = requireNonNull(getLastDownloadedFile()).getName();
        assertThat(downloadedFileName)
                .as("Filename is incorrect")
                .endsWith(fileFormat)
                .isEqualTo(downloadedFileName);
        this.context.getScenarioContext().setContext(DOWNLOADED_FILE_NAME, expectedFullFileName);
    }

    @SneakyThrows
    @Then("File is successfully downloaded")
    public void activityAttachmentIsDownloaded() {
        File expectedFile = (File) context.getScenarioContext().getContext(ATTACHMENT);
        filePage.waitForFileToDownload(expectedFile.getName());
        File actualFile = FileUtil.getLastDownloadedFile();
        context.getScenarioContext().setContext(DOWNLOADED_FILE_NAME, Objects.requireNonNull(actualFile).getName());
        assertThat(FileUtils.contentEquals(expectedFile, Objects.requireNonNull(actualFile)))
                .as("Actual File %s is different from expected one %s", actualFile.getName(), expectedFile.getName())
                .isTrue();
    }

    @Then("New window should be opened")
    public void checkPrintWindowWasOpened() {
        assertThat(thirdPartyPage.getWindowsHandler().getWindowsNumber())
                .as("New window tab wasn't open")
                .isEqualTo(2);
        thirdPartyPage.getWindowsHandler().closeWindowsExceptParent();
    }

    @Then("Tooltip text is displayed")
    public void tooltipTextIsDisplayed(String text) {
        assertThat(thirdPartyPage.getTooltipText())
                .as("Tooltip text is incorrect")
                .isEqualTo(text);
    }

}