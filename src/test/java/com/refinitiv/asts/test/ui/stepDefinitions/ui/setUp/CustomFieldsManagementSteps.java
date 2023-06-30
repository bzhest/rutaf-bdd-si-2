package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.google.common.collect.ImmutableMap;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ApiRequestBuilder;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.CreateCustomFieldRequest;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldItem;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldsResponse;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.CustomFieldsManagementPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.CustomFieldData;
import com.refinitiv.asts.test.ui.utils.data.ui.CustomFieldsSelectChoiceDTO;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildCreateCustomFieldRequest;
import static com.refinitiv.asts.test.ui.api.ConnectApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.CHECKED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.CUSTOM_FIELDS;
import static com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.CustomFieldsManagementPage.DESCRIPTION;
import static com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.CustomFieldsManagementPage.TYPE;
import static com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement.CustomFieldsManagementPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getCurrentPageSize;
import static com.refinitiv.asts.test.ui.utils.PaginationUtil.getTotalPages;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.DATE;
import static java.lang.Boolean.parseBoolean;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Arrays.asList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.openqa.selenium.Keys.ESCAPE;
import static org.testng.AssertJUnit.assertTrue;

public class CustomFieldsManagementSteps extends BaseSteps {

    private final CustomFieldsManagementPage customFieldsPage;
    private final PaginationPage paginationPage;
    private final String choiceLabelWatermark = "Choice #%d*";
    private final ImmutableMap<String, String> chevronButtonsPosition = new ImmutableMap.Builder<String, String>()
            .put("<<", "1")
            .put("<", "2")
            .put(">", "3")
            .put(">>", "4")
            .build();
    private String selectedItemName;

    public CustomFieldsManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        customFieldsPage = new CustomFieldsManagementPage(this.driver);
        paginationPage = new PaginationPage(driver, context);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public CustomFieldData providerEntry(Map<String, String> entry) {
        return new CustomFieldData(
                entry.get(CustomFieldsManagementPage.NAME),
                entry.get(TYPE),
                entry.get(DESCRIPTION),
                entry.get(STATUS),
                entry.get(DATE_CREATED),
                entry.get(LAST_UPDATE)
        );
    }

    @When("User deletes Custom Field choice #{int}")
    public void deleteCustomFieldChoice(int choiceRowsNumber) {
        List<CustomFieldsSelectChoiceDTO> customFieldChoices = customFieldsPage.getCustomFieldChoices();
        customFieldsPage.clickOn(customFieldChoices.get(choiceRowsNumber - 1).getDeleteButton());
    }

    @When("User fills all choices with random values")
    public void fillChoicesWithRandomValues() {
        String randomChoiceText = randomAlphanumeric(5);
        customFieldsPage.fillInAllChoices(randomChoiceText);
    }

    @When("User fills in Custom Field choice #{int} value {string}")
    public void fillInCustomFieldChoiceValue(int choiceNo, String value) {
        customFieldsPage.fillInChoice(choiceNo, value);
    }

    @When("User navigates to Custom Fields page")
    public void navigateToCustomFieldsPage() {
        customFieldsPage.navigateToCustomFieldsPage();
    }

    @When("^User switches Manage Data Values checkbox (On|Off)$")
    public void switchManageDataValuesCheckbox(String state) {
        customFieldsPage.switchManageDataCheckbox(state);
    }

    @When("^User switches Active Custom Field checkbox (On|Off)$")
    public void switchStateCheckbox(String state) {
        customFieldsPage.switchStateCheckbox(state);
    }

    @When("User clicks Custom Fields in Set Up menu")
    public void clickCustomFieldsMenu() {
        customFieldsPage.clickCustomFieldsMenu();
    }

    @When("User clicks Add Custom Field button")
    public void clickAddCustomFieldBtn() {
        customFieldsPage.clickAddCustomFieldBtn();
    }

