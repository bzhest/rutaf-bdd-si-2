package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.setUp.MessageManagementPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MessageManagementData;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.WordUtils;
import org.apache.commons.text.similarity.JaroWinklerDistance;
import org.assertj.core.api.Assertions;
import org.assertj.core.api.SoftAssertions;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Objects;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.WorkflowApi.getMessageManagementItems;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.MESSAGE_MANAGEMENT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.Integer.parseInt;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.*;
import static org.assertj.core.api.Assertions.assertThat;

public class MessageManagementSteps extends BaseSteps {

    private static final String CLONE = "Clone";
    private final MessageManagementPage messageManagementPage;
    private static final String DRAFT = "Draft";

    public MessageManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        messageManagementPage = new MessageManagementPage(driver, context);
    }

    @When("User navigates to 'Message Management' page")
    public void navigateToMessageManagement() {
        messageManagementPage.navigateToMessageManagementPage();
        messageManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User navigates to 'Add Message' page")
    public void navigateToAddMessagePage() {
        messageManagementPage.navigateToAddMessagePage();
        messageManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to 'View Message' page of existing Message")
    public void openViewMessagePage() {
        String messageId = (String) context.getScenarioContext().getContext(MESSAGE_ID);
        messageManagementPage.navigateToViewMessagePage(messageId);
        messageManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to 'Edit Message' page of existing Message")
    public void openEditMessagePage() {
        String messageId = (String) context.getScenarioContext().getContext(MESSAGE_ID);
        messageManagementPage.navigateToEditMessagePage(messageId);
        messageManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User saves random Message id to context")
    public void saveRandomMessageIdToContext() {
        String randomId = getMessageManagementItems().stream().findAny()
                .orElseThrow(() -> new RuntimeException("No messages are found"))
                .getId();
        context.getScenarioContext().setContext(MESSAGE_ID, randomId);
    }

    @When("User clicks Message Management table {string} column's header")
    public void clickMessageManagementTableColumnHeader(String headerName) {
        messageManagementPage.clickColumnHeader(headerName);
    }

    @When("User clicks 'Back' button on Message Management page")
    public void clickBackButtonOnMessageManagementPage() {
        messageManagementPage.clickBackButton();
        messageManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User fills in {string} Message management data")
    public void fillInMessageManagementData(String dataReference) {
        MessageManagementData messageManagementData = new JsonUiDataTransfer<MessageManagementData>(MESSAGE_MANAGEMENT)
                .getTestData().get(dataReference).getDataToEnter();
        if (isEmpty(messageManagementData.getName()) && nonNull(messageManagementData.getName())) {
            messageManagementData.setName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (isEmpty(messageManagementData.getHeader()) && nonNull(messageManagementData.getHeader())) {
            messageManagementData.setHeader(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (isEmpty(messageManagementData.getEffectiveDateTime()) &&
                nonNull(messageManagementData.getEffectiveDateTime())) {
            messageManagementData.setEffectiveDateTime(DateUtil.getTodayDate(REACT_FORMAT));
        }
        if (nonNull(messageManagementData.getName()) && messageManagementData.getName().equals(MAX_LENGTH)) {
            messageManagementData.setName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(190));
        }
        messageManagementPage.fillInMessageManagementData(messageManagementData);
        messageManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        context.getScenarioContext().setContext(MESSAGE_MANAGEMENT_DATA, messageManagementData);
        if (Objects.nonNull(messageManagementData.getName())) {
            context.getScenarioContext().setContext(MESSAGE_NAME, messageManagementData.getName());
        }
    }

    @When("User fills in Message header - {string}")
    public void fillInMessageHeader(String header) {
        if (header.equals(VALUE_TO_UPDATE)) {
            header = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
            if (context.getScenarioContext().isContains(MESSAGE_MANAGEMENT_DATA)) {
                MessageManagementData messageManagementData =
                        (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
                messageManagementData.setHeader(header);
                context.getScenarioContext().setContext(MESSAGE_MANAGEMENT_DATA, messageManagementData);
            }
        }
        messageManagementPage.fillInHeader(header);
    }

    @When("User clicks 'Clone' button on first record in Message Management table")
    public void clickCloneButtonOnFirstRecord() {
        messageManagementPage.clickOnFirstCloneButton();
    }

    @When("^User clicks ('Clone'|'Edit') button on any existing (Published|Draft) message with version (\\d+)$")
    public void clickCloneButtonOnPublishedMessage(String buttonName, String status, int version) {
        MessageManagementData messageData =
                getMessageManagementItems().stream()
                        .filter(message -> message.getStatus().equals(status.toUpperCase()))
                        .filter(message -> message.getVersion() == version)
                        .findAny().orElse(null);
        if (nonNull(messageData)) {
            String date = DateUtil.convertDateFormat(WC1_DATE_FORMAT, REACT_FORMAT, messageData.getEffectiveDateTime());
            messageData.setEffectiveDateTime(date);
            messageData.setPublishTo(
                    WordUtils.capitalizeFully(messageData.getPublishTo().replaceAll(UNDERSCORE, SPACE)));
            messageData.setStatus(WordUtils.capitalizeFully(messageData.getStatus()));
            if (buttonName.contains(EDIT)) {
                messageManagementPage.clickOnEditButton(messageData.getName());
            } else {
                messageManagementPage.clickOnCloneButton(messageData.getName());
            }
            context.getScenarioContext().setContext(MESSAGE_MANAGEMENT_DATA, messageData);
            context.getScenarioContext().setContext(MESSAGE_NAME, messageData.getName());
        }
    }

    @When("^User opens any existing (Published|Draft) message with version (\\d+)$")
    public void openAnyMessageInTableWithStatusAndVersion(String status, int version) {
        MessageManagementData messageData =
                getMessageManagementItems().stream()
                        .filter(message -> message.getStatus().equals(status.toUpperCase()))
                        .filter(message -> message.getVersion() == version)
                        .findAny().orElse(null);
        if (nonNull(messageData)) {
            String date = DateUtil.convertDateFormat(WC1_DATE_FORMAT, REACT_FORMAT, messageData.getEffectiveDateTime());
            messageData.setEffectiveDateTime(date);
            messageData.setPublishTo(
                    WordUtils.capitalizeFully(messageData.getPublishTo().replaceAll(UNDERSCORE, SPACE)));
            messageData.setStatus(WordUtils.capitalizeFully(messageData.getStatus()));
            messageManagementPage.clickOnMessage(messageData.getName());
            context.getScenarioContext().setContext(MESSAGE_MANAGEMENT_DATA, messageData);
            context.getScenarioContext().setContext(MESSAGE_NAME, messageData.getName());
        }
    }

    @When("User clicks 'Clone' button on any already Cloned message")
    public void clickCloneButtonOnClonedPublishedMessage() {
        MessageManagementData messageData =
                getMessageManagementItems().stream().filter(message -> message.getName().startsWith(CLONE + " -"))
                        .findAny().orElse(null);
        if (nonNull(messageData)) {
            String date = DateUtil.convertDateFormat(WC1_DATE_FORMAT, REACT_FORMAT, messageData.getEffectiveDateTime());
            messageData.setEffectiveDateTime(date);
            messageData.setPublishTo(
                    WordUtils.capitalizeFully(messageData.getPublishTo().replaceAll(UNDERSCORE, SPACE)));
            messageData.setStatus(WordUtils.capitalizeFully(messageData.getStatus()));
            messageManagementPage.clickOnCloneButton(messageData.getName());
        }
        context.getScenarioContext().setContext(MESSAGE_MANAGEMENT_DATA, messageData);
    }

    @When("User opens first record on Message Management page")
    public void openFirstRecordOnMessageManagementPage() {
        messageManagementPage.clickOnFirstRecord();
    }

    @When("Fill in New Message name field - {string}")
    public void fillInNewMessageNameField(String messageName) {
        if (messageName.equals(MESSAGE_NAME)) {
            messageName = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
            context.getScenarioContext().setContext(MESSAGE_NAME, messageName);
        }
        messageManagementPage.fillInCloneWindowNewMessageName(messageName);
    }

    @When("Fill in New Message name field with number of random characters - {int}")
    public void fillInNewMessageNameField(int charCount) {
        String messageName = randomAlphanumeric(charCount);
        messageManagementPage.fillInCloneWindowNewMessageName(messageName);
    }

    @When("Fill in New Message name with already existing one")
    public void fillInNewMessageNameFieldWithExistingOne() {
        String existingName = getMessageManagementItems().stream().findAny()
                .orElseThrow(() -> new RuntimeException("No messages are found"))
                .getName();
        messageManagementPage.fillInCloneWindowNewMessageName(existingName);
    }

    @When("User clicks {string} Message Management button")
    public void clickSaveAsDraftMessageManagementButton(String buttonName) {
        messageManagementPage.clickOnButton(buttonName);
    }

    @When("User clicks on message from context on Message Management Overview page")
    public void clickOnMessageFromContext() {
        String messageName = (String) context.getScenarioContext().getContext(MESSAGE_NAME);
        messageManagementPage.clickOnMessage(messageName);
        messageManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks on 'Edit' icon on Message page")
    public void clickOnEditIconOnMessagePage() {
        messageManagementPage.clickEditIcon();
    }

    @When("Update message in context to version {int}")
    public void updateMessageVersionInContext(int version) {
        MessageManagementData message =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        MessageManagementData newMessage = message.setVersion(version);
        context.getScenarioContext().setContext(MESSAGE_MANAGEMENT_DATA, newMessage);
    }

    @When("User fills in Message page field 'Version' with value {string}")
    public void fillInVersionWithValue(String value) {
        messageManagementPage.fillInVersion(value);
    }

    @When("User fills in Audit date range from {string} to {string}")
    public void fillInAuditDateRangeFromTo(String from, String to) {
        String dateFrom = getDateTimeBeforeToday(REACT_FORMAT, parseInt(from.replace(TODAY_MINUS, EMPTY)));
        String dateTo = getDateAfterTodayDate(REACT_FORMAT, parseInt(to.replace(TODAY, EMPTY)));
        messageManagementPage.fillInDateFrom(dateFrom);
        messageManagementPage.fillInDateTo(dateTo);
    }

    @Then("Page title is {string} on Message Management page")
    public void pageTitleOnMessageManagementPageIs(String expectedTitle) {
        messageManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        if (context.getScenarioContext().isContains(expectedTitle)) {
            expectedTitle = (String) context.getScenarioContext().getContext(expectedTitle);
        }
        Assertions.assertThat(messageManagementPage.getPageTitle(expectedTitle))
                .as("Page title is not %s", expectedTitle)
                .isEqualTo(expectedTitle.toUpperCase());
    }

    @Then("{string} button is present on 'Message Management' page")
    public void buttonIsPresentOnMessageManagementPage(String buttonName) {
        Assertions.assertThat(messageManagementPage.isButtonPresent(buttonName))
                .as("Button %s is not present on page")
                .isTrue();
    }

    @Then("'Message Management' table is displayed with following columns")
    public void messageManagementTableIsDisplayedWithFollowingColumns(List<String> columnNames) {
        Assertions.assertThat(messageManagementPage.getTableHeaders())
                .as("Table headers are incorrect")
                .isEqualTo(columnNames);
    }

    @Then("'Message Management' table results are displayed with 'Clone' and 'Edit' action buttons")
    public void tableResultsAreDisplayedWithActionButtons() {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(messageManagementPage.getCloneMessageButtons())
                .as("Clone message buttons are not present")
                .isNotEmpty().isNotNull();
        softAssert.assertThat(messageManagementPage.getEditMessageButtons())
                .as("Edit message buttons are not present")
                .isNotEmpty().isNotNull();
        softAssert.assertAll();
    }

    @Then("^'(Edit|Clone)' button with tooltip is (displayed|hidden) for records in status '(.*)'$")
    public void buttonWithTooltipIsDisplayedForRecordsInStatus(String buttonName, String displayState, String status) {
        SoftAssertions softAssert = new SoftAssertions();
        boolean isDisplayed = displayState.equalsIgnoreCase(DISPLAYED);
        List<WebElement> rows = buttonName.equals(EDIT) ?
                messageManagementPage.getTableRowsWithStatus(status) :
                messageManagementPage.getTableRowsElements();
        rows.forEach(row -> {
            boolean isButtonPresent = buttonName.equals(EDIT) ?
                    messageManagementPage.isEditButtonPresentOnRow(row) :
                    messageManagementPage.isCloneButtonPresentOnRow(row);
            softAssert.assertThat(isButtonPresent)
                    .as("Edit button is not %s", displayState)
                    .isEqualTo(isDisplayed);
        });
        if (isDisplayed) {
            IntStream.rangeClosed(0, Math.min(rows.size(), 10)).forEach(i -> {
                if (buttonName.equals(EDIT)) {
                    messageManagementPage.hoverOverEditButtonOnRow(rows.get(i));
                } else {
                    messageManagementPage.hoverOverCloneButtonOnRow(rows.get(i));
                }
                softAssert.assertThat(messageManagementPage.getTooltipText()).as("Tooltip is incorrect")
                        .isEqualTo(buttonName);
            });
        }
        softAssert.assertAll();
    }

    @Then("^'(Edit|Clone)' button is (displayed|hidden) for first record on table$")
    public void buttonIsDisplayedForFirstRecordOnTable(String buttonName, String displayState) {
        boolean isDisplayed = displayState.equalsIgnoreCase(DISPLAYED);
        WebElement firstRow = messageManagementPage.getTableRowsElements().get(0);
        boolean isButtonPresent = buttonName.equals(EDIT) ?
                messageManagementPage.isEditButtonPresentOnRow(firstRow) :
                messageManagementPage.isCloneButtonPresentOnRow(firstRow);
        assertThat(isButtonPresent)
                .as("Edit button is not %s", displayState)
                .isEqualTo(isDisplayed);
    }

    @Then("Message Management table sorted by {string} in {string} order")
    public void messageManagementTableSortedByInOrder(String sortedBy, String sortOrder) {
        List<String> valuesList = messageManagementPage.getListValuesForColumn(sortedBy);
        tableIsSortedByInOrder("Message Management", sortedBy, sortOrder, REACT_FORMAT, valuesList, false);
    }

    @Then("^(Cloned Record|Record) is displayed first on Message Management table$")
    public void recordIsDisplayedOnMessageManagementTable(String recordType) {
        MessageManagementData actualData = messageManagementPage.getFirstTableRowValues();
        MessageManagementData expected =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        if (recordType.contains(CLONE)) {
            expected.setName(CLONE + " - " + expected.getName());
        }
        Assertions.assertThat(actualData).as("Record Data is not as expected")
                .usingRecursiveComparison().ignoringActualNullFields().ignoringFields("status", "version")
                .isEqualTo(expected);
    }

    @Then("Record is displayed first on Message Management table with status - {string}")
    public void recordIsDisplayedOnMessageManagementTableWithStatus(String status) {
        MessageManagementData actualData = messageManagementPage.getFirstTableRowValues();
        MessageManagementData expected =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        expected.setStatus(status);
        Assertions.assertThat(actualData).as("Record Data is not as expected")
                .usingRecursiveComparison().ignoringActualNullFields().ignoringFields("version")
                .isEqualTo(expected);
    }

    @Then("Cloned Record is not displayed on Message Management table")
    public void recordIsNotDisplayedOnMessageManagementTable() {
        List<String> actualData = messageManagementPage.getMessagesNames();
        String expected = CLONE + " - " +
                ((MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA)).getName();
        Assertions.assertThat(actualData).as("Record Data is not as expected")
                .doesNotContain(expected);
    }

    @Then("Edited Cloned Record is displayed first on Message Management table")
    public void clonedRecordIsDisplayedOnMessageManagementTable() {
        messageManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        MessageManagementData actualData = messageManagementPage.getFirstTableRowValues();
        MessageManagementData expected =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        if (context.getScenarioContext().isContains(MESSAGE_NAME)) {
            String messageName = (String) context.getScenarioContext().getContext(MESSAGE_NAME);
            expected.setName(messageName);
        }
        expected.setStatus(DRAFT);
        Assertions.assertThat(actualData).as("Record Data is not as expected")
                .usingRecursiveComparison().ignoringActualNullFields().ignoringFields("version")
                .isEqualTo(expected);
        Assertions.assertThat(actualData.getVersion()).as("Version is not as expected")
                .isEqualTo(1);
    }

    @Then("Full name is displayed when hover over first Message Name in table")
    public void fullNameIsDisplayedWhenHoverOnMessageNameOnTable() {
        MessageManagementData expectedData =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        messageManagementPage.hoverOverMessageNameOnFirstRow();
        Assertions.assertThat(messageManagementPage.getTooltipText())
                .as("Name text is incorrect")
                .isEqualTo(expectedData.getName());
    }

    @Then("Message name is {string} on Clone Message window")
    public void messageNameOnCloneMessageWindowIs(String messageName) {
        if (context.getScenarioContext().isContains(messageName)) {
            messageName = ((MessageManagementData) context.getScenarioContext().getContext(messageName))
                    .getName();
        }
        Assertions.assertThat(messageManagementPage.getCloneWindowMessageName())
                .as("Message name is not %s", messageName)
                .isEqualTo(messageName);
    }

    @Then("New Message name is {string} {string} on Clone Message window")
    public void newMessageNameOnCloneMessageWindowIs(String prefix, String message) {
        if (context.getScenarioContext().isContains(message)) {
            message = ((MessageManagementData) context.getScenarioContext().getContext(message))
                    .getName();
        }
        Assertions.assertThat(messageManagementPage.getCloneWindowNewMessageName())
                .as("New Message name is not %s", prefix + message)
                .isEqualTo(prefix + message);
    }

    @Then("New Message name field is marked as required")
    public void newMessageNameFieldIsMarkedAsRequired() {
        Assertions.assertThat(messageManagementPage.isNewMessageFieldRequired())
                .as("New Message field is not required")
                .isTrue();
    }

    @Then("New Message name characters limit is shown - {string}")
    public void newMessageNameCharactersLimitIsShown(String limitMessage) {
        Assertions.assertThat(messageManagementPage.getNewMessageLimitText())
                .as("Message limit text is incorrect")
                .isEqualTo(limitMessage);
    }

    @Then("^\"(.*)\" button (is|is not) shown on (?:Clone Message window|Message page)$")
    public void buttonIsShownOnCloneMessageWindow(String buttonName, String state) {
        boolean isDisplayed = !state.contains(NOT);
        Assertions.assertThat(messageManagementPage.isButtonDisplayed(buttonName))
                .as("%s button is not shown on Clone message window")
                .isEqualTo(isDisplayed);
    }

    @Then("New Message name field is highlighted with error")
    public void newMessageNameFieldIsHighlightedWithError(String errorText) {
        Assertions.assertThat(messageManagementPage.getNewMessageFieldError())
                .as("New message field error text is not %s", errorText)
                .isEqualTo(errorText);
    }

    @Then("^Fields are (editable|not editable) on Message Management page$")
    public void messagePageIsDisplayedWithInputFields(String fieldState, List<String> fieldsNames) {
        messageManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssert = new SoftAssertions();
        boolean expectedState = !fieldState.contains(NOT);
        fieldsNames.forEach(field -> {
            boolean actualState = field.equalsIgnoreCase(CONTENT) ? messageManagementPage.isContentInputDisplayed() :
                    messageManagementPage.isFieldInputDisplayed(field);
            softAssert.assertThat(actualState)
                    .as("%s field input is not displayed", field)
                    .isEqualTo(expectedState);
        });
        softAssert.assertAll();
    }

    @Then("Message page field {string} input value is {string}")
    public void messagePageFieldInputValueIs(String fieldName, String expectedValue) {
        Assertions.assertThat(messageManagementPage.getFieldInputValue(fieldName))
                .as("Value is not %s", expectedValue)
                .isEqualTo(expectedValue);
    }

    @Then("^'Edit' icon (is|is not) displayed on Message page")
    public void editIconIsDisplayedOnMessagePage(String state) {
        boolean isDisplayed = !state.contains(NOT);
        Assertions.assertThat(messageManagementPage.isEditIconDisplayed())
                .as("Edit icon display state is not as expected")
                .isEqualTo(isDisplayed);

    }

    @Then("Message management page breadcrumb {string} is displayed")
    public void messagePageBreadcrumbIsDisplayed(String expectedText) {
        if (expectedText.contains(MESSAGE_NAME)) {
            String messageName = (String) context.getScenarioContext().getContext(MESSAGE_NAME);
            expectedText = expectedText.replace(MESSAGE_NAME, messageName);
        }
        assertThat(messageManagementPage.getBreadcrumbText(expectedText).replace(LF, SPACE))
                .as("Message management breadcrumb text is unexpected")
                .isEqualTo(expectedText.toUpperCase());
    }

    @Then("^Message (page|edit page) contains (expected updated|expected) data$")
    public void messagePageContainsExpectedData(String pageType, String dataType) {
        MessageManagementData expectedData =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        expectedData.setUpdatedDateTime(
                DateUtil.convertDateFormat(API_DATE_FORMAT, REACT_FORMAT, expectedData.getUpdatedDateTime()));
        expectedData.setEffectiveDateTime(
                DateUtil.convertDateFormat(API_DATE_FORMAT, REACT_FORMAT, expectedData.getEffectiveDateTime()));
        expectedData.setCreatedDateTime(
                DateUtil.convertDateFormat(API_DATE_FORMAT, REACT_FORMAT, expectedData.getCreatedDateTime()));
        if (dataType.contains(UPDATED)) {
            expectedData.setUpdatedDateTime(DateUtil.getTodayDate(REACT_FORMAT));
        }
        if (Objects.nonNull(expectedData.getFrequency())) {
            String unit = expectedData.getFrequency().getUnit();
            expectedData.getFrequency().setUnit(WordUtils.capitalizeFully(unit));
        }
        MessageManagementData actualData = pageType.contains(EDIT.toLowerCase()) ?
                messageManagementPage.getMessageManagementDataOnInputFields() :
                messageManagementPage.getMessageManagementData();
        Assertions.assertThat(actualData).as("Data is not as expected")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .ignoringFields("status", "updatedBy", "noticeId", "id", "createdBy", "agreementMessage", "content")
                .isEqualTo(expectedData);
    }

    @Then("Message page contains expected content text")
    public void messagePageContentContainsExpectedData() {
        MessageManagementData expectedData =
                (MessageManagementData) context.getScenarioContext().getContext(MESSAGE_MANAGEMENT_DATA);
        JaroWinklerDistance textsMatchComparator = new JaroWinklerDistance();
        final double textsMatchMinCoefficient = 0.7;
        String actualData = messageManagementPage.getMessageContent();
        Assertions.assertThat(textsMatchComparator.apply(expectedData.getContent(), actualData))
                .as("Content text is not as expected")
                .isGreaterThan(textsMatchMinCoefficient);
    }

    @Then("^Message (Name|Header) should contain maximum (\\d+) characters$")
    public void messageNameShouldContainMaximumCharacters(String fieldName, int maxCount) {
        String message = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(maxCount - 10);
        String limitText = String.format("Characters: %s/%<s", maxCount);
        if (fieldName.equalsIgnoreCase(NAME)) {
            messageManagementPage.fillInName(message);
            Assertions.assertThat(messageManagementPage.getMessageNameLimitText())
                    .as("Message name limit text is incorrect")
                    .isEqualTo(limitText);
        } else {
            messageManagementPage.fillInHeader(message);
            Assertions.assertThat(messageManagementPage.getMessageHeaderLimitText())
                    .as("Message header limit text is incorrect")
                    .isEqualTo(limitText);
        }
    }

    @Then("'Publish To' dropdown list should contain")
    public void publishToDropdownListShouldContain(List<String> expectedValues) {
        messageManagementPage.clickOnPublishToOpenCloseButton();
        List<String> actualValues = messageManagementPage.getDropDownOptions();
        messageManagementPage.clickOnPublishToOpenCloseButton();
        Assertions.assertThat(actualValues).as("Dropdown values are incorrect")
                .isEqualTo(expectedValues);
    }

    @Then("Acknowledgement Frequency dropdown list should contain")
    public void acknowledgementFrequencyDropdownListShouldContain(List<String> expectedValues) {
        messageManagementPage.clickOnUnitOpenCloseButton();
        List<String> actualValues = messageManagementPage.getDropDownOptions();
        messageManagementPage.clickOnUnitOpenCloseButton();
        Assertions.assertThat(actualValues).as("Dropdown values are incorrect")
                .isEqualTo(expectedValues);
    }

    @Then("Version dropdown list should contain")
    public void versionDropdownListShouldContain(List<String> expectedValues) {
        messageManagementPage.clickOnVersionOpenCloseButton();
        List<String> actualValues = messageManagementPage.getDropDownOptions();
        messageManagementPage.clickOnVersionOpenCloseButton();
        Assertions.assertThat(actualValues).as("Dropdown values are incorrect")
                .isEqualTo(expectedValues);
    }

    @Then("Content should contain maximum of {int} characters")
    public void contentShouldContainMaximumOfCharacters(int maxCount) {
        String message = randomAlphanumeric(maxCount);
        String limitText = String.format("Characters : %s/%<s", maxCount);
        messageManagementPage.fillInContent(message);
        Assertions.assertThat(messageManagementPage.geContentLimitText())
                .as("Content limit text is incorrect")
                .isEqualTo(limitText);
    }

    @Then("Message Name input is disabled")
    public void messageNameInputIsDisabled() {
        assertThat(messageManagementPage.isMessageNameInputDisabled())
                .as("Message name input is not disabled")
                .isTrue();
    }

}

