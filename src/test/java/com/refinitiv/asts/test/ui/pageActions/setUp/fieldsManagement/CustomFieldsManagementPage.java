package com.refinitiv.asts.test.ui.pageActions.setUp.fieldsManagement;

import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldItem;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.CustomFieldsManagementPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.CustomFieldData;
import com.refinitiv.asts.test.ui.utils.data.ui.CustomFieldsSelectChoiceDTO;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.OFF;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.ON;
import static com.refinitiv.asts.test.ui.constants.Pages.CUSTOM_FIELDS_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static java.util.stream.Collectors.toUnmodifiableList;
import static org.apache.logging.log4j.util.Strings.EMPTY;
import static org.openqa.selenium.By.id;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class CustomFieldsManagementPage extends BasePage<CustomFieldsManagementPage> {

    public static final String NAME = "Name";
    public static final String FIELD_NAME = "Field Name";
    public static final String TYPE = "Field Type";
    public static final String FIELD_TYPE = "Field Type";
    public static final String DESCRIPTION = "Description";
    public static final String STATUS = "Status";
    public static final String DATE_CREATED = "Date Created";
    public static final String LAST_UPDATE = "Last Update";
    public static final String MAP_TO = "Map To";

    private final CustomFieldsManagementPO customFieldsPO;

    public CustomFieldsManagementPage(WebDriver driver) {
        super(driver);
        customFieldsPO = new CustomFieldsManagementPO(driver);
    }

    public void navigateToCustomFieldsPage() {
        driver.get(URL + CUSTOM_FIELDS_PATH);
    }

    public void clickCustomFieldsMenu() {
        clickOn(customFieldsPO.getCustomFieldsMenu(), waitShort);
    }

    public void clickAddCustomFieldBtn() {
        try {
            clickOn(customFieldsPO.getAddCustomFieldBtn(), waitLong);
        } catch (TimeoutException ex) {
            clickOn(customFieldsPO.getAddCustomFieldBtnIfNoAvailable(), waitLong);
        }
    }

    public void clearFieldName() {
        clearText(getElement(customFieldsPO.getFieldName()));
    }

    public String getInputMaxLength(String fieldName) {
        return getAttributeValue(xpath(format(customFieldsPO.getCustomFieldValue(), fieldName)), MAX_LENGTH);
    }

    public void clearDescription() {
        clearText(getElement(customFieldsPO.getDescription()));
    }

    public void fillInFieldName(String name) {
        clearAndInputField(customFieldsPO.getFieldName(), name);
    }

    public void fillInAllChoices(String randomChoiceText) {
        List<CustomFieldsSelectChoiceDTO> customFieldChoices = getCustomFieldChoices();
        customFieldChoices.forEach(choice -> choice.getChoiceField().sendKeys(randomChoiceText));
    }

    public void fillInChoice(int choiceNo, String value) {
        CustomFieldsSelectChoiceDTO customFieldChoice = getCustomFieldChoices().get(choiceNo - 1);
        customFieldChoice.getChoiceField().sendKeys(value);
    }

    public String getChoiceMaxLength(int choiceNo) {
        CustomFieldsSelectChoiceDTO customFieldChoice = getCustomFieldChoices().get(choiceNo - 1);
        return getAttributeValue(customFieldChoice.getChoiceField(), MAX_LENGTH);
    }

    public void fillInDescription(String description) {
        clearAndInputField(customFieldsPO.getDescription(), description);
    }

    public void selectFieldType(String fieldType) {
        By dropdownOption = xpath(format(customFieldsPO.getDropDownListValues(), fieldType));
        if (isElementDisplayedNow(dropdownOption)) {
            clickOn(getElement(dropdownOption));
        }
        clickOn(customFieldsPO.getDropDownFieldType());
        clickOn(getElement(dropdownOption));
    }

    public void clickEditBtn(String fieldName) {
        clickOn(xpath(format(customFieldsPO.getEditBtn(), fieldName)), waitShort);
    }

    public void clickViewCustomField(String fieldName) {
        clickWithJS(driver.findElement(xpath(format(customFieldsPO.getRowValue(), fieldName))));
    }

    public void clickDeleteButton(String fieldName) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickOn(xpath(format(customFieldsPO.getDeleteBtn(), fieldName)), waitShort);
    }

    public void clickProceedButtonModalWindow() {
        clickOn(customFieldsPO.getProceedButtonModalWindow());
    }

    public void clickCancelButtonModalWindow() {
        clickOn(customFieldsPO.getCancelButtonModalWindow());
    }

    public void clickButton(String buttonText) {
        clickOn(xpath(format(customFieldsPO.getButton(), buttonText)));
    }

    public void switchManageDataCheckbox(String state) {
        if ((state.equals(ON) && !isManageDataCheckboxSelected()) ||
                (state.equals(OFF) && isManageDataCheckboxSelected())) {
            clickManageDataCheckbox();
        }
    }

    public void switchStateCheckbox(String state) {
        if ((state.equals(ON) && !isActiveCheckboxSelected()) ||
                (state.equals(OFF) && isActiveCheckboxSelected())) {
            clickActiveCheckbox();
        }
    }

    public void clickManageDataCheckbox() {
        clickOn(customFieldsPO.getManageDataValuesCheckbox());
    }

    public void clickActiveCheckbox() {
        clickOn(customFieldsPO.getActiveCheckbox());
    }

    public void selectMapToValue(String fieldType) {
        By dropdownOption = xpath(format(customFieldsPO.getDropDownListValues(), fieldType));
        if (isElementDisplayedNow(dropdownOption)) {
            clickOn(getElement(dropdownOption));
        }
        clickOn(customFieldsPO.getMapToDropdown());
        clickOn(getElement(dropdownOption));
    }

    public void clickColumnName(String columnName) {
        clickOn(xpath(format(customFieldsPO.getColumnName(), columnName)));
    }

    public void clickReorderButton() {
        clickOn(customFieldsPO.getReorderButton());
    }

    public void clickCustomFieldOnPosition(int position) {
        clickOn(xpath(format(customFieldsPO.getReorderListItem(), position + 1)));
    }

    public void clickReorderChevronButton(String position) {
        clickOn(id(format(customFieldsPO.getReorderChevronButton(), position)));
    }

    public void clickBackButton() {
        clickOn(customFieldsPO.getBreadcrumbPageButton());
    }

    public boolean isCustomFieldPageDisplayed() {
        return isElementDisplayed(waitShort, customFieldsPO.getBreadcrumbPageButton());
    }

    public boolean isCustomFieldModalDisappeared(String name) {
        return isElementDisappeared(waitShort, xpath(format(customFieldsPO.getCustomFieldModal(), name)));
    }

    public boolean isChoiceDeleteButtonDisabled(String optionValue) {
        return isChoiceButtonDisabled(
                getElement(xpath(format(customFieldsPO.getDeleteChoiceButton(), optionValue))));
    }

    public boolean isChoiceButtonDisabled(WebElement button) {
        return isElementAttributeContains(button, CLASS, DISABLED);
    }

    public boolean areAllChoiceDeleteButtonDisabled() {
        return getCustomFieldChoices().stream().allMatch(choice -> isChoiceButtonDisabled(choice.getDeleteButton()));
    }

    public boolean areAllChoiceDeleteButtonEnabled() {
        return getCustomFieldChoices().stream().noneMatch(choice -> isChoiceButtonDisabled(choice.getDeleteButton()));
    }

    public boolean areAllChoicePlusButtonInvisible() {
        return getElements(customFieldsPO.getRedFlagToggle()).isEmpty();
    }

    public boolean areAllChoicePlusButtonEnabled() {
        return getCustomFieldChoices().stream().noneMatch(choice -> isChoiceButtonDisabled(choice.getPlusButton()));
    }

    public boolean isFieldTypeDisabled() {
        return isElementAttributeContains(customFieldsPO.getDropDownFieldType(), CLASS, DISABLED);
    }

    public boolean isManageDataDisabled() {
        return isElementAttributeContains(customFieldsPO.getManageDataValuesSpan(), CLASS, DISABLED);
    }

    public boolean isMapToDisabled() {
        return isElementAttributeContains(customFieldsPO.getMapToDropdown(), CLASS, DISABLED);
    }

    public boolean isMapToDisplayed() {
        return isElementDisplayed(customFieldsPO.getMapToDropdown());
    }

    public boolean isFieldTitleDisplayed(String title) {
        return getElementsText(getElements(customFieldsPO.getFieldLabel())).stream()
                .map(option -> option.replace(ROW_DELIMITER, EMPTY))
                .map(String::trim)
                .collect(toUnmodifiableList())
                .contains(title);
    }

    public boolean isRequiredCheckboxDisplayed() {
        return isElementDisplayed(customFieldsPO.getRequiredCheckbox());
    }

    public boolean isRequiredCheckboxChecked() {
        return isElementAttributeContains(
                getElement(customFieldsPO.getRequiredCheckbox()).findElement(customFieldsPO.getParentElement()), CLASS,
                CHECKED);
    }

    public void clickRequiredCheckbox() {
        clickOn(customFieldsPO.getRequiredCheckbox());
    }

    public boolean isNoteDisplayed(String text) {
        return isElementDisplayed(xpath(format(customFieldsPO.getNoteText(), text)));
    }

    public boolean isButtonInactive(String buttonText, String attribute) {
        return isAttributePresent(xpath(format(customFieldsPO.getButton(), buttonText)), attribute);
    }

    public boolean isManageDataCheckboxSelected() {
        return isElementAttributeContains(customFieldsPO.getManageDataValuesSpan(), CLASS, CHECKED);
    }

    public boolean isManageDataCheckboxDisplayed() {
        return isElementDisplayed(customFieldsPO.getManageDataValuesCheckbox());
    }

    public boolean isManageDataCheckboxChecked() {
        return isAttributePresent(customFieldsPO.getManageDataValuesCheckbox(), CHECKED);
    }

    public boolean isActiveCheckboxSelected() {
        return isElementAttributeContains(customFieldsPO.getActiveCheckbox(), CLASS, CHECKED);
    }

    public boolean isActiveCheckboxDisplayed() {
        return isElementDisplayed(customFieldsPO.getActiveCheckbox());
    }

    public boolean isConfirmationModalDisplayed() {
        return isElementDisplayed(waitShort, customFieldsPO.getConfirmationModal());
    }

    public boolean isConfirmationModalDisappeared() {
        return isElementDisappeared(waitLong, customFieldsPO.getConfirmationModal());
    }

    public boolean isCustomFieldsOptionDisplayed() {
        return isElementDisplayed(customFieldsPO.getCustomFieldsTab());
    }

    public boolean isAddCustomFieldDisplayed() {
        return isElementDisplayed(customFieldsPO.getAddCustomFieldBtn());
    }

    public boolean isReorderButtonDisplayed() {
        return isElementDisplayed(customFieldsPO.getReorderButton());
    }

    public boolean areDeleteButtonsDisplayedForEachRow() {
        return driver.findElements(customFieldsPO.getTableRow()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(customFieldsPO.getDeleteRowButton())));
    }

    public boolean areEditButtonsDisplayedForEachRow() {
        return driver.findElements(customFieldsPO.getTableRow()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(customFieldsPO.getEditRowButton())));
    }

    public boolean isChevronButtonDisabled(String position) {
        return isElementAttributeContains(id(format(customFieldsPO.getReorderChevronButton(), position)), CLASS,
                                          DISABLED);
    }

    public boolean isEditOverviewButtonDisplayed() {
        return isElementDisplayed(customFieldsPO.getSwitchToEditButton());
    }

    public boolean areAllChoicesRedFlagExpected(String redFlagState) {
        if (parseBoolean(redFlagState)) {
            return getCustomFieldChoices().stream()
                    .allMatch(choice -> isAttributePresent(choice.getRedFlagToggle(), CHECKED));
        } else {
            return getCustomFieldChoices().stream()
                    .noneMatch(choice -> isAttributePresent(choice.getRedFlagToggle(), CHECKED));
        }
    }

    public boolean isChoicesRedFlagExpected(int choiceNumber) {
        return isAttributePresent(getCustomFieldChoices().get(choiceNumber - 1).getRedFlagToggle(), CHECKED);
    }

    public String getConfirmationMsg() {
        return getElementText(customFieldsPO.getConfirmationModal());
    }

    public String getErrorMessage(String fieldName) {
        return getElementText(xpath(format(customFieldsPO.getErrorMessage(), fieldName)));
    }

    public CustomFieldData getAllFieldsValues(String customFieldName) {
        waitWhilePreloadProgressbarIsDisappeared();
        List<String> listOfValues =
                getElementsTextsWithBlank(xpath(format(customFieldsPO.getRowValue(), customFieldName)));
        return new CustomFieldData(listOfValues.get(0),
                                   listOfValues.get(1),
                                   listOfValues.get(2),
                                   listOfValues.get(3),
                                   listOfValues.get(4),
                                   listOfValues.get(5));
    }

    public CustomFieldData getCustomFieldOverviewDetails() {
        waitWhilePreloadProgressbarIsDisappeared();
        return new CustomFieldData().setName(getFieldValue())
                .setDescription(getFieldText(DESCRIPTION))
                .setType(getFieldText(FIELD_TYPE));
    }

    public String getMapToFieldText() {
        return getAttributeOrText(xpath(format(customFieldsPO.getMapToFieldValue(), MAP_TO)), VALUE);
    }

    private String getFieldText(String fieldName) {
        return getAttributeOrText(xpath(format(customFieldsPO.getFieldValue(), fieldName)), VALUE);
    }

    private String getFieldValue() {
        return getAttributeValue(xpath(format(customFieldsPO.getFieldValueInput(),
                                              FIELD_NAME)), VALUE);
    }

    public String getMapToLabelElementText() {
        return getElementText(customFieldsPO.getMapToLabel()).replaceAll(ROW_DELIMITER, EMPTY);
    }

    public String getTableText() {
        return getElementText(customFieldsPO.getCustomFieldsTable());
    }

    public String getPaginationInformation() {
        return getElementText(customFieldsPO.getPaginationInformation());
    }

    public String getSelectedFieldName(int position) {
        return getElementText(xpath(format(customFieldsPO.getReorderListItem(), position + 1)));
    }

    public List<String> getDropdownFieldTypeOptionsList() {
        clickOn(customFieldsPO.getDropDownFieldType());
        return getElementsText(getElements(customFieldsPO.getDropdownOptions()));
    }

    public List<String> getDropdownMapToOptionsList() {
        clickOn(customFieldsPO.getMapToDropdown());
        return getElementsText(getElements(waitMoment, customFieldsPO.getDropdownOptions()));
    }

    public List<String> getTableColumns() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementsText(getElements(waitMoment, customFieldsPO.getColumnNameList()));
    }

    public List<String> getReorderFieldsList(int expectedCount) {
        try {
            waitShort.until(numberOfElementsToBe(xpath(customFieldsPO.getReorderListItems()), expectedCount));
        } catch (TimeoutException e) {
            logger.error("Current count of items in table is not expected");
        }
        return getElementsText(
                waitShort.until(visibilityOfAllElementsLocatedBy(xpath(customFieldsPO.getReorderListItems()))));
    }

    public List<String> getReorderFieldsList() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementsText(
                waitShort.until(visibilityOfAllElementsLocatedBy(xpath(customFieldsPO.getReorderListItems()))));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getTableColumns().indexOf(columnName) + 1;
        return driver.findElements(customFieldsPO.getTableRow()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(customFieldsPO.getTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    public int getChoicesRowsNumber() {
        return getElements(customFieldsPO.getChoiceRows()).size();
    }

    public void waitNewChoiceIsAdded(int expectedChoiceNumber) {
        waitShort.until(
                ExpectedConditions.numberOfElementsToBe(customFieldsPO.getChoiceRows(), expectedChoiceNumber + 1));
    }

    public List<CustomFieldsSelectChoiceDTO> getCustomFieldChoices() {
        List<WebElement> elements = waitMoment.until(numberOfElementsToBeMoreThan(customFieldsPO.getChoiceRows(), 0));
        List<CustomFieldsSelectChoiceDTO> list = new ArrayList<>();
        for (int i = 0; i < elements.size(); i++) {
            CustomFieldsSelectChoiceDTO customFieldsSelectChoiceDTO = new CustomFieldsSelectChoiceDTO()
                    .setChoiceField(getElements(customFieldsPO.getChoiceInput()).get(i))
                    .setChoiceLabel(getElement(xpath(format(customFieldsPO.getChoiceLabel(), i + 1))))
                    .setPlusButton(getElements(customFieldsPO.getPlusButton()).get(i))
                    .setRedFlagToggle(getElements(customFieldsPO.getRedFlagToggle()).get(i))
                    .setDeleteButton(getElement(xpath(format(customFieldsPO.getDeleteButton(), i + 1))));
            list.add(customFieldsSelectChoiceDTO);
        }
        return list;
    }

    public boolean isRedFlagToggleTicked(int choiceNumber) {
        return isElementAttributeContains(xpath(format(customFieldsPO.getRedFlagToggleForChoice(), choiceNumber)),
                                          CLASS, CHECKED);
    }

    public void toggleChoiceRedFlag(int choiceNumber) {
        clickOn(xpath(format(customFieldsPO.getRedFlagToggleForChoice(), choiceNumber)));
    }

    public void unsetRequiredFromCustomFieldsViaApi() {
        List<CustomFieldItem> customFields = ConnectApi.getAllCustomFields().getObjects().stream()
                .filter(CustomFieldItem::isRequired).collect(Collectors.toList());
        customFields.forEach(fieldItem -> {
            fieldItem.setRequired(false);
            ConnectApi.updateCustomField(fieldItem);
        });
    }

    @Override
    protected ExpectedCondition<CustomFieldsManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

}