    @When("User populates in Custom Field Name with {string}")
    public void fillInCustomFieldName(String name) {
        String inputName = EMPTY;
        if (name.equals(ALREADY_EXIST_NAME)) {
            CustomFieldItem customFieldItem = getCustomFields(ALL_ITEMS, ACTIVE.toUpperCase()).getObjects().stream()
                    .filter(customField -> customField.getType().equalsIgnoreCase(TEXT)).findFirst()
                    .orElseThrow(() -> new RuntimeException("Custom Field is not found"));
            inputName = customFieldItem.getName();
            this.context.getScenarioContext().setContext(ALREADY_EXIST_NAME, inputName);
        } else if (name.isEmpty()) {
            customFieldsPage.clearFieldName();
        } else {
            inputName = name + randomAlphanumeric(10);
            this.context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_CONTEXT, inputName);
            if (context.getScenarioContext().isContains(CUSTOM_FIELD_NAME_API_CONTEXT)) {
                context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_API_CONTEXT, inputName);
            }
        }
        customFieldsPage.fillInFieldName(inputName);

    }

    @When("User populates in Custom Field Name with {string} and then cancel form")
    public void fillInCustomFieldNameAndCancelForm(String name) {
        String inputName = name + randomAlphanumeric(10);
        customFieldsPage.fillInFieldName(inputName);
    }

    @When("User updates Custom Field Name with {string}")
    public void updateCustomFieldName(String name) {
        if (CUSTOM_FIELD_NAME_API_CONTEXT.equals(name)) {
            name = AUTO_TEST_NAME_PREFIX + UUID.randomUUID();
            context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_CONTEXT, name);
        }
        customFieldsPage.clearFieldName();
        customFieldsPage.fillInFieldName(name);
    }

    @When("User populates in Custom Field Description with {string}")
    public void fillInCustomFieldDescription(String description) {
        customFieldsPage.fillInDescription(description);
    }

    @When("User selects Custom Field - Field Type {string} from dropdown")
    public void chooseCustomFieldFieldType(String fieldType) {
        customFieldsPage.selectFieldType(fieldType);
    }

    @When("User selects Custom Field Map To {string} from dropdown")
    public void selectMapToDropdownOption(String fieldType) {
        customFieldsPage.selectMapToValue(fieldType);
    }

    @When("User updates Custom Field Description with {string}")
    public void updateCustomFieldDescription(String description) {
        customFieldsPage.clearDescription();
        customFieldsPage.fillInDescription(description);
    }

    @When("^User clicks (Save|Cancel|Save as draft) button for Custom Field$")
    public void clickCustomFieldSaveBtn(String button) {
        customFieldsPage.clickButton(button);
    }

    @When("User clicks Edit button for Custom Field")
    public void clickCustomFieldEditBtn() {
        customFieldsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String name = (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        customFieldsPage.clickEditBtn(name);
    }

    @When("User clicks Edit button for Custom Field {string}")
    public void clickCustomFieldEditBtn(String customField) {
        customFieldsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String name = (String) this.context.getScenarioContext().getContext(customField);
        customFieldsPage.clickEditBtn(name);
    }

    @When("User clicks created Custom Field")
    public void clickCreatedCustomField() {
        String name = this.context.getScenarioContext().isContains(CUSTOM_FIELD_NAME_CONTEXT)
                ? (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT)
                : (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        customFieldsPage.clickViewCustomField(name);
    }

    @When("User creates Custom Field {string} via API")
    public void createCustomFieldAPI(String customFieldReference) {
        GenericTestData<CustomFieldData> customFieldsData =
                new JsonUiDataTransfer<CustomFieldData>(CUSTOM_FIELDS).getTestData().get(customFieldReference);
        if (customFieldsData.getDataToEnter().getName().isEmpty()) {
            customFieldsData.getDataToEnter().setName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        CreateCustomFieldRequest request = buildCreateCustomFieldRequest(customFieldsData.getDataToEnter());
        String fieldId = createCustomField(request).getId();
        this.context.getScenarioContext().setContext(CUSTOM_FIELD_ID_CONTEXT, fieldId);
        this.context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_API_CONTEXT, request.getName());
        context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_CONTEXT, request.getName());
    }

    @When("User refreshes page")
    public void refreshPage() {
        customFieldsPage.refreshPage();
    }

    @When("^User clicks (Proceed|Cancel) button in the 'Edit Custom Field' modal window$")
    public void clickCustomFieldProceedBtn(String button) {
        if (button.equalsIgnoreCase(PROCEED)) {
            customFieldsPage.clickProceedButtonModalWindow();
        } else {
            customFieldsPage.clickCancelButtonModalWindow();
        }
        customFieldsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks Delete button for Custom Field")
    public void clickDeleteButtonForCustomField() {
        String name = (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        customFieldsPage.clickDeleteButton(name);
    }

    @When("User clicks Delete button for Custom Field {string}")
    public void clickDeleteButtonForCustomField(String customField) {
        String name = (String) this.context.getScenarioContext().getContext(customField);
        customFieldsPage.clickDeleteButton(name);
    }

    @When("User adds {int} Custom Field choices")
    public void addChoices(Integer maxChoicesNumber) {
        List<CustomFieldsSelectChoiceDTO> choicesRows = customFieldsPage.getCustomFieldChoices();
        for (int choice = choicesRows.size(); choice < maxChoicesNumber; choice++) {
            customFieldsPage.clickOn(choicesRows.get(0).getPlusButton());
        }
    }

    @When("User clicks Custom Field table {string} field")
    public void clickCustomFieldTableField(String columnName) {
        customFieldsPage.clickColumnName(columnName);
    }

    @When("User clicks Reorder Custom Fields button")
    public void clickReorderCustomFieldsButton() {
        customFieldsPage.clickReorderButton();
    }

    @When("User selects Custom Field on position \"{int}\"")
    public void selectCustomFieldOnPosition(int position) {
        selectedItemName = customFieldsPage.getSelectedFieldName(position);
        customFieldsPage.clickCustomFieldOnPosition(position);
    }

    @When("User clicks {string} reorder chevron button")
    public void clickReorderButton(String reorderButton) {
        customFieldsPage.clickReorderChevronButton(chevronButtonsPosition.get(reorderButton));
    }

    @When("User clicks {string} Custom Fields reorder button")
    public void clickCustomFieldsReorderButton(String reorderButton) {
        if (reorderButton.equals(PageElementNames.SAVE)) {
            customFieldsPage.waitWhilePreloadProgressbarIsDisappeared();
            context.getScenarioContext().setContext(REORDERED_FIELDS_CONTEXT, customFieldsPage.getReorderFieldsList());
        }
        customFieldsPage.clickButton(reorderButton);
    }

    @When("User clicks 'Back' button for Custom Field")
    public void clickCloseButtonForCustomField() {
        customFieldsPage.clickBackButton();
    }

    @When("^User (toggles|untoggles) Custom Field Red Flag option for Choice #(\\d+)$")
    public void toggleChoiceRedFlag(String state, int choiceNumber) {
        if ((state.equals(TOGGLES) && !customFieldsPage.isRedFlagToggleTicked(choiceNumber) ||
                (state.equals(UNTOGGLES) && customFieldsPage.isRedFlagToggleTicked(choiceNumber)))) {
            customFieldsPage.toggleChoiceRedFlag(choiceNumber);
        }
    }

    @When("User remembers created Custom field {int} in context")
    public void rememberCustomFieldContext(int customFieldNumber) {
        context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_NUMBER_CONTEXT + customFieldNumber,
                                                context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT));
        context.getScenarioContext().setContext(CUSTOM_FIELD_INDEX_CONTEXT, customFieldNumber);
    }

    @When("User deletes all Custom Fields with name prefix generated by auto tests via API")
    public void deleteAllCustomFieldsWithNamePrefixGeneratedByAutoTestsViaAPI() {
        getCustomFields(PaginationPage.ENORMOUS_ITEMS_PER_PAGE, ApiRequestBuilder.ALL).getObjects()
                .forEach(CustomField -> {
                    if (CustomField.getName().startsWith(AUTO_TEST_NAME_PREFIX)) {
                        deleteCustomField(CustomField.getId());
                    }
                });
    }

    @When("User opens Custom Fields page {string}")
    public void navigateCountryChecklistSpecificPage(String page) {
        if (page.contains(TestConstants.CUSTOM_FIELD_ID)) {
            String randomCustomFieldIdId =
                    getCustomFields(PaginationPage.ENORMOUS_ITEMS_PER_PAGE, ApiRequestBuilder.ALL).getObjects().get(0)
                            .getId();
            customFieldsPage.navigateToSpecificPage(page.replaceAll(CUSTOM_FIELD_ID, randomCustomFieldIdId));
        } else {
            customFieldsPage.navigateToSpecificPage(page);
        }
    }

    @When("User clicks on 'Required' custom fields checkbox")
    public void clickOnRequiredCheckbox() {
        customFieldsPage.clickRequiredCheckbox();
    }

    @Then("^Custom Field \"(Add|Edit|View|Reorder)\" page is displayed?")
    public void customFieldModalShouldBeDisplayed(String name) {
        assertTrue(name + " Custom Field page is not displayed", customFieldsPage.isCustomFieldPageDisplayed());
    }

    @Then("Custom Field {string} modal is not displayed")
    public void customFieldModalShouldNotBeDisplayed(String name) {
        assertTrue(name + " modal is displayed", customFieldsPage.isCustomFieldModalDisappeared(name));
    }

    @Then("Created Custom Field is displayed with values")
    public void createdCustomFieldIsDisplayedWithValues(CustomFieldData expectedResult) {
        customFieldsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (expectedResult.getName().equals(VALUE_TO_REPLACE)) {
            expectedResult.setName((String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT));
        } else if (expectedResult.getName().equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            expectedResult.setName((String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT));
        }
        customFieldIsDisplayedWithValues(expectedResult.getName(), expectedResult);
    }

    @Then("Custom Field {string} is displayed with values")
    public void customFieldIsDisplayedWithValues(String customFieldName, CustomFieldData expectedResult) {
        customFieldsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (customFieldName.equals(CUSTOM_FIELD_NAME_CONTEXT)) {
            String name = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT);
            customFieldName = name;
            expectedResult.setName(name);
        }
        expectedResult.setDateCreated(getTodayDate(expectedResult.getDateCreated()))
                .setLastUpdate(nonNull(expectedResult.getLastUpdate()) ? getTodayDate(REACT_FORMAT) : EMPTY)
                .setDescription(nonNull(expectedResult.getDescription()) ? expectedResult.getDescription() : EMPTY);
        CustomFieldData actualResult = customFieldsPage.getAllFieldsValues(customFieldName);
        assertThat(actualResult).as("Custom Field is not displayed with expected values").isEqualTo(expectedResult);
    }

    @Then("Custom Fields are displayed with values")
    public void customFieldsAreDisplayedWithValues(List<CustomFieldData> customFields) {
        customFieldsPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions soft = new SoftAssertions();
        customFields.forEach(expectedField -> {
            String name;
            if (nonNull(expectedField.getName()) &&
                    expectedField.getName().contains(CUSTOM_FIELD_NAME_NUMBER_CONTEXT)) {
                name = (String) context.getScenarioContext().getContext(expectedField.getName());
                expectedField.setName(name);
            } else {
                name = expectedField.getName();
            }
            CustomFieldData actualField = customFieldsPage.getAllFieldsValues(name);
            expectedField.setDateCreated(getTodayDate(expectedField.getDateCreated()))
                    .setLastUpdate(nonNull(expectedField.getLastUpdate()) ? getTodayDate(REACT_FORMAT) : EMPTY)
                    .setDescription(nonNull(expectedField.getDescription()) ? expectedField.getDescription() : EMPTY);
            soft.assertThat(actualField)
                    .as("Custom Field is not displayed with expected values")
                    .isEqualTo(expectedField);
        });
        soft.assertAll();
    }

    @Then("Custom Field Confirmation pop-up with {string} appears")
    public void isCustomFieldModalDisplayedWithMsg(String expectedMessage) {
        assertTrue("Confirmation Modal is not displayed", customFieldsPage.isConfirmationModalDisplayed());
        String actualMsg = customFieldsPage.getConfirmationMsg().replace(LF, SPACE);
        assertThat(actualMsg).as("Custom Field Confirmation pop-up doesn't appear").isEqualTo(expectedMessage);
    }

    @Then("Custom Field Confirmation pop-up disappeared")
    public void isCustomFieldModalDisappeared() {
        assertThat(customFieldsPage.isConfirmationModalDisappeared())
                .as("Custom Field Confirmation pop-up is displayed")
                .isTrue();
    }

    @Then("Custom Fields form {string} field max length is {string} symbols")
    public void customFieldsFormFieldMaxLengthIsSymbols(String fieldName, String expectedLength) {
        assertThat(customFieldsPage.getInputMaxLength(fieldName))
                .as("Field %s max length is unexpected", fieldName)
                .isEqualTo(expectedLength);
    }

    @Then("Add Custom Field window contains fields")
    public void checkAddCustomFieldWindowContainsFields(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asList().forEach(field -> soft.assertThat(customFieldsPage.isFieldTitleDisplayed(field))
                .as(field + " is not shown")
                .isTrue());
        soft.assertAll();
    }

    @Then("Required checkbox is displayed")
    public void isRequiredCheckboxDisplayed() {
        assertThat(customFieldsPage.isRequiredCheckboxDisplayed())
                .as("Required checkbox is not displayed")
                .isTrue();
    }

    @Then("^Custom field 'Required' checkbox is (checked|unchecked)?")
    public void isRequiredCheckboxChecked(String state) {
        assertThat(customFieldsPage.isRequiredCheckboxChecked())
                .as("Required checkbox has incorrect state")
                .isEqualTo(state.equals(CHECKED));
    }

    @Then("^Custom field 'Manage Data Values' checkbox is (checked|unchecked)?")
    public void isManageDataCheckboxChecked(String state) {
        assertThat(customFieldsPage.isManageDataCheckboxChecked())
                .as("Required checkbox has incorrect state")
                .isEqualTo(state.equals(CHECKED));
    }

    @Then("User should see a note after Description block - {string}")
    public void checkCustomFieldNote(String note) {
        assertThat(customFieldsPage.isNoteDisplayed(note))
                .as(note + " is not displayed")
                .isTrue();
    }

    @Then("Custom Fields buttons should be in correct state")
    public void checkCustomFieldButtonsState(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class)
                .forEach((button, attribute) -> {
                    if (attribute.equals(DISABLED)) {
                        soft.assertThat(
                                customFieldsPage.isButtonInactive((String) button, (String) attribute))
                                .as(button + " is active").isTrue();
                    } else {
                        soft.assertThat(customFieldsPage.isButtonInactive((String) button, DISABLED))
                                .as(button + " is inactive").isFalse();
                    }
                });
        customFieldsPage.enterViaKeyboard(ESCAPE);
        soft.assertAll();
    }

    @Then("Add Custom Field window should have Field type options")
    public void checkFieldTypeOptions(DataTable data) {
        List<String> actualOptions = customFieldsPage.getDropdownFieldTypeOptionsList();
        customFieldsPage.enterViaKeyboard(ESCAPE);
        assertThat(data.asList())
                .as("Field type dropdown options are incorrect")
                .isEqualTo(actualOptions);
    }

    @Then("Add Custom Field window {string} label with dropdown options should be displayed")
    public void checkMapToDropdownOptionsAreDisplayed(String expectedLabel, DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        String actualLabel = customFieldsPage.getMapToLabelElementText();
        soft.assertThat(actualLabel).as(expectedLabel + " is not found on page").isEqualTo(expectedLabel);
        soft.assertThat(customFieldsPage.getDropdownMapToOptionsList())
                .as("'Map To' dropdown option are incorrect")
                .isEqualTo(table.asList());
        soft.assertAll();
    }

    @Then("^Delete icons should be (disabled|enabled) for all Choices$")
    public void checkIfDeleteIconAreDisabled(String state) {
        if (state.equals(DISABLED)) {
            assertThat(customFieldsPage.areAllChoiceDeleteButtonDisabled())
                    .as("Icons 'delete' are not disabled")
                    .isTrue();
        } else {
            assertThat(customFieldsPage.areAllChoiceDeleteButtonEnabled())
                    .as("Icons 'delete' are not enabled")
                    .isTrue();
        }
    }

    @Then("^Delete icons should be (disabled|enabled) for \"((.*))\" Choice$")
    public void deleteIconsShouldBeDisabledForChoice(String state, String choiceText) {
        if (state.equals(DISABLED)) {
            assertThat(customFieldsPage.isChoiceDeleteButtonDisabled(choiceText))
                    .as("Icon 'delete' is not disabled")
                    .isTrue();
        } else {
            assertThat(customFieldsPage.isChoiceDeleteButtonDisabled(choiceText))
                    .as("Icon 'delete' is not enabled")
                    .isFalse();
        }
    }

    @Then("^Plus icons should be (invisible|enabled) for all Choices$")
    public void checkLimitForChoicesToAdd(String state) {
        if (state.equals(INVISIBLE)) {
            assertThat(customFieldsPage.areAllChoicePlusButtonInvisible())
                    .as("Icons 'plus' are not invisible")
                    .isTrue();
        } else {
            assertThat(customFieldsPage.areAllChoicePlusButtonEnabled())
                    .as("Icons 'plus' are not enabled")
                    .isTrue();
        }
    }

    @Then("Add Custom Field window should have {int} Choice rows with all required elements")
    public void checkAddCustomFieldWindowContainsChoiceRows(int choiceRowsNumber) {
        SoftAssertions soft = new SoftAssertions();
        List<CustomFieldsSelectChoiceDTO> customFieldChoices = customFieldsPage.getCustomFieldChoices();
        soft.assertThat(customFieldChoices.size())
                .as("Choice rows number is not equal " + choiceRowsNumber)
                .isEqualTo(choiceRowsNumber);

        IntStream.range(0, customFieldChoices.size())
                .forEach(row -> {
                    soft.assertThat(customFieldChoices.get(row).getChoiceField())
                            .as("Choice field not found")
                            .isNotNull();
                    soft.assertThat(
                            customFieldChoices.get(row).getChoiceLabel().getText().replaceAll(ROW_DELIMITER, EMPTY))
                            .as("Choice Label").isEqualTo(
                            format(choiceLabelWatermark, row + 1));
                    soft.assertThat(customFieldChoices.get(row).getPlusButton())
                            .as("'Plus' button not found")
                            .isNotNull();
                    if (choiceRowsNumber > 2) {
                        soft.assertThat(customFieldChoices.get(row).getDeleteButton())
                                .as("'Delete' button not found")
                                .isNotNull();
                    } else {
                        soft.assertThat(customFieldChoices.get(row).getDeleteButton())
                                .as("'Delete' button is displayed")
                                .isNull();
                    }
                    soft.assertThat(customFieldChoices.get(row).getRedFlagToggle())
                            .as("'Red Flag' toggle not found")
                            .isNotNull();
                });
        soft.assertAll();
    }

    @Then("Custom field with name {string} does not exist")
    public void checkCustomFieldNotCreated(String customFieldName) {
        if (customFieldName.equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            customFieldName = (String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT);
        }
        assertThat(getCustomFieldId(customFieldName))
                .as("Custom field %s was found", customFieldName)
                .isNull();
        context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_API_CONTEXT, null);
        context.getScenarioContext().setContext(CUSTOM_FIELD_NAME_CONTEXT, null);
    }

    @Then("^Newly added row took correct place when \\+ button was clicked on (last|not last) Choice row$")
    public void checkNewlyAddedRowAppearsOnRightPlace(String rowToClickPlace) {
        SoftAssertions soft = new SoftAssertions();
        String randomChoiceName1 = randomAlphanumeric(5);
        String randomChoiceName2 = randomAlphanumeric(5);
        List<CustomFieldsSelectChoiceDTO> choicesRows = customFieldsPage.getCustomFieldChoices();
        String lastRowToClick = "last";
        if (rowToClickPlace.equals(lastRowToClick)) {
            int lastChoiceRow = choicesRows.size() - 1;
            CustomFieldsSelectChoiceDTO choice = choicesRows.get(lastChoiceRow);
            choice.getChoiceField().sendKeys(randomChoiceName1);
            int choicesNumberBeforeAdd = customFieldsPage.getChoicesRowsNumber();
            customFieldsPage.clickOn(choice.getPlusButton());
            customFieldsPage.waitNewChoiceIsAdded(choicesNumberBeforeAdd);

            List<CustomFieldsSelectChoiceDTO> newChoicesRows = customFieldsPage.getCustomFieldChoices();
            int newLastChoiceRow = newChoicesRows.size() - 1;
            soft.assertThat(newChoicesRows.get(newLastChoiceRow).getChoiceField().getAttribute(VALUE))
                    .as("Newly added Choice is not last in a list of Choices")
                    .isEqualTo(EMPTY);
            soft.assertThat(newChoicesRows.get(newLastChoiceRow - 1).getChoiceField().getAttribute(VALUE))
                    .as("Choice row, where + button was clicked is not penultimate in a list of Choices")
                    .isEqualTo(randomChoiceName1);

        } else {
            int randomChoiceRow = new Random().nextInt(choicesRows.size() - 1);
            CustomFieldsSelectChoiceDTO choice = choicesRows.get(randomChoiceRow);
            CustomFieldsSelectChoiceDTO nextChoice = choicesRows.get(randomChoiceRow + 1);
            choice.getChoiceField().sendKeys(randomChoiceName1);
            nextChoice.getChoiceField().sendKeys(randomChoiceName2);
            int choicesNumberBeforeAdd = customFieldsPage.getChoicesRowsNumber();
            customFieldsPage.clickOn(choice.getPlusButton());
            customFieldsPage.waitNewChoiceIsAdded(choicesNumberBeforeAdd);

            List<CustomFieldsSelectChoiceDTO> newChoicesRows = customFieldsPage.getCustomFieldChoices();
            soft.assertThat(newChoicesRows.get(randomChoiceRow).getChoiceField().getAttribute(VALUE))
                    .as("Choice row, where + button was clicked is not placed before newly added row")
                    .isEqualTo(randomChoiceName1);
            soft.assertThat(newChoicesRows.get(randomChoiceRow + 1).getChoiceField().getAttribute(VALUE))
                    .as("Newly add row is not placed after row, where + button was clicked")
                    .isEqualTo(EMPTY);
            soft.assertThat(newChoicesRows.get(randomChoiceRow + 2).getChoiceField().getAttribute(VALUE))
                    .as("Next to newly added row is not placed right after newly created row")
                    .isEqualTo(randomChoiceName2);
        }
        soft.assertAll();
    }

    @Then("Error message {string} is displayed for the next fields on Custom Field form")
    public void errorMessageIsDisplayedForFields(String expectedMessage, List<String> fieldNames) {
        if (expectedMessage.contains(ALREADY_EXIST_NAME)) {
            expectedMessage = expectedMessage.replace(ALREADY_EXIST_NAME, (String) context.getScenarioContext()
                    .getContext(ALREADY_EXIST_NAME));
        }
        SoftAssert softAssert = new SoftAssert();
        for (String name : fieldNames) {
            softAssert.assertEquals(customFieldsPage.getErrorMessage(name), expectedMessage,
                                    "'This field is required' error message is not displayed for field " + name);
        }
        softAssert.assertAll();
    }

    @Then("^Custom Field Manage Data Value checkbox is (selected|unselected|invisible)$")
    public void customFieldManageDataValueCheckboxIsSelected(String state) {
        switch (state) {
            case SELECTED:
                assertThat(customFieldsPage.isManageDataCheckboxSelected())
                        .as("Custom Field Manage Data Value checkbox is not selected").isTrue();
                break;
            case UNSELECTED:
                assertThat(customFieldsPage.isManageDataCheckboxSelected())
                        .as("Custom Field Manage Data Value checkbox is selected").isFalse();
                break;
            case INVISIBLE:
                assertThat(customFieldsPage.isManageDataCheckboxDisplayed())
                        .as("Custom Field Manage Data Value checkbox is visible").isFalse();
                break;
            default:
                throw new IllegalArgumentException("Unsupported state: " + state);
        }
    }

    @Then("^Custom Field Active checkbox is (selected|invisible|unselected)$")
    public void customFieldActiveCheckboxIsSelected(String state) {
        switch (state) {
            case SELECTED:
                assertThat(customFieldsPage.isActiveCheckboxSelected())
                        .as("Custom Field Active checkbox is not selected").isTrue();
                break;
            case UNSELECTED:
                assertThat(customFieldsPage.isActiveCheckboxSelected())
                        .as("Custom Field Active checkbox is selected").isFalse();
                break;
            case INVISIBLE:
                assertThat(customFieldsPage.isActiveCheckboxDisplayed())
                        .as("Custom Field Active checkbox is visible").isFalse();
                break;
            default:
                throw new IllegalArgumentException("Unsupported state: " + state);
        }
    }

    @Then("Custom Field Field Type is disabled")
    public void customFieldFieldTypeIsDisabled() {
        assertThat(customFieldsPage.isFieldTypeDisabled())
                .as("Custom Field Field Type is not disabled").isTrue();
    }

    @Then("Custom Field Manage Data is disabled")
    public void customFieldManageDataIsDisabled() {
        assertThat(customFieldsPage.isManageDataDisabled())
                .as("Custom Field Manage Data is not disabled").isTrue();
    }

    @Then("^Custom Field Map to is (disabled|invisible)$")
    public void customFieldMapToIsDisabled(String state) {
        switch (state) {
            case DISABLED:
                assertThat(customFieldsPage.isMapToDisabled())
                        .as("Custom Field Map to is not disabled").isTrue();
                break;
            case INVISIBLE:
                assertThat(customFieldsPage.isMapToDisplayed())
                        .as("Custom Field Map to is is visible").isFalse();
                break;
            default:
                throw new IllegalArgumentException("Unsupported state: " + state);
        }
    }

    @Then("Custom Fields tab is not displayed")
    public void customFieldsOptionIsNotDisplayed() {
        assertThat(customFieldsPage.isCustomFieldsOptionDisplayed())
                .as("Custom Fields option is displayed").isFalse();
    }

    @Then("Custom Fields table displayed with following columns")
    public void customFieldsTableDisplayedWithFollowingColumns(List<String> expectedColumns) {
        assertThat(customFieldsPage.getTableColumns())
                .as("Custom Fields table doesn't contains expected columns")
                .isEqualTo(expectedColumns);
    }

    @Then("Add Custom Field button is displayed")
    public void addCustomFieldButtonIsDisplayed() {
        assertThat(customFieldsPage.isAddCustomFieldDisplayed())
                .as("Add Custom Field button is not displayed").isTrue();
    }

    @Then("Reorder button is displayed")
    public void reorderButtonIsDisplayed() {
        assertThat(customFieldsPage.isReorderButtonDisplayed())
                .as("Reorder button is displayed").isTrue();
    }

    @Then("For each Custom Field record controls buttons should be displayed")
    public void forEachCustomFieldRecordControlsButtonsShouldBeDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(customFieldsPage.areDeleteButtonsDisplayedForEachRow(),
                              "Not all delete buttons are displayed");
        softAssert.assertTrue(customFieldsPage.areEditButtonsDisplayedForEachRow(),
                              "Not all edit buttons are displayed");
        softAssert.assertAll();
    }

    @Then("Custom Fields table is sorted according to {string} field in {string} order")
    public void customFieldsTableIsSortedAccordingToFieldInOrder(String columnName, String sortOrder) {
        List<String> valuesList = customFieldsPage.getListValuesForColumn(columnName.toUpperCase());
        valuesList.removeAll(asList(null, DASH));
        if (columnName.toLowerCase().contains(DATE.toLowerCase())) {
            List<Date> dateList = valuesList.stream().map(date -> getDateFromStringDate(date, REACT_FORMAT))
                    .collect(Collectors.toList());
            assertThat(dateList).as("Custom Fields table is not sorted in %s order", sortOrder)
                    .isSortedAccordingTo(getDateComparator(sortOrder));
        } else {
            assertThat(valuesList).as("Custom Fields table is not sorted in %s order", sortOrder)
                    .isSortedAccordingTo(getStringComparator(sortOrder, false));
        }
    }

    @Then("Custom Fields for page size {int} displayed with all recalculated {string} items")
    public void customFieldsDisplayedWithAllRecalculatedItems(int pageSize, String showOption) {
        SoftAssert softAssert = new SoftAssert();
        CustomFieldsResponse customFieldResponse = getCustomFields(pageSize, showOption);
        if (customFieldResponse.getTotal() == 0) {
            String noRecordsFound = "NO MATCH FOUND";
            softAssert.assertEquals(customFieldsPage.getTableText(), noRecordsFound,
                                    "Custom Fields table is not empty");
        } else {
            int from = 1;
            int totalPages = getTotalPages(customFieldResponse.getTotal(), pageSize);
            int to = getCurrentPageSize(customFieldResponse.getTotal(), pageSize, 0);
            String paginationInformationFormat = "%s to %s of %s";
            String expectedPagesInformation =
                    format(paginationInformationFormat, from, to, customFieldResponse.getTotal());
            String actualPagesInformation = customFieldsPage.getPaginationInformation();
            softAssert.assertEquals(actualPagesInformation, expectedPagesInformation,
                                    "First page pagination information is unexpected");
            for (int page = 1; page < totalPages; page++) {
                paginationPage.clickNextPageButtonAndWait();
                from += pageSize;
                to += getCurrentPageSize(customFieldResponse.getTotal(), pageSize, page);
                expectedPagesInformation =
                        format(paginationInformationFormat, from, to, customFieldResponse.getTotal());
                actualPagesInformation = customFieldsPage.getPaginationInformation();
                softAssert.assertEquals(actualPagesInformation, expectedPagesInformation,
                                        format("Current page %s pagination information is unexpected after next button click",
                                               page));

            }
            for (int page = totalPages - 1; page > 0; page--) {
                paginationPage.clickPreviousPageButton();
                from -= pageSize;
                to -= getCurrentPageSize(customFieldResponse.getTotal(), pageSize, page);
                expectedPagesInformation =
                        format(paginationInformationFormat, from, to, customFieldResponse.getTotal());
                actualPagesInformation = customFieldsPage.getPaginationInformation();
                softAssert.assertEquals(expectedPagesInformation, actualPagesInformation,
                                        format("Current page %s pagination information is unexpected after previous button click",
                                               page));

            }
        }
        softAssert.assertAll();

    }

    @Then("Custom Fields reorder page is displayed")
    public void customFieldsReorderPageIsDisplayed() {
        context.getScenarioContext().setContext(INITIAL_FIELDS_CONTEXT, customFieldsPage.getReorderFieldsList());
        assertThat(customFieldsPage.isCustomFieldPageDisplayed())
                .as("Custom Fields reorder modal is not displayed").isTrue();
    }

    @Then("All active Custom Fields are displayed in the list")
    public void allSortedActiveCustomFieldsAreDisplayedInTheList() {
        customFieldsPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> expectedList = getCustomFields(ALL_ITEMS, ACTIVE.toUpperCase()).getObjects().stream()
                .map(CustomFieldItem::getName)
                .collect(Collectors.toList());
        assertThat(customFieldsPage.getReorderFieldsList(expectedList.size())).usingRecursiveComparison()
                .ignoringCollectionOrder()
                .as("Reorder Custom Fields list is unexpected").isEqualTo(expectedList);
    }

    @Then("Reorder Custom Fields Chevron buttons are disabled")
    public void reorderCustomFieldsChevronButtonsAreDisabled() {
        SoftAssert softAssert = new SoftAssert();
        chevronButtonsPosition.keySet()
                .forEach(button -> softAssert.assertTrue(
                        customFieldsPage.isChevronButtonDisabled(chevronButtonsPosition.get(button)),
                        format("Reorder Custom Fields Chevron %s button is not disabled", button)));
        softAssert.assertAll();
    }

    @Then("Moved Custom Field on position {string}")
    public void movedCustomFieldOnPosition(String position) {
        List<String> reorderFieldsList = customFieldsPage.getReorderFieldsList();
        int expectedPosition = position.equals(LAST) ? reorderFieldsList.size() - 1 : parseInt(position);
        assertThat(reorderFieldsList.indexOf(selectedItemName))
                .as("Moved Custom Field position is unexpected").isEqualTo(expectedPosition);
    }

    @SuppressWarnings("unchecked")
    @Then("Custom Fields is sorted in {string} order")
    public void customFieldsIsSortedInOrder(String orderReference) {
        List<String> expectedFieldsList = (List<String>) context.getScenarioContext().getContext(orderReference);
        assertThat(customFieldsPage.getReorderFieldsList())
                .as("Reorder Custom Fields list order is unexpected").isEqualTo(expectedFieldsList);
    }

    @Then("View Custom Field 'Edit' button is displayed")
    public void viewCustomFieldModalButtonsAreDisplayed() {
        assertThat(customFieldsPage.isEditOverviewButtonDisplayed())
                .as("View Custom Field edit button is no displayed")
                .isTrue();
    }

    @Then("Custom Field overview is displayed with values")
    public void customFieldOverviewIsDisplayedWithValues(CustomFieldData expectedResult) {
        if (expectedResult.getName().equals(CUSTOM_FIELD_NAME_API_CONTEXT)) {
            expectedResult.setName((String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_API_CONTEXT));
        }
        if (expectedResult.getName().equals(CUSTOM_FIELD_NAME_CONTEXT)) {
            expectedResult.setName((String) context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT));
        }
        assertThat(customFieldsPage.getCustomFieldOverviewDetails())
                .as("Custom Field details are unexpected").isEqualTo(expectedResult);
    }

    @Then("Custom Field Manage Data Value list contains {int} options with {string} red flag")
    public void customFieldManageDataValueListContainsOptionsWithTrueRedFlag(int expectedCount, String redFlagState) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(customFieldsPage.getCustomFieldChoices().size(), expectedCount,
                                "Manage Data Value list count is unexpected");
        softAssert.assertTrue(customFieldsPage.areAllChoicesRedFlagExpected(redFlagState),
                              "Red flags state is unexpected");
        softAssert.assertAll();
    }

    @Then("^Custom Field Manage Data Value list contains option (\\d+) with (true|false) red flag$")
    public void customFieldManageDataValueContainsChoiceWithRedRedFlag(int choiceNumber, String redFlagState) {
        assertThat(customFieldsPage.isChoicesRedFlagExpected(choiceNumber)).as(
                "Choice %d has incorrect red flag state - %s", choiceNumber, redFlagState)
                .isEqualTo(parseBoolean(redFlagState));
    }

    @Then("Custom Field Map to contains {string}")
    public void customFieldMapToContains(String expectedValue) {
        assertThat(customFieldsPage.getMapToFieldText())
                .as("Custom Field Map to doesn't contain expected value").isEqualTo(expectedValue);
    }

    @Then("Custom Fields choice # {int} field max length is {string} symbols")
    public void customFieldsFormFieldMaxLengthIsSymbols(Integer choiceNumber, String expectedLength) {
        assertThat(customFieldsPage.getChoiceMaxLength(choiceNumber))
                .as("Choice %s max length is unexpected", choiceNumber)
                .isEqualTo(expectedLength);
    }

}