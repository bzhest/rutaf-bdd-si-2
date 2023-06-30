package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.worldCheck.PepResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.*;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.enums.ContactScreeningTableColumns;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.PaginationReactPO;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ScreeningSectionPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.MediaCheckProfileData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import io.restassured.response.Response;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static org.apache.commons.lang3.StringUtils.EMPTY;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.getResponseJsonPathAsObject;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.EntityType.SUPPLIER;
import static com.refinitiv.asts.test.ui.enums.ScreeningCriteriaFields.SEARCH_TERM;
import static java.lang.String.format;
import static java.util.UUID.randomUUID;
import static org.apache.commons.text.WordUtils.capitalizeFully;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ScreeningSectionPage extends BasePage<ScreeningSectionPage> {

    public static final String NAME = "Name";
    public static final String ARTICLE_ID = "Article ID";
    public static final String COUNTRY_OF_REGISTRATION = "Country of Registration";
    public static final String LAST_SCREENING_DATE = "Last Screening Date";
    public static final String DATA_PROVIDER = "Data Provider";
    public static final String CREATED_BY = "Created By";
    public static final String LAST_UPDATED_BY = "Last Updated By";
    private final ScreeningSectionPO screeningPO;
    private final PaginationReactPO paginationReactPO;
    private final String newLineSeparator = "\\n";

    public ScreeningSectionPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        screeningPO = new ScreeningSectionPO(driver, translator);
        paginationReactPO = new PaginationReactPO();
    }

    @Override
    protected ExpectedCondition<ScreeningSectionPage> getPageLoadCondition() {
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
        this.driver.get(URL);
    }

    public void clickRefreshScreeningTableButton() {
        if (isElementDisplayedNow(screeningPO.getBtnRefresh())) {
            clickOn(screeningPO.getBtnRefresh());
        }
    }

    public void enterScreeningCommentAndSave(String comment) {
        fillInResolutionComment(comment);
        clickOnModalButton(SAVE);
    }

    public void updateSearchCriteria(String searchField, String value) {
        if (searchField.equals(SEARCH_TERM.getName())) {
            clickSearchInput(searchField);
            clearAndFillInSearchInput(searchField, value);
            clickCollapseButton(searchField);
        } else {
            clearAndFillInValueAndSelectFromDropDown(value,
                                                     xpath(format(screeningPO.getSearchCriteriaInput(), searchField)),
                                                     screeningPO.getDropDownOption());
        }
    }

    private void clearAndFillInSearchInput(String searchField, String value) {
        clearAndInputField(xpath(format(screeningPO.getSearchCriteriaInput(), searchField)), value);
        waitForFieldAttributeValueUpdate(screeningPO.getSearchCriteriaInput(), value, searchField);
    }

    private void clickSearchInput(String searchField) {
        clickOn(xpath(format(screeningPO.getSearchCriteriaInput(), searchField)));
    }

    public void clickOnButtonWithName(String buttonName) {
        clickOn(xpath(format(screeningPO.getButtonWithName(), buttonName)), waitMoment);
    }

    public void clickEnableScreeningOrSearchCriteria(String buttonName) {
        if (isButtonWithNameDisplayed(ENABLE_SCREENING_BUTTON)) {
            clickOnButtonWithName(ENABLE_SCREENING_BUTTON);
        } else {
            clickOnButtonWithName(buttonName);
        }
    }

    public void clickOnCommentModalButtonWithName(String buttonName) {
        clickOn(xpath(format(screeningPO.getCommentModalButtonWithName(), buttonName)), waitShort);
    }

    public void clickOnModalButton(String buttonName) {
        clickOn(xpath(format(screeningPO.getModalButtonWithName(), buttonName)), waitMoment);
    }

    public void turnOnTagAsRedFlag() {
        clickOn(screeningPO.getTagAsRedFlag());
    }

    public void clickOnScreeningElement(String referenceId) {
        clickOn(xpath(format(screeningPO.getScreeningRecordByContent(), referenceId)));
    }

    public void clickOnScreeningElement(int position) {
        clickOn(getElementByXPath(format(screeningPO.getScreeningRecordByPosition(), position)));
    }

    public void selectRiskLevel(String riskLevel) {
        clearAndFillInValueAndSelectFromDropDown(riskLevel, screeningPO.getRiskLevelInput(),
                                                 screeningPO.getDropDownOption());
    }

    public void selectFirstRiskLevel() {
        clickOn(screeningPO.getRiskLevelInputOpenClose(), waitMoment);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((screeningPO.getDropDownOptions()))).get(0));
    }

    public void selectReason(String reason) {
        clearAndFillInValueAndSelectFromDropDown(reason, screeningPO.getReasonInput(), screeningPO.getDropDownOption());
    }

    public void selectFirstReason() {
        clickOn(screeningPO.getReasonInputOpenClose(), waitMoment);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((screeningPO.getDropDownOptions()))).get(0));
    }

    public boolean isButtonWithNameDisplayed(String buttonName) {
        return isElementDisplayed(waitMoment, xpath(format(screeningPO.getButtonWithName(), buttonName)));
    }

    public boolean isModalButtonDisplayed(String buttonName) {
        return isElementDisplayed(waitShort, xpath(format(screeningPO.getModalButtonWithName(), buttonName)));
    }

    public boolean isCancelButtonDisplayed() {
        return isElementDisplayed(waitMoment, screeningPO.getCancelResolutionButton());
    }

    public boolean isDropDownOptionWithTextDisabled(String value) {
        WebElement inputField = driver.findElement(xpath(format(screeningPO.getDropDownOption(), value)));
        return inputField.getAttribute(ARIA_DISABLED).equals(Boolean.toString(true));
    }

    public boolean isScreeningRecordWithIdDisplayed(String referenceId) {
        return isElementDisplayed(waitShort, xpath(format(screeningPO.getScreeningRecordByContent(), referenceId)));
    }

    public boolean isScreeningTableLoaded() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return isElementDisappeared(waitShort, screeningPO.getPreloader()) &&
                (isElementDisplayed(xpath(screeningPO.getScreeningTable())) ||
                        isElementDisplayed(screeningPO.getEmptyTable()));
    }

    public boolean isMatchedIndicatorDisplayedForRecordWithId(String referenceId) {
        return isElementDisplayed(xpath(format(screeningPO.getScreeningMatchedIconByRecordId(), referenceId)));
    }

    public boolean isMatchedIndicatorDisplayedForRecordWithIndex(int index) {
        return isElementDisplayed(xpath(format(screeningPO.getScreeningMatchedIconByIndex(), index)));
    }

    public boolean isRefreshScreeningTableButtonDisplayed() {
        try {
            waitMoment.until(ExpectedConditions.elementToBeClickable(screeningPO.getBtnRefresh()));
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public boolean isAddCommentDialogDisappeared() {
        return isElementDisappeared(waitMoment, xpath(screeningPO.getCommentModalContent()));
    }

    public boolean isAddCommentDialogDisplayed() {
        return isElementDisplayed(waitShort, xpath(screeningPO.getCommentModalContent()));
    }

    public boolean isNotifyButtonDisplayed() {
        return isElementDisplayed(screeningPO.getBellIcon());
    }

    public boolean isRecipientDisplayed(String recipient) {
        return isElementDisplayed(xpath(format(screeningPO.getRecipientWithName(), recipient)));
    }

    public boolean isAddRecipientModalDisappeared() {
        return isElementDisappeared(waitShort, screeningPO.getAddRecipientModal());
    }

    public boolean isOgsSliderDisplayed() {
        return isElementDisplayed(waitShort, screeningPO.getOgsSwitchButtonSpan());
    }

    public boolean isRedFlagTurnOn() {
        return driver.findElement(screeningPO.getTagAsRedFlag()).getAttribute(CLASS).contains(CHECKED);
    }

    public boolean isScreeningSectionCollapsed() {
        return isElementDisplayed(screeningPO.getCollapsedScreening());
    }

    public void editSearchCriteria(String searchTerm) {
        clearAndFillInSearchInput(SEARCH_TERM.getName(), searchTerm);
        clickOnModalButton(SEARCH.toUpperCase());
    }

    public void clearSearchCriteria(String elementName) {
        clickSearchInput(elementName);
        clickOn(xpath(format(screeningPO.getSearchCriteriaInputClearButton(), elementName)));
        clickCollapseButton(elementName);
    }

    private void clickCollapseButton(String elementName) {
        By collapseButtonLocator = xpath(format(screeningPO.getCollapseButton(), elementName));
        if (isElementDisplayed(collapseButtonLocator)) {
            clickOn(collapseButtonLocator);
        }
    }

    public int getSelectedResolutionIndexById(String referenceId) {
        List<WebElement> rowElements =
                driver.findElements(xpath(format(screeningPO.getScreeningResolutionButtonsList(), referenceId)));
        int selectedElementIndex = 3;
        for (int i = 0; i < rowElements.size(); i++) {
            if (rowElements.get(i).getAttribute(CLASS).contains(COLOR_PRIMARY)) {
                selectedElementIndex = i;
            }
        }
        return selectedElementIndex;
    }

    public int getSelectedResolutionIndexByIndex(int index) {
        int resolutionButtonsCount = 3;
        int selectedElementIndex = 3;
        List<WebElement> resolutionButtons = waitShort.until(visibilityOfAllElementsLocatedBy(
                xpath(format(screeningPO.getScreeningResolutionButtonsByIndex(), index))));
        for (int i = 0; i < resolutionButtonsCount; i++) {
            if (resolutionButtons.get(i).getAttribute(CLASS).contains(COLOR_PRIMARY)) {
                selectedElementIndex = i;
            }
        }
        return selectedElementIndex;
    }

    public List<String> openAndGetSearchCriteriaDropDownListValues(String countryType) {
        clickSearchCriteriaOpenDropDown(countryType, OPEN);
        try {
            return getElementsText(screeningPO.getDropDownOptions());
        } catch (StaleElementReferenceException e) {
            clickSearchCriteriaOpenDropDown(countryType, OPEN);
            return getElementsText(screeningPO.getDropDownOptions());
        }
    }

    public void clickResolveScreeningElementById(String referenceId, int priority) {
        scrollToScreeningTable();
        clickOn(getElements(xpath(format(screeningPO.getScreeningResolutionButtonsList(), referenceId)))
                        .get(priority));
    }

    public void clickSearchCriteriaOpenDropDown(String countryType, String action) {
        clickOn(xpath(format(screeningPO.getSearchCriteriaDropDownButton(), countryType, action)));
    }

    public void clickSelectScreeningElementById(String referenceId) {
        clickOn(xpath(format(screeningPO.getScreeningSelectRecordByRecordId(), referenceId)));
    }

    public void clickOnResolution(String resolutionType) {
        clickOn(xpath(format(screeningPO.getScreeningResolution(), capitalizeFully(resolutionType))));
    }

    public void fillInResolutionComment(String text) {
        clickOn(screeningPO.getResolutionComment());
        getElement(screeningPO.getResolutionComment()).sendKeys(text);
    }

    public void selectAllScreeningResults() {
        clickOn(getElement(screeningPO.getSelectAllScreeningResults()), waitShort);
    }

    public void scrollToScreeningTable() {
        scrollIntoView(waitLong.until(visibilityOfElementLocated(xpath(screeningPO.getScreeningSection()))));
    }

    public void clickOnOgs() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(screeningPO.getOgsSwitchButton());
    }

    public void addRecipient(String recipient) {
        clickBellIcon();
        waitWhilePreloadProgressbarIsDisappeared();
        getElement(screeningPO.getAddRecipientInput()).sendKeys(recipient);
        enterViaKeyboard(Keys.ARROW_DOWN);
        enterViaKeyboard(Keys.ENTER);
        clickSaveNotifyButton();
    }

    public void clickBellIcon() {
        clickOn(screeningPO.getBellIcon());
    }

    public void cancelAddingRecipient() {
        clickOn(screeningPO.getAddRecipientCancelButton());
    }

    public void clickSaveNotifyButton() {
        clickOn(screeningPO.getAddRecipientSaveButton());
    }

    public void collapseScreeningSection() {
        if (isElementDisplayed(screeningPO.getScreeningSectionHidden())) {
            clickOn(screeningPO.getScreeningSectionHeader());
        }
    }

    public String getSearchCriteriaValue(String searchField) {
        return getAttributeValue(xpath(format(screeningPO.getSearchCriteriaInput(), searchField)), VALUE);
    }

    public List<ResultsResponseDTO> getScreeningResultsData(String pageType) {
        waitWhilePreloadProgressbarIsDisappeared();
        List<String> columnNames = getScreeningTableColumnNames();
        return getScreeningResultsList().stream()
                .map(result -> new ResultsResponseDTO()
                        .setPrimaryName(
                                getAttributeOrText(result, xpath(screeningPO.getTableRowNameValue()), TITLE_ATR))
                        .setDisplayName(getValue(result, translator.getValue(
                                "thirdPartyInformation.screening.columnName").toUpperCase(), columnNames))
                        .setCountryLinksString(getValue(result, pageType.contains(SUPPLIER.toString().toLowerCase()) ?
                                translator.getValue("thirdPartyInformation.screening.columnCountryOfRegistration")
                                        .toUpperCase() :
                                ContactScreeningTableColumns.COUNTRY_OF_LOCATION.getColumnName(), columnNames))
                        .setCategory(getValue(result, translator.getValue("thirdPartyInformation.screening.columnType")
                                                      .toUpperCase(),
                                              columnNames))
                        .setMatchStrength(getValue(result, translator.getValue(
                                "thirdPartyInformation.screening.columnMatchStrength").toUpperCase(), columnNames))
                        .setProviderTypeString(getValue(result, translator.getValue(
                                "thirdPartyInformation.screening.columnDataProvider").toUpperCase(), columnNames))
                        .setReferenceId(getValue(result, translator.getValue(
                                "thirdPartyInformation.screening.columnReferenceId").toUpperCase(), columnNames))
                        .setResolutionPosition(getResolutionPosition(result))

                ).collect(Collectors.toList());
    }

    public List<String> getSortedCategories(List<ResultsResponseDTO> searchResults) {
        List<String> categories =
                searchResults.stream().map(ResultsResponseDTO::getCategory).collect(Collectors.toList());

        return categories.stream().map(category -> {
            String[] types = category.split(newLineSeparator);
            Arrays.sort(types);
            return String.join(newLineSeparator, types);
        }).collect(Collectors.toList());
    }

    private String getValue(WebElement row, String columnName, List<String> columnNames) {
        int columnNameIndex = columnNames.indexOf(columnName) + 2;
        return columnNameIndex == 1 ? null :
                getElementText(
                        row.findElement(xpath(format(screeningPO.getTableRowValue(), columnNameIndex))));
    }

    private int getResolutionPosition(WebElement result) {
        List<WebElement> resolutionElements = result.findElements(xpath(screeningPO.getRowResolutionList()));
        return IntStream.range(0, resolutionElements.size())
                .filter(i -> resolutionElements.get(i).getAttribute(CLASS).contains(COLOR_PRIMARY)).findFirst()
                .orElse(3);
    }

    public List<WebElement> getScreeningResultsList() {
        scrollToScreeningTable();
        return getElements(screeningPO.getScreeningTableResultList());
    }

    public String getLasScreeningDateText() {
        return getElementText(screeningPO.getLastScreeningDate());
    }

    public List<String> getScreeningTableColumnNames() {
        return getElementsText(screeningPO.getScreeningTableHeaderList());
    }

    public String getCommentModalContentText() {
        return getElementText(xpath(screeningPO.getCommentModalContent()));
    }

    public String getResolutionOptionsText() {
        return getElementText(waitShort.until(visibilityOfElementLocated(screeningPO.getResolutionOptions())));
    }

    public String getScreeningRecordName(int recordNo) {
        return getAttributeOrText(xpath(format(screeningPO.getScreeningRecordName(), recordNo)), TITLE_ATR);
    }

    public String getScreeningRecordId(int recordNo) {
        return getElementText(xpath(format(screeningPO.getScreeningRecordId(), recordNo)));
    }

    public String getCommentCounter() {
        return getElementText(screeningPO.getCommentCounter());
    }

    public void clickWorldCheck() {
        clickOn(getElement(screeningPO.getButtonWorldCheck()));
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public boolean worldCheckIsSelected() {
        return getAttributeValue(screeningPO.getButtonWorldCheck(), CLASS).contains(MUI_SELECTED);
    }

    public String getOGSLabel(String labelName) {
        return getElementText(xpath(format(screeningPO.getLabelWithName(), labelName)));
    }

    public void clickCustomWatchlist() {
        clickOn(getElement(screeningPO.getButtonCustomWatchlist()), waitShort);
    }

    public void clickMediaCheck() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(getElement(screeningPO.getButtonMediaCheck()));
    }

    public boolean checkOGSToggleShouldBeInvisible(String label) {
        return isElementInvisible(waitLong, format(screeningPO.getLabelWithName(), label));
    }

    public void clickOnScreeningTab(String tabName) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickOn(xpath(format(screeningPO.getDisplayTabs(), tabName)), waitShort);
    }

    public boolean isNoAvailableDataDisplayed(String tabName) {
        waitWhilePreloadProgressbarIsDisappeared();
        WebElement element = getElementByXPath(format(screeningPO.getNoAvailableDataTabs(), tabName));
        return Objects.nonNull(element) && element.isDisplayed();
    }

    public void clickFilterIcon() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(getElement(screeningPO.getFilterIconButton()));
    }

    public void clickSmartFilterToggleButton() {
        waitShort.until(visibilityOfElementLocated(screeningPO.getSmartFilterSideTab()));
        clickOn(getElement(screeningPO.getSmartFilterToggleButton()));
    }

    public boolean isSmartFilterButtonTurnOn() {
        return getAttributeValueWithWait(waitShort, screeningPO.getSmartFilterToggleButton(), CLASS).contains(
                MUI_DISABLED);
    }

    public boolean isMediaCheckTabDisabled() {
        return driver.findElement(screeningPO.getButtonMediaCheck()).getAttribute(CLASS).contains(MUI_DISABLED);
    }

    public boolean isMediaCheckTableNoMatchFoundMessageDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(screeningPO.getMediaCheckTableNoMatchFound());
    }

    public boolean isNoMatchFoundMessageDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(screeningPO.getNoMatchFoundMessage());
    }

    public String getMediaCheckSearchTermInScreeningResultTable() {
        return getElementText(screeningPO.getMediaCheckSearchTermInScreeningResultTable());
    }

    public void clickRowsPerPageDropDown() {
        clickOn(screeningPO.getMediaCheckRowPerPageDropdown(), waitLong);
    }

    public List<String> getRowsPerPageDropDownOptions() {
        return getDropDownOptions(screeningPO.getDropDownOptions());
    }

    public String getMediaCheckRowsPerPageValue() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(screeningPO.getMediaCheckRowPerPageDropdown());
    }

    public int getTotalRecordsFromMediaCheckResultTable() {
        waitWhilePreloadProgressbarIsDisappeared();
        return driver.findElements(screeningPO.getMediaCheckResultTableRecords()).size();
    }

    public String getRowsPerPageLabel() {
        return getElementText(screeningPO.getRowsPerPageLabel());
    }

    public void clickItemsRowsPerPageOption(String paginationOption) {
        clickOn(cssSelector(format(paginationReactPO.getItemsPerPageDropdownOption(), paginationOption)));
    }

    public boolean checkNotifyButtonDoesNotDisplay() {
        return isElementInvisible(waitLong, screeningPO.getBellIcon());
    }

    public boolean isOgsSliderTurned() {
        return getAttributeValue(screeningPO.getOgsSwitchButtonSpan(), CLASS).contains(CHECKED);
    }

    public boolean isCheckTypeInChangeSearchCriteriaChecked(String checkTypeName) {
        By checkTypeLocator =
                By.xpath(format(screeningPO.getCheckType(), checkTypeName));
        return waitLong.until(presenceOfElementLocated(checkTypeLocator)).isSelected();
    }

    public void clickCheckTypeCheckbox(String checkTypeName) {
        clickOn(xpath(format(screeningPO.getCheckType(), checkTypeName)));
    }

    public boolean isMarkAllAsReviewedButtonDisplay() {
        return isElementDisplayed(screeningPO.getMarkAllAsReviewedButton());
    }

    public boolean isMediaResolutionDisplay() {
        return isElementDisplayed(screeningPO.getMediaResolution());
    }

    public void clickOnMediaCheckRecord(int record) {
        clickOn(xpath(format(screeningPO.getMediaCheckScreeningRecord(), record)));
    }

    public boolean isMediaResolutionScreeningResultDisplay() {
        return isElementDisplayed(screeningPO.getMediaResolutionScreeningResult());
    }

    public boolean isScreeningSectionDisplay() {
        return isElementDisplayed(xpath(screeningPO.getScreeningSection()));
    }

    public void fillInSearchTermRandomValue() {
        clearAndInputField(screeningPO.getSearchTerm(), AUTO_TEST_NAME_PREFIX + randomUUID());
    }

    public void fillInSearchTermWithValue(String searchTermValue) {
        clearAndInputField(screeningPO.getSearchTerm(), searchTermValue);
    }

    public boolean isSearchItemDisplayed() {
        return isElementDisplayed(screeningPO.getSearchTerm());
    }

    public void removeAddRecipientDropdownValue(String recipientName) {
        clickOn(xpath(format(screeningPO.getAddRecipientRemoveButtonInName(), recipientName)));
    }

    public boolean isAddRecipientAddButtonDisabled() {
        return getAttributeValue(screeningPO.getAddRecipientAddButton(), CLASS).contains(MUI_DISABLED);
    }

    public boolean isSameAsAddressCountryFieldDisplayed() {
        return isElementDisplayed(screeningPO.getSameAsAddressCountryField());
    }

    public boolean isSameAsAddressCountryCheckboxChecked() {
        return isCheckboxChecked(screeningPO.getSameAsAddressCheckbox());
    }

    public boolean isOngoingScreeningWorldCheckCheckboxChecked() {
        return isCheckboxChecked(screeningPO.getOngoingScreeningWorldCheckCheckbox());
    }

    public boolean isNotificationRecipientsUserCheckboxChecked() {
        return isCheckboxChecked(screeningPO.getRecipientsRadioUserButton());
    }

    public String getNotificationRecipient() {
        return getAttributeValue(screeningPO.getNotificationRecipients(), VALUE);
    }

    public void clickOpenCloseDropDownButton(String state) {
        clickOn(xpath(format(screeningPO.getAddRecipientOpenCloseDropDownButton(), state)));
    }

    public List<String> getRecipientDropDownList() {
        return getDropDownOptions(screeningPO.getDropDownOptions());
    }

    public boolean isOGSAlertMessageDisplayed(String alertMessage) {
        return isElementInvisible(waitLong, format(screeningPO.getOgsAlertMessage(), alertMessage));
    }

    public boolean isOGSToggleHidden() {
        return isElementInvisible(waitShort, screeningPO.getOgsSwitchButton());
    }

    public boolean isBellIconHidden() {
        return isElementInvisible(waitShort, screeningPO.getBellIcon());
    }

    public boolean isOGSToggleDisable() {
        return isElementDisplayed(waitShort, screeningPO.getOgsButtonDisable());
    }

    public void hoversOverWCScreeningType(String name, String type) {
        hoverOverElement(xpath(format(screeningPO.getWcScreeningTypeTooltip(), name, type)));
    }

    public void scrollIntoViewWCRecord(String name, String type) {
        scrollIntoView(xpath(format(screeningPO.getWcScreeningTypeTooltip(), name, type)));
    }

    public void hoversOverMatchStrength() {
        hoverOverElement(screeningPO.getMatchStrengthButton());
    }

    public boolean isStrengthPatternMatched(String keyTooltip) {
        String matchStrengthPattern = "^(Strength:) [a-zA-Z]* (-) \\d*(%)$";
        Pattern pattern = Pattern.compile(matchStrengthPattern);
        Matcher matchStrengthPatternMatchResult = pattern.matcher(keyTooltip);
        return matchStrengthPatternMatchResult.find();
    }

    public String getMatchStrengthText() {
        return getElementText(screeningPO.getMatchStrengthTooltip());
    }

    public String getResolutionTypeText() {
        return getElementText(screeningPO.getResolutionTypeText());
    }

    public void hoversOverResolutionType(int resolutionTypePosition) {
        hoverOverElement(xpath(format(screeningPO.getResolutionTypeButton(), resolutionTypePosition)));
    }

    public boolean isResolutionTypePatternMatched(String resolutionTypeTooltip) {
        String resolutionTooltipPattern = "^(Modified by:)(.+) (.+) \\.\\.\\.$";
        Pattern pattern = Pattern.compile(resolutionTooltipPattern);
        Matcher resolutionPatternMatchResult = pattern.matcher(resolutionTypeTooltip);
        return resolutionPatternMatchResult.find();
    }

    public boolean isTooltipWCTypeDisplayed(String tooltip) {
        return isElementDisplayed(xpath(format(screeningPO.getTooltipOfWCType(), tooltip)));
    }

    public void clickTypeOfLinkedRecord(String recordName, String typeName) {
        clickOn(xpath(format(screeningPO.getTypeOfLinkedRecord(), recordName, typeName)));
    }

    public void scrollIntoViewWCProfileRecord(String recordName, String typeName) {
        scrollIntoView(xpath(format(screeningPO.getTypeOfLinkedRecord(), recordName, typeName)));
    }

    public boolean isTooltipDisplayed(String tooltip) {
        return isElementDisplayed(xpath(format(screeningPO.getTooltipOflinkedRecord(), tooltip)));
    }

    public boolean isMatchStrengthDisplayed() {
        return isElementDisplayed(screeningPO.getMatchStrengthTooltip());
    }

    public boolean isResolutionToolTipDisplayed(String resolutionName) {
        return isElementDisplayed(xpath(format(screeningPO.getTooltipResolutionType(), resolutionName)));
    }

    public boolean isResolutionPopupDropDownFieldMandatory(String fieldName) {
        return isElementDisplayed(xpath(format(screeningPO.getResolutionPopupDropdownMandatoryField(), fieldName)));
    }

    public String getResolutionPopupErrorRequiredMessageText(String fieldName) {
        return getElementText(xpath(format(screeningPO.getResolutionPopupRequiredErrorMessage(), fieldName)));
    }

    public String getResolutionPopupDropdownValue(String fieldName) {
        return getAttributeValueWithWait(waitShort,
                                         (xpath(format(screeningPO.getResolutionPopupDropdownFieldValue(), fieldName))),
                                         VALUE);
    }

    public void clickResolutionOnScreeningDetail(String resolutionType) {
        clickOn(xpath(format(screeningPO.getScreeningDetailResolution(), resolutionType)));
    }

    public void clickResolutionButton(int resolutionButton) {
        clickOn(xpath(format(screeningPO.getResolutionTypeButton(), resolutionButton)));
    }

    public boolean isItemsSelectedDisplayed(int items) {
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckItemsSelected(), items)));
    }

    public void clickSelectMediaCheckScreeningRecord(int recordReference) {
        clickOn(xpath(format(screeningPO.getMediaCheckScreeningSelectRecord(), recordReference)));
    }

    public void clickOnItemsSelectedLink(int items) {
        clickOn(xpath(format(screeningPO.getMediaCheckItemsSelected(), items)));
    }

    public boolean isItemsSelectedDisplayed(String name) {
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckLinkName(), name)));
    }

    public boolean isMediaCheckScreeningRecordChecked(int recordReference) {
        return isElementDisplayed(xpath(format(screeningPO.getMediacheckScreeningRecordChecked(), recordReference)));
    }

    public void clickOnSelectAllCheckBoxMediaCheck() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(screeningPO.getMediaCheckSelectAll());
    }

    public void clickOnMediaCheckRiskLevel(String riskLevel) {
        clickOn(xpath(format(screeningPO.getMediaCheckRiskLevel(), riskLevel)), waitShort);
    }

    public boolean isMediaCheckRiskLevelDisplayed(String riskLevel) {
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckRiskLevel(), riskLevel)));
    }

    public boolean isMediaCheckRiskLevelLabelDisplayed() {
        return isElementDisplayed(screeningPO.getMediaResolutionRiskLevelLabel());
    }

    public boolean isMediaCheckCommentLabelDisplayed() {
        return isElementDisplayed(screeningPO.getMediaResolutionCommentLabel());
    }

    public void clickOnMediaCheckProfileRiskLevel(String riskLevel) {
        clickOn(xpath(format(screeningPO.getMediaCheckProfileRiskLevel(), riskLevel)));
    }

    public void clickOnAttachButton() {
        clickOn(screeningPO.getMediaCheckAttach(), waitShort);
    }

    public void clickOnAttachButtonMediaCheckProfile() {
        clickOn(screeningPO.getMediaCheckProfileAttach());
    }

    public boolean isMediaCheckAttachDisplayed() {
        return isElementDisplayed(waitLong, screeningPO.getMediaCheckAttachModal());
    }

    public void clickOnAttachModalButtonWithName(String buttonName) {
        clickOn(xpath(format(screeningPO.getMediaCheckAttachModalButtonWithName(), buttonName)));
    }

    public String getFilterRiskLevel(String riskLevel) {
        String string = getElementText(xpath(format(screeningPO.getMediaCheckFilterRiskLevel(), riskLevel)));
        String recordNumber;
        switch (riskLevel) {
            case HIGH:
                recordNumber = string.substring(6).replaceAll(CLOSED_PARENTHESIS_REGEX, StringUtils.EMPTY);
                return recordNumber;
            case MEDIUM:
                recordNumber = string.substring(8).replaceAll(CLOSED_PARENTHESIS_REGEX, StringUtils.EMPTY);
                return recordNumber;
            case LOW:
                recordNumber = string.substring(5).replaceAll(CLOSED_PARENTHESIS_REGEX, StringUtils.EMPTY);
                return recordNumber;
            case NO_RISK:
            case UNKNOWN:
                recordNumber = string.substring(9).replaceAll(CLOSED_PARENTHESIS_REGEX, StringUtils.EMPTY);
                return recordNumber;
            default:
                throw new IllegalArgumentException("Risk Level: " + riskLevel + " is unexpected");
        }
    }

    public void clickOnFilterRiskLevel(String riskLevel, String recordNumber) {
        String getRecordNumber = getFilterRiskLevel(riskLevel);
        if (getRecordNumber.equals(recordNumber)) {
            clickOn(xpath(format(screeningPO.getMediaCheckFilterRiskLevel(), riskLevel)), waitShort);
        }
    }

    public void clickOnNextPage() {
        clickOn(screeningPO.getNextPageButton());
    }

    public void clickOnLastPage() {
        clickOn(screeningPO.getMediaCheckLastPageButton());
    }

    public void clickOnFirstPage() {
        clickOn(screeningPO.getMediaCheckFirstPageButton());
    }

    public boolean isFilterRiskLevel(String riskLevel) {
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckFilterRiskLevelSelected(), riskLevel)));
    }

    public boolean isMediaCheckAttachButtonDisabled() {
        return getAttributeValue(screeningPO.getMediaCheckAttach(), CLASS)
                .contains(MUI_DISABLED);
    }

    public boolean isClearAllButtonDisplayed() {
        return isElementDisplayed(screeningPO.getClearAllButton());
    }

    public void clickOnClearAllButton() {
        clickOn(screeningPO.getClearAllButton());
    }

    public void clickOnPreviousPage() {
        clickOn(screeningPO.getPreviousPageButton());
    }

    public boolean isMediaCheckAttachModalDataDisplayed(String riskLevel, String comment) {
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckAttachModalRiskLevel(), riskLevel))) &&
                isElementDisplayed(xpath(format(screeningPO.getMediaCheckAttachModalComment(), comment)));
    }

    public boolean isMediaResolutionRedFlagTurnOn() {
        return getAttributeValue(screeningPO.getModalMediaResolutionTagAsRedFlag(), CLASS)
                .contains(MUI_CHECKED);
    }

    public boolean isProfileMediaResolutionRedFlagTurnOn() {
        return getAttributeValue(screeningPO.getProfileMediaResolutionTagAsRedFlag(), CLASS)
                .contains(MUI_CHECKED);
    }

    public boolean isRowsPerPageDisabled() {
        return getAttributeValue(screeningPO.getScreeningRowsPerPageDropdown(), CLASS).contains(MUI_DISABLED);
    }

    public boolean isClearAllButtonDisappeared() {
        return isElementDisappeared(waitShort, screeningPO.getClearAllButton());
    }

    public void clickOnBackToTheFullListLink() {
        clickOn(screeningPO.getBackToTheFullListLink());
    }

    public void clickMediaCheckTagAsRedFlagToggle() {
        clickOn(screeningPO.getMediaCheckRedFlagToggle());
    }

    public String getMediaCheckRecordName(int recordReference) {
        String webElementText =
                getElementText(waitShort,
                               xpath(format(screeningPO.getMediaCheckScreeningRecordRow(), recordReference)));
        return webElementText.substring(0, webElementText.indexOf(ROW_DELIMITER));
    }

    public void clearCommentMediaResolutionValue() {
        clearText(screeningPO.getResolutionComment());
    }

    public boolean isGroupsFieldDisabled() {
        return isElementAttributeContains(screeningPO.getSearchCriteriaGroups(), CLASS, MUI_DISABLED);
    }

    public boolean isMediaCheckRiskLevelOptionSelected(String riskLevelName) {

        return isElementContainsCssValue(waitShort, xpath(format(screeningPO.getMediaCheckRiskLevel(), riskLevelName)),
                                         COLOR, Colors.RISK_UNSELECTED.getColorRgba());
    }

    public boolean isMediaCheckRecordRiskLevelIconDisplayed(int recordReference, String riskLevelName) {
        String color;
        switch (riskLevelName) {
            case HIGH:
                color = Colors.RISK_ORANGE.getColorRgba();
                break;
            case MEDIUM:
                color = Colors.ORANGE.getColorRgba();
                break;
            case LOW:
                color = Colors.LIGHT_GREEN.getColorRgba();
                break;
            case NO_RISK:
                color = Colors.REACT_BLUE.getColorRgba();
                break;
            case UNKNOWN:
                color = Colors.RISK_GREY.getColorRgba();
                break;
            default:
                throw new IllegalArgumentException("unexpected icon risk level");
        }
        return isElementContainsCssValue(waitShort, xpath(format(screeningPO.getMediaCheckScreeningRecordRiskIcon(),
                                                                 recordReference)), BACKGROUND_COLOR, color);
    }

    public String getMediaCheckRecordRiskLevelIconName(int recordReference) {
        return getElementText(xpath(format(screeningPO.getMediaCheckScreeningRecordRiskIcon(), recordReference)));
    }

    public void scrollIntoViewMediaCheckRecord(int recordNumber) {
        scrollIntoView(xpath(format(screeningPO.getMediaCheckScreeningRecordRiskIcon(), recordNumber)));
    }

    public void hoversOverMediaCheckRiskLevelRecordIcon(int recordReference) {
        hoverOverElement(xpath(format(screeningPO.getMediaCheckScreeningRecordRiskIcon(), recordReference)));
    }

    public void scrollIntoViewMediaCheckToolTipRecord(String toolTipMessage) {
        scrollIntoView(xpath(format(screeningPO.getMediaCheckScreeningRecordRiskToolTip(), toolTipMessage)));
    }

    public boolean isMediaCheckRiskLevelToolTipDisplayed(String toolTipMessage) {
        scrollIntoViewMediaCheckToolTipRecord(toolTipMessage);
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckScreeningRecordRiskToolTip(), toolTipMessage)));
    }

    public String isGroupFieldDefaultValueDisplayed() {
        return getAttributeValue(screeningPO.getSearchCriteriaGroups(), VALUE);
    }

    public void selectGroup(int value) {
        clickOn(screeningPO.getSearchCriteriaGroups(), waitShort);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((screeningPO.getDropDownOptions()))).get(value));
    }

    public void hoverScreeningGroups() {
        hoverOverElement(screeningPO.getSearchCriteriaGroups());
    }

    public String getGroupTooltipText() {
        return getElementText(screeningPO.getSearchCriteriaGroupsTooltip());
    }

    public String isGroupValueDisplayed() {
        return getAttributeValue(screeningPO.getSearchCriteriaGroups(), VALUE);
    }

    public void editSearchTerm(String searchTerm) {
        clearAndFillInSearchInput(SEARCH_TERM.getName(), searchTerm);
    }

    public void selectCountryOfRegistration(String countryValue) {
        clearAndFillInValueAndSelectFromDropDown(countryValue, screeningPO.getCountryOfRegistrationInput());

    }

    public String getToastMessages() {
        return getElementText(screeningPO.getToastMessages());
    }

    public void selectCountryOfLocationDropdown(String countryOfLocation) {
        clearAndFillInValueAndSelectFromDropDown(countryOfLocation, screeningPO.getCountryOfLocationInput());
    }

    public void selectPlaceOfBirthDropdown(String placeOfBirth) {
        clearAndFillInValueAndSelectFromDropDown(placeOfBirth, screeningPO.getPlaceOfBirthInput());
    }

    public void selectCitizenshipDropdown(String citizenship) {
        clearAndFillInValueAndSelectFromDropDown(citizenship, screeningPO.getCitizenshipInput());
    }

    public boolean isSearchCriteriaModalDisappeared() {
        return isElementDisappeared(waitMoment, screeningPO.getSearchCriteriaModal());
    }

    public List<String> getDropDownList(String dropDownName) {
        clickOn(xpath(format(screeningPO.getResolutionDropDownInput(), dropDownName)));
        return getElementsText(driver.findElements(screeningPO.getDropDownOptions()));
    }

    public List<String> getMediaCheckAlertToastMessage() {
        return getElementsText(waitShort.ignoring(StaleElementReferenceException.class)
                                       .until(visibilityOfAllElementsLocatedBy(
                                               screeningPO.getAlertIconMessage())));
    }

    public boolean isMediaCheckAlertToastMessageDisplayed() {
        return isElementDisplayed(screeningPO.getAlertIconMessage());
    }

    public boolean isRikLevelButtonHighlighted(String button) {
        return getAttributeValue(xpath(format(screeningPO.getRiskLevelButton(), button)), CLASS)
                .contains(OUTLINED_PRIMARY);
    }

    public MediaCheckProfileData getMediaCheckProfileDetails() {
        return new MediaCheckProfileData()
                .setName(getElementText(screeningPO.getMediaCheckName()))
                .setArticleId(getElementText(By.xpath(format(screeningPO.getMediaCheckDetails(), 0))))
                .setCountryOfRegistration(getElementText(xpath(format(screeningPO.getMediaCheckDetails(), 1))))
                .setLastScreeningDate(getElementText(xpath(format(screeningPO.getMediaCheckDetails(), 2))))
                .setDataProvider(getElementText(xpath(format(screeningPO.getMediaCheckDetails(), 3))))
                .setCreatedBy(getElementText(xpath(format(screeningPO.getMediaCheckDetails(), 4))))
                .setLastUpdatedBy(getElementText(xpath(format(screeningPO.getMediaCheckDetails(), 5))));
    }

    public String getMediaCheckFilterArticleSubMenusText(String subMenu) {
        return getElementText(xpath(format(screeningPO.getMediaCheckFilterArticleSubMenuButton(), subMenu)));
    }

    public boolean isMediaCheckFilterArticleSubMenuDisplayed(String subMenu) {
        return isElementDisplayed(waitMoment, getElementByXPath(
                format(screeningPO.getMediaCheckFilterArticleSubMenuButton(), subMenu)));
    }

    public void clickOnMediaCheckFilterArticleSubMenuButton(String subMenu) {
        clickOn(xpath(format(screeningPO.getMediaCheckFilterArticleSubMenuButton(), subMenu)));
    }

    public String getMediaCheckArticleNumber() {
        return getElementText(screeningPO.getMediaCheckArticleNumber()).replaceAll(COMMA, StringUtils.EMPTY);
    }

    public boolean isMediaCheckFilterAccordionExpanded(String accordionMenuName) {
        return getAttributeValueWithWait(waitMoment,
                                         xpath(format(screeningPO.getMediaCheckFilterAccordion(), accordionMenuName)),
                                         CLASS).contains(MUI_EXPANDED);
    }

    public boolean isSmartFilterSectionDisplayed() {
        return isElementDisplayed(waitMoment, screeningPO.getMediaChecksmartFilterSection());

    }

    public String getRiskLevelToolTipIconMessage() {
        return getAttributeValueWithWait(waitMoment, screeningPO.getMediaCheckRiskLevelToolTipIcon(),
                                         TITLE_ATR);
    }

    public boolean isMediaCheckFilterRiskLevelSubMenuButtonHighlighted(String riskLevel) {
        return getAttributeValueWithWait(waitMoment,
                                         xpath(format(screeningPO.getMediaCheckFilterRiskLevelButton(), riskLevel)),
                                         CLASS).contains(MUI_BUTTON_CONTAINED);
    }

    public boolean isMediaCheckPaginationSectionDisplayed() {
        return isElementDisplayed(waitMoment, screeningPO.getPaginationSection());
    }

    public boolean isChangesSearchFieldInvalidAriaDisplayed(String fieldName) {
        return getAttributeValue(xpath(format(screeningPO.getChangeSearchInputField(), fieldName)), ARIA_INVALID)
                .equals(Boolean.toString(true));
    }

    public String getChangesSearchElementErrorMessage(String fieldName) {
        return getElementText(xpath(format(screeningPO.getChangeSearchFieldErrorMessage(), fieldName)));
    }

    public String getChangesSearchErrorMessageElementCSS(String fieldName, String cssValue) {
        return getCssValue(xpath(format(screeningPO.getChangeSearchFieldErrorMessage(), fieldName)), cssValue);
    }

    public void clearChangeSearchCriteria(String elementName) {
        clearText(xpath(format(screeningPO.getChangeSearchInputField(), elementName)));

    }

    public boolean isMediaCheckFilterArticlesSubMenuButtonHighlighted(String articleSubMenu) {
        return getAttributeValueWithWait(waitMoment, xpath(format(screeningPO.getMediaCheckFilterArticleSubMenuButton(),
                                                                  articleSubMenu)), CLASS).contains(
                MUI_BUTTON_CONTAINED);
    }

    public boolean isMediaCheckProfileAttachButtonDisabled() {
        return getAttributeValue(screeningPO.getMediaCheckProfileAttach(), CLASS)
                .contains(MUI_DISABLED);
    }

    public boolean isMediaCheckProfileRiskLevelSelected(String fieldName) {
        return getAttributeValue(xpath(format(screeningPO.getMediaCheckProfileRiskLevel(), fieldName)), CLASS)
                .contains(MUI_BUTTON_OUTLINEDPRIMARY);
    }

    public String getMediaCheckProfileRiskLevelCSS(String riskLevelName, String cssValue) {
        return getCssValue(xpath(format(screeningPO.getMediaCheckProfileRiskLevel(), riskLevelName)), cssValue);
    }

    public boolean isMediaCheckProfileCommentUserNameDisplayed(int position, String userName) {
        return isElementDisplayed(waitMoment, getElementByXPath(
                format(screeningPO.getMediaCheckUserNameCommentSection(), position, userName)));
    }

    public boolean isMediaCheckProfileCommentDisplayed(int position, String comment) {
        return isElementDisplayed(waitMoment, getElementByXPath(
                format(screeningPO.getMediaCheckCommentAtCommentSection(), position, comment)));
    }

    public boolean isSimilarArticleAndSeeMoreDisplayed(int position, String textLabel) {
        return isElementDisplayed(xpath(format(screeningPO.getSimilarArticleOrSeeMore(), position, textLabel)));
    }

    public boolean isSimilarArticlesAndSeeMoreInvisible(int position, String textLabel) {
        return isElementInvisible(waitMoment,
                                  xpath(format(screeningPO.getSimilarArticleOrSeeMore(), position, textLabel)));
    }

    public boolean isSourceNameAndSimilarArticleDateDisplayed(int position, String textData) {
        return isElementDisplayed(xpath(format(screeningPO.getSimilarArticleDateAndSourceData(), position, textData)));
    }

    public boolean isTitleNameDisplayed(String type, int position, String titleName) {
        if (Objects.equals(type, THIRD_PARTY)) {
            return isElementDisplayed(waitShort, xpath(format(screeningPO.getTitleName(), position, titleName)));
        } else {
            return isElementDisplayed(waitShort,
                                      xpath(format(screeningPO.getTitleArticleMediaCheckForContact(), position,
                                                   titleName)));
        }
    }

    public boolean isMediaCheckProfileRiskLevelNotSelected(String fieldName) {
        return getAttributeValue(xpath(format(screeningPO.getMediaCheckProfileRiskLevel(), fieldName)), CLASS)
                .contains(MUI_BUTTON_OUTLINEDSECONDARY);
    }

    public String getResolutionCommentValue() {
        return getElementText(screeningPO.getResolutionCommentValue());
    }

    public boolean isMediaCheckProfileTagAsRedFlagToolTipDisplayed(String toolTipValue) {
        return isElementDisplayed(xpath(format(screeningPO.getMediaCheckTagAsRedFlagToolTipMessage(), toolTipValue)));
    }

    public void clickMediaCheckTagAsRedFlagIcon() {
        clickOn(screeningPO.getMediaCheckTagAsRedFlagToolTip());
    }

    public void clickSeeLessLabel(int indexOfArticle) {
        clickOn(xpath(format(screeningPO.getSeeLessLabel(), indexOfArticle)));
    }

    public void clickSeeMoreLabel(int indexOfArticle, String labelName) {
        clickOn(xpath(format(screeningPO.getSimilarArticleOrSeeMore(), indexOfArticle, labelName)));
    }

    public String getScreeningResult() {
        return getElementText(screeningPO.getScreeningResult());
    }

    public void selectInputValue(String fieldName, String inputString) {
        clearAndInputField(xpath(format(screeningPO.getInputField(), fieldName)), inputString);
        clickOn(screeningPO.getFirstDropDownOption());
    }

    public int getIndexOfArticle(MediaCheckResponse results, MediaCheckResponse.Article mediaCheckArticle) {
        return results.getResults().indexOf(mediaCheckArticle) + 1;
    }

    public MediaCheckResponse getMediaCheckResponse(int paginationNumber) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest mediaCheckRequest = getMediaCheckRequest(paginationNumber);
        Response mediaCheckList = ConnectApi.getMediaCheck(mediaCheckRequest, thirdPartyId);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public MediaCheckResponse getMediaCheckTpOtherNameResponse(int paginationNumber, String otherName) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest mediaCheckRequest = getMediaCheckRequest(paginationNumber);
        Response mediaCheckList = ConnectApi.getMediaCheckTpOtherName(mediaCheckRequest, thirdPartyId, otherName);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public MediaCheckResponse getMediaCheckResponseWithPublicationDate(int paginationNumber, String minDate,
            String maxDate) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest mediaCheckRequest =
                getMediaCheckRequestWithPublicationDate(paginationNumber, minDate, maxDate);
        Response mediaCheckList = ConnectApi.getMediaCheck(mediaCheckRequest, thirdPartyId);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public MediaCheckResponse getMediaCheckResponseForPageReference(int paginationNumber, String pageReference,
            String minDate, String maxDate) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest
                mediaCheckRequestPageReference =
                getMediaCheckPageReferenceRequest(paginationNumber, pageReference, minDate, maxDate);
        Response mediaCheckList = ConnectApi.getMediaCheck(mediaCheckRequestPageReference, thirdPartyId);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public PublicationDateResponse getPublicationDate() {
        return ConnectApi.getPublicationDate();
    }

    public MediaCheckResponse getMediaCheckResponseForAssociatedIndividual(int paginationNumber, String firstName,
            String lastName) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String contactId =
                AppApi.getContactId(thirdPartyId, firstName, lastName);
        MediaCheckRequest mediaCheckRequest = getMediaCheckRequest(paginationNumber);
        Response mediaCheckList = ConnectApi.getMediaCheckAssociatedIndividual(mediaCheckRequest, contactId);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public MediaCheckResponse getMediaCheckResponseForIndOtherName(int paginationNumber, String firstName,
            String lastName) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String contactId =
                AppApi.getContactId(thirdPartyId, firstName, lastName);
        MediaCheckRequest mediaCheckRequest = getMediaCheckRequest(paginationNumber);
        Response mediaCheckList = ConnectApi.getMediaCheckIndOtherName(mediaCheckRequest, contactId, lastName);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public SimilarArticleResponse getSimilarArticleListResponse(String duplicateKey) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        SimilarArticleRequest similarArticleRequest = new SimilarArticleRequest();
        similarArticleRequest.setDeduplicationHash(duplicateKey);
        Response similarArticleList = ConnectApi.getSimilarArticle(similarArticleRequest, thirdPartyId);
        return getResponseJsonPathAsObject(similarArticleList, EMPTY, SimilarArticleResponse.class);
    }

    public PepResponse getPepResponse(String referenceId) {
        Response pepStatusList = ConnectApi.getPepStatus(referenceId);
        return getResponseJsonPathAsObject(pepStatusList, EMPTY, PepResponse.class);
    }

    public int getTotalSimilarArticleResultTable(int paginationNumber) {
        waitWhilePreloadProgressbarIsDisappeared();
        return driver.findElements(xpath(format(screeningPO.getSimilarArticleResult(), paginationNumber))).size();
    }

    public boolean isMediaCheckPhasesColorDisplayed(int recordNumber) {
        return isElementContainsCssValue(waitShort, xpath(format(screeningPO.getMediaCheckPhases(), recordNumber)),
                                         COLOR, Colors.MEDIA_CHECK_BLUE.getColorRgba());
    }

    public String getMediaCheckPhases(int recordNumber) {
        return getElementText(xpath(format(screeningPO.getMediaCheckPhases(), recordNumber)));
    }

    public boolean isMediaCheckTopicsColorDisplayed(int recordNumber) {
        return isElementContainsCssValue(waitShort, xpath(format(screeningPO.getMediaCheckTopics(), recordNumber)),
                                         COLOR, Colors.MEDIA_CHECK_BLACK.getColorRgba());
    }

    public String getMediaCheckTopics(int recordNumber) {
        return getElementText(xpath(format(screeningPO.getMediaCheckTopics(), recordNumber)));
    }

    public String getMediaCheckPublicationName(int recordNumber) {
        return getElementText(xpath(format(screeningPO.getMediaCheckPublicationName(), recordNumber)));
    }

    public String getMediaCheckDateText(int recordNumber) {
        return getElementText(xpath(format(screeningPO.getMediaCheckDate(), recordNumber)));
    }

    public boolean isMediaCheckFirstPageButtonDisabled() {
        return getAttributeValue(screeningPO.getMediaCheckFirstPageButton(), CLASS)
                .contains(MUI_DISABLED);
    }

    public boolean isMediaCheckPreviousPageButtonDisabled() {
        return getAttributeValue(screeningPO.getPreviousPageButton(), CLASS)
                .contains(MUI_DISABLED);
    }

    public boolean isMediaCheckNextPageButtonDisabled() {
        return getAttributeValue(screeningPO.getNextPageButton(), CLASS)
                .contains(MUI_DISABLED);
    }

    public boolean isMediaCheckLastPageButtonDisabled() {
        return getAttributeValue(screeningPO.getMediaCheckLastPageButton(), CLASS)
                .contains(MUI_DISABLED);
    }

    public String getMediaCheckTitle(int recordNumber) {
        return getElementText(xpath(format(screeningPO.getMediaCheckTitle(), recordNumber)));
    }

    public void scrollIntoViewWCKeyData(String recordName) {
        scrollIntoView(xpath(format(screeningPO.getKeyDataValue(), recordName)));
    }

    public String getKeyDataValue(String recordName) {
        return getElementText(xpath(format(screeningPO.getKeyDataValue(), recordName)));
    }

    public boolean isWCRecordIconDisplayed(String name, String type) {
        String color = Colors.WC_DISABLE_GREY.getColorRgba();
        return isElementContainsCssValue(waitShort, xpath(format(screeningPO.getWcScreeningTypeTooltip(),
                                                                 name, type)), COLOR, color);
    }

    public void clickConvertTPButton() {
        clickOn(screeningPO.getConvertToThirdPartyButton());
    }

    public void clickModalConvertTP(String buttonName) {
        clickOn(xpath(format(screeningPO.getButtonOnConvertTPModal(), buttonName)));
    }

    public boolean isConvertToThirdPartyModalDisplayed() {
        return isElementDisplayed(waitMoment, screeningPO.getConvertToThirdPartyModal());
    }

    public boolean isEnableScreeningButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(screeningPO.getButtonWithName(), buttonName)));
    }

    public String getWCPepStatus(int recordNumber) {
        return getElementText(xpath(format(screeningPO.getMediaCheckTitle(), recordNumber)));
    }

}

