package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckRequest;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckResponse;
import com.refinitiv.asts.test.ui.api.model.mediacheck.PublicationDateResponse;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.enums.ContactScreeningTableColumns;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.PaginationReactPO;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.OtherNameScreeningSectionPO;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ScreeningSectionPO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import io.restassured.response.Response;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.*;
import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.getResponseJsonPathAsObject;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;
import static com.refinitiv.asts.test.ui.enums.EntityType.SUPPLIER;
import static com.refinitiv.asts.test.ui.enums.ScreeningTableColumns.TYPE;
import static com.refinitiv.asts.test.ui.enums.ScreeningTableColumns.*;
import static java.lang.Boolean.parseBoolean;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class OtherNameScreeningSectionPage extends BasePage<OtherNameScreeningSectionPage> {

    private final OtherNameScreeningSectionPO otherNameScreeningPO;
    private final PaginationReactPO paginationReactPO;
    private final ScreeningSectionPO screeningPO;

    public OtherNameScreeningSectionPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        otherNameScreeningPO = new OtherNameScreeningSectionPO(driver, translator);
        paginationReactPO = new PaginationReactPO();
        screeningPO = new ScreeningSectionPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<OtherNameScreeningSectionPage> getPageLoadCondition() {
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

    public boolean isElementDisplayed(String elementName) {
        return isElementDisplayed(getElementByName(elementName));
    }

    public String getElementText(String elementName) {
        return getElementText(getElementByName(elementName)).replace(ROW_DELIMITER, StringUtils.EMPTY);
    }

    public void clickOn(String elementName) {
        clickOn(getElementByName(elementName));
    }

    public void clickOnPagination(String ariaLabel) {
        clickOn(xpath(format(otherNameScreeningPO.getPaginationButton(), ariaLabel)));
    }

    public void clickOnOtherNamesPagination(String ariaLabel) {
        clickOn(xpath(format(otherNameScreeningPO.getPaginationButtonOtherNames(), ariaLabel)));
    }

    public void clickOnScreeningElement(int elementIndex) {
        clickWithJS(getElement(xpath(format(otherNameScreeningPO.getScreeningResult(), elementIndex))));
    }

    public void clickOnScreeningElement(String referenceId) {
        clickWithJS(getElement(xpath(format(otherNameScreeningPO.getScreeningRecordByReferenceId(), referenceId))));
    }

    public void clickResolveScreeningElement(String referenceId, int resolutionPriority) {
        int maxTries = 5;
        int count = 0;
        By resolutionIcon = xpath(format(otherNameScreeningPO.getOtherNameScreeningResolutionButton(), referenceId,
                                         resolutionPriority + 1));
        clickOn(resolutionIcon);
        while (!isElementDisplayed(xpath(screeningPO.getCommentModalContent())) && count++ <= maxTries) {
            hoverOverElement(xpath(format(otherNameScreeningPO.getScreeningRecordByReferenceId(), referenceId)));
            clickOn(resolutionIcon);
        }
    }

    public void clickResolveScreeningProfiles(String resolutionType) {
        clickOn(xpath(format(otherNameScreeningPO.getOtherNameScreeningBulkResolutionButton(), resolutionType)));
    }

    public void selectPaginationOption(int itemsPerPage) {
        clickOn(xpath(format(otherNameScreeningPO.getOtherNameScreeningPaginationOption(), itemsPerPage)));
    }

    public void selectCheckboxForRow(int elementIndex) {
        clickWithJS(driver.findElement(
                xpath(format(otherNameScreeningPO.getOtherNameScreeningRowCheckbox(), elementIndex))));
    }

    public void clickCloseScreeningResultsButton() {
        clickOn(otherNameScreeningPO.getOtherNameResultsCloseButton(), waitLong);
    }

    public boolean isHeaderCheckboxDisplayed() {
        return isElementDisplayed(otherNameScreeningPO.getOtherNameScreeningHeaderCheckboxSpan());
    }

    public boolean isCheckboxDisplayedForRow(int rowIndex) {
        return isElementDisplayed(xpath(format(otherNameScreeningPO.getOtherNameScreeningRowCheckboxSpan(), rowIndex)));
    }

    public boolean isHeaderCheckboxSelected() {
        return isCheckboxChecked(otherNameScreeningPO.getOtherNameScreeningHeaderCheckboxInput());
    }

    public boolean isCheckboxSelectedForRow(int rowIndex) {
        return isCheckboxChecked(format(otherNameScreeningPO.getOtherNameScreeningRowCheckbox(), rowIndex));
    }

    public boolean isOtherNameDialogLoaded() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return isElementDisplayed(waitLong, xpath(otherNameScreeningPO.getScreeningOtherNameTable())) &&
                isElementDisappeared(waitLong, otherNameScreeningPO.getPreloader());
    }

    public List<String> getPaginationDropDownValues() {
        return getElementsText(otherNameScreeningPO.getOtherNamePaginationValuesList());
    }

    public List<ResultsResponseDTO> getOtherNameScreeningResultsData(String pageType) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        waitLong.until(invisibilityOfElementLocated(otherNameScreeningPO.getNoAvailableMassage()));
        List<String> columnNames = getTableColumnNames();
        return getOtherNameScreeningResults().stream()
                .map(result -> new ResultsResponseDTO()
                        .setPrimaryName(
                                getAttributeOrText(result, xpath(otherNameScreeningPO.getTableRowNameValue()),
                                                   TITLE_ATR))
                        .setCountryLinksString(getValue(result, pageType.contains(SUPPLIER.toString().toLowerCase()) ?
                                                                COUNTRY_OF_REGISTRATION.getColumnName().toUpperCase() :
                                                                ContactScreeningTableColumns.COUNTRY_OF_LOCATION.getColumnName().toUpperCase(),
                                                        columnNames))
                        .setCategory(getValue(result, TYPE.getColumnName().toUpperCase(), columnNames))
                        .setMatchStrength(getValue(result, MATCH_STRENGTH.getColumnName().toUpperCase(), columnNames))
                        .setProviderTypeString(
                                getValue(result, DATA_PROVIDER.getColumnName().toUpperCase(), columnNames))
                        .setReferenceId(getValue(result, REFERENCE_ID.getColumnName().toUpperCase(), columnNames))
                        .setResolutionPosition(getResolutionPosition(result))

                ).collect(Collectors.toList());
    }

    private int getResolutionPosition(WebElement result) {
        List<WebElement> resolutionElements = result.findElements(xpath(otherNameScreeningPO.getRowResolutionList()));
        return IntStream.range(0, resolutionElements.size())
                .filter(i -> resolutionElements.get(i).getAttribute(CLASS).contains(COLOR_PRIMARY)).findFirst()
                .orElse(3);
    }

    private String getValue(WebElement row, String columnName, List<String> columnNames) {
        int columnNameIndex = columnNames.indexOf(columnName) + 2;
        return columnNameIndex == 1 ? null :
                getElementText(
                        row.findElement(xpath(format(otherNameScreeningPO.getTableRowValue(), columnNameIndex))));
    }

    private List<String> getTableColumnNames() {
        return getElementsText(otherNameScreeningPO.getOtherNameScreeningTableHeaderList());
    }

    public List<WebElement> getOtherNameScreeningResults() {
        try {
            return waitLong.until(
                    numberOfElementsToBeMoreThan(otherNameScreeningPO.getOtherNameScreeningTableResultList(), 0));
        } catch (TimeoutException e) {
            return new ArrayList<>();
        }
    }

    public String getPaginationSelection() {
        return getElementText(otherNameScreeningPO.getPaginationSelection());
    }

    public boolean isScreeningRecordWithIdDisplayed(String referenceId) {
        return !isElementDisappeared(waitShort, xpath(format(otherNameScreeningPO.getScreeningRecordByReferenceId(),
                                                             referenceId)));
    }

    public int getSelectedResolutionIndexById(String referenceId) {
        List<WebElement> rowElements = driver.findElements(
                xpath(format(otherNameScreeningPO.getScreeningResolutionButtonsListByReferenceId(), referenceId)));
        int selectedElementIndex = 3;
        for (int i = 0; i < rowElements.size(); i++) {
            if (rowElements.get(i).getAttribute(CLASS).contains(COLOR_PRIMARY)) {
                selectedElementIndex = i;
            }
        }
        return selectedElementIndex;
    }

    public int getTotalPages() {
        return parseInt(getElementText(otherNameScreeningPO.getTotalPages()));
    }

    private By getElementByName(String elementName) {
        switch (elementName) {
            case OTHER_NAME_SCREENING_RESULTS_POP_UP:
                return otherNameScreeningPO.getOtherNameScreeningResultPopUpHeader();
            case OTHER_NAME_LAST_SCREENING_DATE:
                return otherNameScreeningPO.getOtherNameLastScreeningDate();
            case SCREENING_RESULT_TEXT:
                return otherNameScreeningPO.getOtherNameScreeningTableText();
            case OTHER_NAME_SCREENING_REFRESH_BUTTON:
                return otherNameScreeningPO.getOtherNameScreeningTableRefreshButton();
            case OTHER_NAME_SCREENING_PAGINATION:
                return otherNameScreeningPO.getOtherNameScreeningPagination();
            case OTHER_NAME_SCREENING_PAGINATION_DROP_DOWN:
                return otherNameScreeningPO.getOtherNameScreeningPaginationDropDown();
            case SELECT_ALL:
                return otherNameScreeningPO.getOtherNameScreeningHeaderCheckboxInput();
            case RESOLVE_AS:
            case CANCEL:
                return otherNameScreeningPO.getResolveAsButton();
            default:
                throw new RuntimeException("Unsupported web element " + elementName);
        }
    }

    public void clickOtherNameScreeningTab(String tabName) {
        clickOn(xpath(format(otherNameScreeningPO.getOtherNameTabButton(), tabName)), waitLong);
    }

    public String getOtherNameOGSToggleLabel() {
        return getElementText(otherNameScreeningPO.getOtherNameOGSToggle());
    }

    public boolean isOGSToggleLabelInvisible() {
        return isElementInvisible(waitLong, otherNameScreeningPO.getOtherNameOGSToggle());
    }

    public boolean isOtherNameTabSelected(String tabName) {
        return parseBoolean(
                getAttributeValue(xpath(format(otherNameScreeningPO.getOtherNameTabButton(), tabName)), ARIA_SELECTED));
    }

    public boolean isOtherNameOGSTurnedOnDisplayed() {
        return isElementDisplayed(waitLong, otherNameScreeningPO.getOtherNameOGSToggleChecked());
    }

    public boolean isOtherNameOGSTurnedOffDisplayed() {
        return isElementDisplayed(waitLong, otherNameScreeningPO.getOtherNameOGSToggleUnchecked());
    }

    public boolean isPaginationDisabled() {
        return isElementAttributeContains(otherNameScreeningPO.getOtherNameScreeningPaginationNextButton(), CLASS,
                                          DISABLED);
    }

    public void clickOtherNamesOGS() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(otherNameScreeningPO.getOtherNamesOgsSwitchButton());
    }

    public boolean checkOtherNamesOGSToggleShouldBeInvisible() {
        return isElementInvisible(waitLong, otherNameScreeningPO.getOtherNameOGSToggle());
    }

    public boolean isOtherNamesOGSToggleHidden() {
        return isElementInvisible(waitShort, otherNameScreeningPO.getOtherNamesOgsSwitchButton());
    }

    public boolean isTabInvisible(String tabName) {
        return isElementInvisible(waitLong, format(otherNameScreeningPO.getScreeningTab(), tabName));
    }

    public boolean isTabVisible(String tabName) {
        return isElementDisplayed(waitLong, xpath(format(otherNameScreeningPO.getScreeningTab(), tabName)));
    }

    public void clickOtherNamesRowsPerPageDropDown() {
        clickOn(otherNameScreeningPO.getOtherNamesMediaCheckRowPerPageDropdown(), waitShort);
    }

    public void clickOtherNamesItemsRowsPerPageOption(String paginationOption) {
        clickOn(cssSelector(format(paginationReactPO.getItemsPerPageDropdownOption(), paginationOption)));
    }

    public int getOtherNamesTotalRecordsFromMediaCheckResultTable() {
        waitWhilePreloadProgressbarIsDisappeared();
        return driver.findElements(otherNameScreeningPO.getOtherNamesMediaCheckResultTableRecords()).size();
    }

    public String getOtherNamesMediaCheckRowsPerPageValue() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(otherNameScreeningPO.getOtherNamesMediaCheckRowPerPageDropdown());
    }

    public List<String> getOtherNamesRowsPerPageDropDownOptions() {
        return getDropDownOptions(otherNameScreeningPO.getDropDownOptions());
    }

    public void clickSelectMediaCheckOtherNamesScreeningRecord(int recordReference) {
        waitWhilePreloadProgressbarIsDisappeared();
        waitShort.pollingEvery(Duration.ofMillis(500))
                .ignoring(StaleElementReferenceException.class).until(driver -> {
            clickOn(xpath(
                    format(otherNameScreeningPO.getMediaCheckOtherNamesScreeningSelectRecord(), recordReference)));
            return true;
        });
    }

    public String getOtherNameMediaCheckRecordName(int recordReference) {
        String webElementText = getElementText(
                xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesScreeningRecord(), recordReference)));
        return webElementText.substring(0, webElementText.indexOf(ROW_DELIMITER));
    }

    public boolean isMediaCheckOtherNamesScreeningRecordChecked(int recordReference) {
        return isElementDisplayed(
                xpath(format(otherNameScreeningPO.getMediacheckOtherNamesScreeningRecordChecked(), recordReference)));
    }

    public String getOtherNameScreeningRecordName(int elementIndex) {
        return getAttributeOrText(xpath(format(otherNameScreeningPO.getScreeningRecordName(), elementIndex)),
                                  TITLE_ATR);
    }

    public String getOtherNameScreeningRecordId(int elementIndex) {
        return getElementText(xpath(format(otherNameScreeningPO.getScreeningRecordId(), elementIndex)));
    }

    public String getOtherNameMediaCheckScreeningRecordId(int elementIndex) {
        return getElementText(xpath(format(otherNameScreeningPO.getMediaCheckScreeningRecordId(), elementIndex)));
    }

    public String getPaginationLabel() {
        return getElementText(otherNameScreeningPO.getPaginationLabel());
    }

    public String getOGSTooltipTexts() {
        hoverOverElement(otherNameScreeningPO.getOtherNameOGSToggle());
        return getElementText(otherNameScreeningPO.getTooltip());
    }

    public List<String> getResolutionTypeTooltipTexts() {
        return IntStream.range(0, getElements(otherNameScreeningPO.getResolutionTypeButtons()).size()).mapToObj(
                iconNumber -> {
                    scrollIntoView((getElements(otherNameScreeningPO.getResolutionTypeButtons()).get(iconNumber)));
                    this.hoverOverElement(getElements(otherNameScreeningPO.getResolutionTypeButtons()).get(iconNumber));
                    return getElementText(otherNameScreeningPO.getTooltip());
                }).collect(Collectors.toList());
    }

    public List<String> getScreeningTableColumnNames() {
        return getElementsText(otherNameScreeningPO.getScreeningTableHeaderList());
    }

    public boolean isMediaCheckOtherNamesRecordRiskLevelIconDisplayed(int recordReference, String riskLevelName) {
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
        return isElementContainsCssValue(waitShort,
                                         xpath(format(
                                                 otherNameScreeningPO.getMediaCheckOtherNamesScreeningRecordRiskIcon(),
                                                 recordReference)),
                                         BACKGROUND_COLOR, color);
    }

    public String getMediaCheckOtherNamesRecordRiskLevelIconName(int recordReference) {
        return getElementText(
                xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesScreeningRecordRiskIcon(), recordReference)));
    }

    public void hoversOverMediaCheckOtherNamesRiskLevelRecordIcon(int recordReference) {
        hoverOverElement(
                xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesScreeningRecordRiskIcon(), recordReference)));
    }

    public void clickScreenOtherNameScreeningIcon(String elementText) {
        clickOn(xpath(format(otherNameScreeningPO.getOtherNameScreening(), elementText)), waitLong);
    }

    public void fillInResolutionOtherNameComment(String text) {
        clickOn(otherNameScreeningPO.getResolutionOtherNameComment());
        getElement(otherNameScreeningPO.getResolutionOtherNameComment()).sendKeys(text);
    }

    public void clearCommentMediaResolutionOtherNamesValue() {
        clearText(otherNameScreeningPO.getResolutionOtherNameComment());
    }

    public String getEditCommentLengthMessage() {
        return getElementText(otherNameScreeningPO.getCommentLengthMessage());
    }

    public String getMediaCheckSearchTermInScreeningOtherNamesResultTable() {
        return getElementText(otherNameScreeningPO.getMediaCheckSearchTermInScreeningOtherNamesResultTable());
    }

    public String getOtherNameLastScreeningDateText() {
        return getElementText(otherNameScreeningPO.getOtherNamesLastScreeningDate());
    }

    public MediaCheckResponse getMediaCheckOtherNameResponse(int paginationNumber, String otherName) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest mediaCheckRequest = getMediaCheckRequest(paginationNumber);
        Response mediaCheckList = ConnectApi.getMediaCheckOtherNames(mediaCheckRequest, thirdPartyId, otherName);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public MediaCheckResponse getMediaCheckOtherNameResponseWithPublicationDate(int paginationNumber, String minDate,
            String maxDate, String otherName) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest mediaCheckRequest =
                getMediaCheckRequestWithPublicationDate(paginationNumber, minDate, maxDate);
        Response mediaCheckList = ConnectApi.getMediaCheckOtherNames(mediaCheckRequest, thirdPartyId, otherName);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public MediaCheckResponse getMediaCheckOtherNameResponseForPageReference(int paginationNumber, String pageReference,
            String minDate, String maxDate, String otherName) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        MediaCheckRequest
                mediaCheckRequestPageReference =
                getMediaCheckPageReferenceRequest(paginationNumber, pageReference, minDate, maxDate);
        Response mediaCheckList =
                ConnectApi.getMediaCheckOtherNames(mediaCheckRequestPageReference, thirdPartyId, otherName);
        return getResponseJsonPathAsObject(mediaCheckList, EMPTY, MediaCheckResponse.class);
    }

    public int getIndexOfArticleOtherName(MediaCheckResponse results, MediaCheckResponse.Article mediaCheckArticle) {
        return results.getResults().indexOf(mediaCheckArticle) + 1;
    }

    public boolean isMediaCheckOtherNamePhasesColorDisplayed(int recordNumber) {
        return isElementContainsCssValue(waitShort, xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesPhases(),
                                                                 recordNumber)),
                                         COLOR, Colors.MEDIA_CHECK_BLUE.getColorRgba());
    }

    public String getMediaCheckOtherNamePhases(int recordNumber) {
        return getElementText(xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesPhases(), recordNumber)));
    }

    public boolean isMediaCheckOtherNameTopicsColorDisplayed(int recordNumber) {
        return isElementContainsCssValue(waitShort, xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesTopics(),
                                                                 recordNumber)),
                                         COLOR, Colors.MEDIA_CHECK_BLACK.getColorRgba());
    }

    public String getMediaCheckOtherNameTopics(int recordNumber) {
        return getElementText(xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesTopics(), recordNumber)));
    }

    public String getMediaCheckOtherNamePublicationName(int recordNumber) {
        return getElementText(
                xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesPublicationName(), recordNumber)));
    }

    public String getMediaCheckOtherNameDateText(int recordNumber) {
        return getElementText(xpath(format(otherNameScreeningPO.getMediaCheckOtherNamesDate(), recordNumber)));
    }

    public String getMediaCheckOtherNameArticleNumber() {
        return getElementText(otherNameScreeningPO.getMediaCheckOtherNamesArticleNumber()).replaceAll(COMMA,
                                                                                                      StringUtils.EMPTY);
    }

    public PublicationDateResponse getPublicationDate() {
        return ConnectApi.getPublicationDate();
    }

    public String getMediaCheckOtherNameTitle(int recordNumber) {
        return getElementText(xpath(format(otherNameScreeningPO.getMediaCheckOtherNameTitle(), recordNumber)));
    }

    public boolean isOGSToggleOtherNameDisable() {
        return isElementDisplayed(waitShort, otherNameScreeningPO.getOgsButtonOtherNameDisable());
    }

    public boolean isOgsOtherNameTurned() {
        return getAttributeValue(otherNameScreeningPO.getOgsOtherNameSwitchButtonSpan(), CLASS).contains(CHECKED);
    }

    public void scrollIntoViewMediaCheckOtherNameToolTipRecord(String toolTipMessage) {
        scrollIntoView(xpath(format(otherNameScreeningPO.getMediaCheckOtherNameScreeningRecordRiskToolTip(), toolTipMessage)));
    }

    public boolean isMediaCheckOtherNameRiskLevelToolTipDisplayed(String toolTipMessage) {
        scrollIntoViewMediaCheckOtherNameToolTipRecord(toolTipMessage);
        return isElementDisplayed(xpath(format(otherNameScreeningPO.getMediaCheckOtherNameScreeningRecordRiskToolTip(), toolTipMessage)));
    }

}