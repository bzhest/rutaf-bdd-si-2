package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.CountryChecklistPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.countryChecklist.CountryChecklistData;
import com.refinitiv.asts.test.ui.utils.ImageUtil;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.TO_LEFT;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.TO_RIGHT;
import static com.refinitiv.asts.test.ui.constants.Pages.COUNTRY_CHECK_LIST;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class CountryChecklistPage extends BasePage<ValueManagementPage> {

    public static final String NAME = "List Name";
    public static final String ALERT = "Alert Type";
    public static final String STATUS = "Status";
    public static final String DATE_CREATED = "Date Created";
    public static final String LAST_UPDATE = "Last Update";
    public static final String INFORMATIONAL = "Informational";
    public static final String CAUTION = "Caution";
    public static final String WARNING = "Warning";
    public static final Dimension dimensionWithPixelRatio_1_25 = new Dimension(1920, 1080);
    private final Map<String, Integer> countryChecklistColumns = Map.of(NAME, 1,
                                                                        ALERT, 2,
                                                                        STATUS, 3,
                                                                        DATE_CREATED, 4,
                                                                        LAST_UPDATE, 5);

    private final CountryChecklistPO countryChecklistPO;

    public CountryChecklistPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        countryChecklistPO = new CountryChecklistPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<ValueManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitShort, countryChecklistPO.getCountryChecklistPage());
    }

    public boolean isCountryChecklistActiveCheckboxChecked() {
        return isCheckboxChecked(countryChecklistPO.getActive());
    }

    public boolean isCountryChecklistAlertTypeTicked(String option) {
        return nonNull(
                getAttributeValue(getElementByXPath(format(countryChecklistPO.getAlertTypeOptionInput(), option)),
                                  CHECKED));
    }

    public boolean isDetailsPageDisplayed(String page) {
        return isElementDisplayed(waitShort, xpath(format(countryChecklistPO.getDetailsPageBreadcrumbs(), page)));
    }

    public boolean isCountryDisplayedInList(String country, String listName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(countryChecklistPO.getCountryAssign(), listName, country)));
    }

    public boolean isButtonWithTextDisplayed(String buttonText) {
        return isElementDisplayed(xpath(format(countryChecklistPO.getButtonWithText(), buttonText)));
    }

    public boolean isAssignCountryButtonWithTextDisplayed(String buttonText) {
        return isElementDisplayed(xpath(format(countryChecklistPO.getAssignCountryButtonWithText(), buttonText)));
    }

    public boolean isButtonWithIconDisplayed(String buttonText) {
        switch (buttonText) {
            case TO_LEFT:
                return isElementDisplayed(countryChecklistPO.getMoveToLeftAngelBtn());
            case TO_RIGHT:
                return isElementDisplayed(countryChecklistPO.getMoveToRightAngelBtn());
            default:
                throw new IllegalArgumentException("Incorrect button: " + buttonText);

        }
    }

    public boolean isSelectedCountriesContainerDisplayed() {
        return isElementDisplayed(countryChecklistPO.getSelectedCountriesContainer());
    }

    public boolean isCountryChecklistOptionDisplayed() {
        return isElementDisplayed(countryChecklistPO.getAdminCountryCheckList());
    }

    public boolean areEditButtonsDisplayedForEachRow() {
        return getElements(countryChecklistPO.getTableRow()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(countryChecklistPO.getEditButton())));
    }

    public boolean areDeleteButtonsDisplayedForEachRow() {
        return getElements(countryChecklistPO.getTableRow()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(countryChecklistPO.getDeleteButton())));
    }

    public boolean areAssignButtonsDisplayedForEachRow() {
        return getElements(countryChecklistPO.getTableRow()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(countryChecklistPO.getAssignButton())));
    }

    public boolean isRequiredIndicatorDisplayedForField(String fieldName) {
        return isElementDisplayed(waitMoment, xpath(format(countryChecklistPO.getRequiredIndicator(), fieldName)));
    }

    @Override
    public void load() {

    }

    public void navigateToCountryChecklistPage() {
        driver.get(URL + COUNTRY_CHECK_LIST);
    }

    public void clickCountryChecklistMenu() {
        clickOn(countryChecklistPO.getCountryChecklistMenu(), waitShort);
    }

    public void clickAddListNameBtn() {
        clickOn(countryChecklistPO.getAddCountryChecklistButton(), waitShort);
    }

    public void fillInName(String name) {
        isElementDisplayed(waitShort, countryChecklistPO.getListName());
        clearInputAndEnterField(countryChecklistPO.getListName(), name);
    }

    public void fillInAlertMsg(String msg) {
        clearText(countryChecklistPO.getAlertMsg());
        fillInText(countryChecklistPO.getAlertMsg(), msg, waitShort);
    }

    public void tickAlertType(String type) {
        clickOn(xpath(format(countryChecklistPO.getAlertTypeOption(), type)));
    }

    public void clickSaveAndAssignCountryBtn() {
        clickOn(countryChecklistPO.getSaveAndAssignCountryBtn());
    }

    public void chooseCountryInList(String country, String listName) {
        clickOn(xpath(format(countryChecklistPO.getCountryAssign(), listName, country)), waitShort);
    }

    public void moveCountryToList(String direction) {
        if (direction.equals(TO_RIGHT)) {
            clickOn(countryChecklistPO.getMoveToRightAngelBtn());
        } else {
            clickOn(countryChecklistPO.getMoveToLeftAngelBtn());
        }
    }

    public void clickSaveButton() {
        clickOn(countryChecklistPO.getSaveChecklistButton());
    }

    public void clickEditSaveButton() {
        clickOn(countryChecklistPO.getEditSaveChecklistButton());
    }

    public void clickCancelButton() {
        clickOn(countryChecklistPO.getCancelChecklistButton());
    }

    public void clickCancelAssignCountryButton() {
        clickOn(countryChecklistPO.getCancelAssignCountryButton());
    }

    public void clickEditButton(String checklistName) {
        clickOn(xpath(format(countryChecklistPO.getEditRowButton(), checklistName)), waitMoment);
    }

    public void clickDeleteButton(String checklistName) {
        clickOn(xpath(format(countryChecklistPO.getDeleteRowButton(), checklistName)));
    }

    public void clickAssignButton(String checklistName) {
        clickOn(xpath(format(countryChecklistPO.getAssignRowButton(), checklistName)), waitMoment);
    }

    public CountryChecklistData getAllFieldsValues(String checklistName) {
        return CountryChecklistData.builder()
                .listName(getCountryChecklistFieldValueByName(checklistName, NAME))
                .alertType(getCountryChecklistFieldValueByName(checklistName, ALERT))
                .status(getCountryChecklistFieldValueByName(checklistName, STATUS))
                .dateCreated(getCountryChecklistFieldValueByName(checklistName, DATE_CREATED))
                .lastUpdate(getCountryChecklistFieldValueByName(checklistName, LAST_UPDATE))
                .build();
    }

    public List<String> getAlertTypeOptions() {
        return getElementsText(driver.findElements(countryChecklistPO.getAlertTypeOptions()));
    }

    public List<String> getAvailableCountriesOptions() {
        return getElementsText(countryChecklistPO.getAvailableCountriesOptions());
    }

    public List<String> getSelectedCountriesOptions() {
        return getElementsText(countryChecklistPO.getAvailableCountriesOptions());
    }

    private String getCountryChecklistFieldValueByName(String checklistName, String fieldName) {
        try {
            WebElement element = waitMoment.until(visibilityOfElementLocated(
                    xpath(format(countryChecklistPO.getFieldValue(), checklistName,
                                 countryChecklistColumns.get(fieldName)))));
            return getElementText(element);
        } catch (TimeoutException ex) {
            return null;
        }
    }

    public boolean isCountryCheckListDisplayed(String checklistName) {
        return nonNull(getCountryChecklistFieldValueByName(checklistName, NAME));
    }

    public String getAlertTypeFontColor(String option) {
        return driver.findElement(xpath(format(countryChecklistPO.getAlertTypeOption(), option)))
                .getCssValue(BACKGROUND_COLOR);
    }

    public boolean isCountryChecklistImageCorrect(String filePath, String iconName) {
        driver.manage().window().setPosition(new Point(0, 0));
        driver.manage().window().setSize(dimensionWithPixelRatio_1_25);
        WebElement logoImageElement = getElement(xpath(format(countryChecklistPO.getAlertTypeIcon(), iconName)));
        return ImageUtil.isImageCorrect(filePath, iconName, logoImageElement);
    }

    public String getTextFieldValue(String fieldName) {
        return getAttributeValueWhenAppears(waitShort,
                                            xpath(format(countryChecklistPO.getFieldInputValue(), fieldName)));
    }

    public String getRequiredIndicatorColor(String fieldName) {
        return getElementByXPath(format(countryChecklistPO.getRequiredIndicator(), fieldName))
                .getCssValue(COLOR);
    }

    public boolean isFieldBorderRed(String fieldName) {
        return isElementContainsCssValue(xpath(format(countryChecklistPO.getFieldInputValue(), fieldName)),
                                         BORDER_COLOR,
                                         Colors.RED_BORDER.getColorRgba());
    }

    public String getFieldMessage(String fieldName) {
        return getElementText(xpath(format(countryChecklistPO.getFieldInputMessage(), fieldName)));
    }

    public boolean isFieldMessageRed(String fieldName) {
        return isElementContainsCssValue(xpath(format(countryChecklistPO.getFieldInputMessage(), fieldName)),
                                         COLOR,
                                         Colors.REACT_RED.getColorRgba());
    }

    public void clickOnCountryChecklist(String checklistName) {
        clickOn(xpath(format(countryChecklistPO.getCountryChecklistRow(), checklistName)));
    }

    public void clickViewEditButton() {
        clickOn(countryChecklistPO.getViewEditButton());
    }

    public void clearField(String fieldName) {
        clearText(xpath(format(countryChecklistPO.getFieldInputValue(), fieldName)));
    }

    public void tickActiveCheckBox() {
        tickFieldCheckbox(countryChecklistPO.getActiveCheckbox());
    }

    public List<String> getTableHeaders() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementsNonBlankTexts(getElements(waitShort, countryChecklistPO.getTableHeaders()));
    }

    public boolean isAddListNameButtonDisplayed() {
        return isElementDisplayed(waitShort, countryChecklistPO.getAddCountryChecklistButton());
    }

    public void clickOnColumn(String column) {
        clickOn(xpath(format(countryChecklistPO.getColumnName(), column)));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public List<String> getListValuesForColumn(String columnName) {
        waitForAngularPageIsLoaded();
        int columnIndex = getColumnTableIndex(columnName);
        return driver.findElements(countryChecklistPO.getTableRow()).stream()
                .map(row -> getElementText(getElement(waitMoment, () ->
                        row.findElement(xpath(format(countryChecklistPO.getTableRowValue(), columnIndex))))))
                .collect(Collectors.toList());
    }

    private int getColumnTableIndex(String columnName) {
        return getTableHeaders().indexOf(columnName) + 1;
    }

    public void searchCountryChecklist(String countryChecklist) {
        SearchSectionPage searchPage = new SearchSectionPage(driver);
        searchPage.searchItem(countryChecklist);
    }

    public String getTableMessage() {
        return getElementText(countryChecklistPO.getTableMessage());
    }

    public int getNumberOfCountryChecklistsInTable() {
        return getElements(countryChecklistPO.getTableRow()).size();
    }

}
