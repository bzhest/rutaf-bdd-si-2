package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.google.common.collect.Iterables;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ScreeningProfilePO;
import com.refinitiv.asts.test.ui.utils.ImageUtil;
import com.refinitiv.asts.test.ui.utils.data.ui.CommentDTO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import com.refinitiv.asts.test.ui.utils.wc1.model.ProfileResponseDTO;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiConstants.PROFILE;
import static java.lang.String.format;
import static java.util.stream.IntStream.rangeClosed;
import static org.apache.commons.lang3.StringUtils.*;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ScreeningProfileSectionPage extends BasePage<ScreeningProfileSectionPage> {

    private final ScreeningProfilePO profilePO;

    public ScreeningProfileSectionPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        profilePO = new ScreeningProfilePO(driver, translator);
    }

    @Override
    protected ExpectedCondition<ScreeningProfileSectionPage> getPageLoadCondition() {
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

    public boolean isBackToScreeningResultsButtonDisplayed() {
        return isElementDisplayed(waitLong, profilePO.getBackToScreeningResultsButton());
    }

    public boolean isEmptyTableDisplayed(String tableName) {
        return isElementDisplayed(xpath(format(profilePO.getEmptyTable(), tableName)));
    }

    public boolean isScreeningProfileDisplayed() {
        return getCurrentUrl().contains(PROFILE);
    }

    public boolean isContactScreeningProfileDisplayed() {
        return isElementDisplayed(waitLong, profilePO.getThirdPartyInformationBackButton());
    }

    public boolean isCommentSectionDisplayed() {
        return isElementDisplayed(profilePO.getComments());
    }

    public boolean isSaveProfileCommentButtonDisplayed() {
        return isElementDisplayed(waitShort, profilePO.getSaveCommentButton());
    }

    public boolean isCancelProfileCommentButtonDisplayed() {
        return isElementDisplayed(waitShort, profilePO.getCancelCommentButton());
    }

    public boolean isAddReviewerProfileCommentButtonDisplayed() {
        return isElementDisplayed(waitShort, profilePO.getAddReviewerCommentButton());
    }

    public boolean isResolutionDisplayed() {
        return isElementDisplayed(profilePO.getResolutionType());
    }

    public boolean isTagsDisplayed() {
        return isElementDisplayed(profilePO.getTagsButton());
    }

    public boolean isTagAsRedFlagSwitched() {
        return isElementAttributeContains(profilePO.getTagAsRedFlagSwitch(), CLASS, TestConstants.CHECKED);
    }

    public String getRiskLevelProfileValue() {
        return getElementText(profilePO.getRiskLevelValue());
    }

    public String getReasonProfileValue() {
        return getElementText(profilePO.getReasonValue());
    }

    public String getElementText(String headerElementName) {
        WebElement element = getElementByXPath(format(profilePO.getNameElement(), headerElementName));
        return Objects.nonNull(element) ? getTableElementText(element) : StringUtils.EMPTY;
    }

    public String getTextFieldText(String headerElementName) {
        WebElement element = getElementByXPath(format(profilePO.getTextElement(), headerElementName));
        return Objects.nonNull(element) ? getTableElementText(element) : StringUtils.EMPTY;
    }

    public int getSelectedResolutionPosition() {
        List<WebElement> resolutions = getElements(profilePO.getResolutionList());
        for (int i = 0; i < resolutions.size(); i++) {
            if (resolutions.get(i).getAttribute(CLASS).contains(COLOR_PRIMARY)) {
                return i;
            }
        }
        return 3;
    }

    public List<List<String>> getTableValues(String tableName) {
        int listSize = driver.findElements(xpath(format(profilePO.getTableRowList(), tableName))).size();
        return rangeClosed(1, listSize)
                .mapToObj(
                        i -> getElementsText(
                                driver.findElements(xpath(format(profilePO.getScreeningTableRow(), tableName, i)))))
                .collect(Collectors.toList());
    }

    public List<List<String>> getKeywordsList() {
        int keywordsListSize = getElements(profilePO.getKeywordsTableRowList()).size();
        return rangeClosed(1, keywordsListSize)
                .mapToObj(i -> getElementsText(driver.findElements(cssSelector(format(profilePO.getKeywordsRow(), i)))))
                .collect(Collectors.toList());
    }

    //        TODO do not delete, uncomment when RMS-16039 will be fixed
    public List<String> getRecordUpdateDates() {
        return getElementsText(profilePO.getRecordUpdateDateList());
    }

    public List<List<Object>> getConnectionsList() {
        int connectionsListSize = getElements(profilePO.getRowList()).size();
        int connectionsColumnSize = getElements(profilePO.getColumnsList()).size();

        return rangeClosed(1, connectionsListSize).mapToObj(i -> rangeClosed(1, connectionsColumnSize).mapToObj(j -> {
            if (j == 3) {
                return getElementsText(cssSelector(format(profilePO.getConnectionsRow(), i, j)));
            } else {
                return getTableElementText(cssSelector(format(profilePO.getConnectionsRow(), i, j)));
            }
        }).collect(Collectors.toList())).collect(Collectors.toList());
    }

    public List<String> getAliasValues(String name) {
        List<WebElement> elements = getElements(format(profilePO.getAliasRows(), name));
        return elements.isEmpty() ? new ArrayList<>() :
                getElementsText(elements);
    }

    public List<String> getExternalSourcesList() {
        return getElementsText(getElements(profilePO.getExternalSourcesList()));
    }

    public List<String> getTableColumns(String tableName) {
        List<WebElement> elements = getElements(format(profilePO.getScreeningTableHeaders(), tableName));
        return elements.isEmpty() ? new ArrayList<>() : getElementsText(elements);
    }

    public List<String> getKeywordsTableColumns() {
        return getElementsText(profilePO.getKeywordsTableColumnsList());
    }

    public List<String> getConnectionsTableColumns() {
        return getElementsText(profilePO.getColumnsList());
    }

    public List<ProfileResponseDTO.Detail> getDetailsValues() {
        return getElementsText(driver.findElements(profilePO.getFurtherInformationSectionNames()))
                .stream()
                .map(sectionName -> new ProfileResponseDTO.Detail()
                        .setText(getElementText(
                                xpath(format(profilePO.getFurtherInformationSectionText(), sectionName))))
                        .setTitle(sectionName))
                .collect(Collectors.toList());
    }

    public String getFurtherInformation(String elementName) {
        return getElementText(xpath(format(profilePO.getFurtherInformationSectionText(), elementName)));
    }

    public String getCommentsFurtherInformation() {
        return getElementText(profilePO.getCommentsFurtherInformation());
    }

    public String getCommentText() {
        WebElement commentText = getElements(profilePO.getComments()).get(0).findElement(profilePO.getCommentText());
        return removeEnd(getElementText(commentText),
                         OPENED_SQUARE_BRACKET + getFromDictionaryIfExists("thirdPartyInformation.screening.seeMore") +
                                 CLOSED_SQUARE_BRACKET).trim();
    }

    public String getCommentAuthor() {
        WebElement author = getElements(profilePO.getComments()).get(0).findElement(profilePO.getCommentAuthor());
        return getElementText(author);
    }

    public String getCommentDate() {
        WebElement commentDate = getElements(profilePO.getComments()).get(0).findElement(profilePO.getCommentDate());
        return getElementText(commentDate);
    }

    public String getReviewStatus() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        waitLong.until(visibilityOfAllElementsLocatedBy(profilePO.getReviewStatus()));
        return getElementText(profilePO.getReviewStatus());
    }

    public String getReviewer() {
        return driver.findElement(profilePO.getReviewersInput()).getAttribute(VALUE);
    }

    public String getReviewerText() {
        return getAttributeOrText(profilePO.getReviewerText(), VALUE);
    }

    public String getReviewerAssignedBy() {
        return getElementText(profilePO.getReviewerAssignedBy());
    }

    public String getLegalNoticeText() {
        return getElementText(profilePO.getLegalNoticeText());
    }

    public void clickOnTab(String tabName) {
        clickOn(xpath(format(profilePO.getTabButton(), tabName)), waitShort);
    }

    public boolean isTabEnabled(String tabName) {
        return isElementEnabled(xpath(format(profilePO.getTabButton(), tabName)));
    }

    public boolean isTabPresent(String tabName) {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(xpath(format(profilePO.getTabButton(), tabName)));
    }

    public boolean isReviewButtonEnabled() {
        return isElementEnabled(profilePO.getReviewButton());
    }

    public boolean isReviewerDetailsDisplayed() {
        return isElementDisplayed(profilePO.getReviewerDetails());
    }

    public void clickOn(String elementName) {
        clickOn(getElementByName(elementName));
    }

    public void clickResolveScreeningProfile(int resolutionButtonIndex) {
        clickOn(xpath(format(profilePO.getResolutionButton(), resolutionButtonIndex + 1)), waitShort);
    }

    public void clickAddReviewerButton() {
        clickOn(profilePO.getAddReviewerButton(), waitLong);
    }

    public void clickReviewButton() {
        waitShort.until(ExpectedConditions.visibilityOfElementLocated(profilePO.getReviewButton()));
        clickOn(profilePO.getReviewButton());
    }

    public void selectReviewerType(String reviewerType) {
        WebElement reviewerTypeCheckbox =
                findElementByXpath(waitLong, format(profilePO.getReviewerType(), reviewerType));
        if (!reviewerTypeCheckbox.getAttribute(CLASS).contains(MUI_CHECKED)) {
            clickOn(reviewerTypeCheckbox);
        }
    }

    public void fillInReviewer(String reviewerName) {
        boolean isMatchedItemDisplayed = false;
        int count = 1;
        int maxTries = 5;
        By dropDownOption = xpath(format(profilePO.getDropDownOption(), reviewerName));
        clearAndInputField(profilePO.getReviewersInput(), reviewerName);
        while (!isMatchedItemDisplayed && count++ <= maxTries) {
            try {
                waitMoment.until(visibilityOfElementLocated(dropDownOption));
                clickOn(dropDownOption);
                isMatchedItemDisplayed = true;
            } catch (TimeoutException e) {
                if (count == maxTries) {
                    throw new TimeoutException("Failed to find reviewer drop-down item \n " + e.getMessage());
                } else {
                    clearAndInputField(profilePO.getReviewersInput(), reviewerName);
                    enterViaKeyboard(Keys.ENTER);
                    clickOn(profilePO.getReviewersInput());
                }
            }
        }
    }

    public void fillInEditReviewer(String reviewerName) {
        clearAndFillInValueAndSelectFromDropDown(reviewerName, profilePO.getReviewer());
    }

    public void fillInCurrentDueDate() {
        waitWhilePreloadProgressbarIsDisappeared();
        waitLong.until(visibilityOfElementLocated(profilePO.getDueDateInput()));
        clickOn(profilePO.getDueDateInput());
        getElement(profilePO.getDueDateInput()).sendKeys(getTodayDate(REACT_FORMAT));
        enterViaKeyboard(Keys.ENTER);
    }

    public void clickSaveButton() {
        clickOn(profilePO.getSaveReviewerButton(), waitShort);
    }

    public void clickCreateAdHocActivity() {
        clickOn(profilePO.getCreateAdHocActivityButton(), waitMoment);
    }

    public void clickSaveEditButton() {
        clickOn(profilePO.getSaveReviewerEditButton(), waitMoment);
    }

    public void clickBackToScreeningResultsButton() {
        clickOn(profilePO.getBackToScreeningResultsButton(), waitShort);
    }

    private WebElement getElementByName(String elementName) {
        switch (elementName) {
            case EXPORT_TO_PDF:
                return getElement(profilePO.getExportToPdfButton());
            case LEGAL_NOTICE:
                return getElement(profilePO.getLegalNotice());
            case ADD_COMMENT_BUTTON:
                return getElement(profilePO.getAddCommentButton());
            case BACK_TO_SCREENING_RESULTS:
                return getElement(profilePO.getBackToScreeningResultsButton());
            default:
                throw new RuntimeException("Unsupported web element " + elementName);
        }
    }

    private String getTableElementText(By elementLocator) {
        return getTableElementText(getElement(elementLocator));
    }

    private String getTableElementText(WebElement element) {
        return element.getAttribute(TITLE_ATR).equals(EMPTY) ?
                getElementText(element) : getAttributeValue(element, TITLE_ATR);
    }

    public void clickTabOnScreeningResultsPage(String tabName) {
        clickOn(xpath(format(profilePO.getTabOnScreeningResults(), tabName)));
    }

    public void clickThirdPartyBackButton() {
        clickOn(profilePO.getThirdPartyInformationBackButton(), waitLong);
    }

    public void clickThirdPartyOtherNamesBackButton() {
        clickOn(profilePO.getThirdPartyOtherNamesInformationBackButton(), waitShort);
    }

    public void clickReviewerClearButton() {
        moveToElementAndClick(driver.findElement(profilePO.getReviewerClearButton()));
    }

    public void clickCommentButton() {
        clickOn(profilePO.getCommentButton(), waitMoment);
    }

    public void clickCommentButton(String buttonName) {
        clickOn(xpath(format(profilePO.getCommentsButtonWithName(), buttonName)), waitMoment);
    }

    public void waitForCommentButtonToAppear(String buttonName) {
        waitShort.until(visibilityOfElementLocated(xpath(format(profilePO.getCommentsButtonWithName(), buttonName))));
    }

    public void fillInComment(String commentText) {
        WebElement commentInput = Iterables.getLast(getElements(profilePO.getCommentTextArea()));
        clearAndInputField(commentInput, commentText);
    }

    public boolean isWorldCheckLogoPresent() {
        String imagePath = "/ui/thirdParty/img/%s.png";
        String worldCheckLogoName = "Refinitiv World Check Logo";
        return ImageUtil.isDownloadedImageCorrect(imagePath, worldCheckLogoName,
                                                  getElement(profilePO.getWorldCheckLogo()));
    }

    public List<String> getHeaderDetailsList() {
        return getElementsText(profilePO.getHeadersDetailsList()).stream()
                .map(header -> header.replace(COLON_ROW_DELIMITER, SPACE))
                .map(header -> header.replace(ROW_DELIMITER, SPACE))
                .collect(Collectors.toList());
    }

    public List<String> getScreeningProfileTabDataList() {
        return getTabDataList(profilePO.getTabDataList());

    }

    public List<String> getConnectionsTabDataList() {
        return getTabDataList(profilePO.getConnectionsTabDataList());
    }

    public List<String> getKeywordsTabDataList() {
        return getTabDataList(profilePO.getKeywordsTabDataList());
    }

    public List<String> getSourcesTabDataList() {
        return getTabDataList(profilePO.getSourcesTabDataList());
    }

    private List<String> getTabDataList(By tabDataLocator) {
        return getElementsText(tabDataLocator).stream()
                .map(data -> data.replace(COLON_ROW_DELIMITER, SPACE))
                .map(data -> data.replace(ROW_DELIMITER, SPACE))
                .map(record -> StringUtils.removeEnd(record, " -"))
                .collect(Collectors.toList());
    }

    public List<CommentDTO> getAllProfileComments() {
        List<CommentDTO> commentList = new ArrayList<>();
        try {
            waitShort.ignoring(StaleElementReferenceException.class)
                    .until(visibilityOfAllElementsLocatedBy(profilePO.getComments()));
            IntStream.rangeClosed(0, getElements(profilePO.getComments()).size() - 1)
                    .forEach(i -> commentList.add(
                            new CommentDTO()
                                    .setAuthor(getCommentChildElementText(profilePO.getCommentAuthor(), i))
                                    .setDate(getCommentChildElementText(profilePO.getCommentDate(), i))
                                    .setCommentText(getCommentChildElementText(profilePO.getCommentText(), i))));
            return commentList;
        } catch (TimeoutException e) {
            logger.info("There are no comments on Screening Profile page");
        }
        return commentList;
    }

    private String getCommentChildElementText(By childElement, int position) {
        return getRowChildElementText(getElements(profilePO.getComments()).get(position), childElement);
    }

    public boolean isCommentButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(profilePO.getCommentsButtonWithName(), buttonName)));
    }

    public boolean isCommentButtonDisabled(String buttonName) {
        return isElementAttributeContains(xpath(format(profilePO.getCommentsButtonWithName(), buttonName)),
                                          CLASS, MUI_DISABLED);
    }

    public boolean isTextInputAreDisplayed() {
        return isElementDisplayed(profilePO.getCommentTextArea());
    }

    public String getCommentTextAreaText() {
        return getElementText(profilePO.getCommentTextArea());
    }

    public boolean isCommentEditButtonDisplayed(String comment) {
        clickOnCommentAuthor(comment);
        return isElementDisplayed(waitMoment, profilePO.getCommentEditButton());
    }

    public boolean isCommentDeleteButtonDisplayed(String comment) {
        clickOnCommentAuthor(comment);
        return isElementDisplayed(waitMoment, profilePO.getCommentDeleteButton());
    }

    public void clickOnCommentAuthor(String comment) {
        scrollIntoView(profilePO.getLegalNotice());
        scrollIntoView(xpath(format(profilePO.getCommentWithText(), comment)));
        hoverOverElement(xpath(format(profilePO.getCommentForAuthor(), comment)));
        clickWithJS(driver.findElement(xpath(format(profilePO.getCommentForAuthor(), comment))));
    }

    public void clickOnCommentEditButton(String comment) {
        clickOnCommentAuthor(comment);
        clickOn(waitMoment.until(presenceOfElementLocated(profilePO.getCommentEditButton())));
    }

    public boolean isEditedLabelDisplayedOnComment(String expectedComment) {
        return isElementDisplayed(xpath(format(profilePO.getCommentEditedLabel(), expectedComment)));
    }

    public boolean isEditedLabelDisplayedOnCommentOnPosition(String expectedComment, int position) {
        return isElementDisplayed(xpath(format(profilePO.getCommentEditedLabelPosition(), expectedComment, position)));
    }

    public void clickOnCommentDeleteButton(String comment) {
        clickOnCommentAuthor(comment);
        clickOn(waitMoment.until(presenceOfElementLocated(profilePO.getCommentDeleteButton())));
    }

    public void clickLegalNoticeLink() {
        clickOn(profilePO.getLegalNoticeLink());
    }

    public boolean isRedFlagTurnOn() {
        return getAttributeValueWithWait(waitShort, profilePO.getTagAsRedFlag(), CLASS).contains(
                MUI_CHECKED);
    }

    public void turnOnTagAsRedFlag() {
        clickOn(profilePO.getTagAsRedFlag());
    }

    public boolean isCommentSectionDetailPageExpanded() {
        return getAttributeValueWithWait(waitShort, profilePO.getCommentsSectionDetailPage(), CLASS).contains(
                MUI_EXPANDED);
    }

    public void clickCommentAccordion() {
        clickOn(profilePO.getCommentAccordionButton());
    }

    public boolean isSeeMoreOnProfileCommentDisplayed(int position) {
        return isElementDisplayed(waitMoment, getElementByXPath(format(profilePO.getCommentSeeMoreButton(), position)));
    }

    public void clickSeeMore(int position) {
        clickOn(xpath(format(profilePO.getCommentSeeMoreButton(), position)));
    }

    public boolean isSeeLessOnProfileCommentDisplayed(int position) {
        return isElementDisplayed(waitMoment, getElementByXPath(format(profilePO.getCommentSeeLessButton(), position)));
    }

    public void clickSeeLess(int position) {
        clickOn(xpath(format(profilePO.getCommentSeeLessButton(), position)));
    }

    public boolean isShowMoreOnProfileCommentDisplayed() {
        return isElementDisplayed(profilePO.getCommentShowMoreButton());
    }

    public boolean isShowAllCommentOnProfileCommentDisplayed() {
        return isElementDisplayed(profilePO.getCommentShowAllCommentButton());
    }

    public void clickShowMore() {
        clickOn(profilePO.getCommentShowMoreButton());
    }

    public boolean isHideCommentOnProfileCommentDisplayed() {
        return isElementDisplayed(profilePO.getCommentHideCommentsButton());
    }

    public void clickHideComments() {
        clickOn(profilePO.getCommentHideCommentsButton());
    }

    public void clickShowAllComments() {
        clickOn(profilePO.getCommentShowAllCommentButton());
    }

    public boolean isProfileCommentUserNameDisplayed(int position, String userName) {
        return isElementDisplayed(waitMoment, getElementByXPath(
                format(profilePO.getCommentForAuthorPosition(), position, userName)));
    }

    public boolean isProfileCommentTextDisplayed(int position, String comment) {
        return isElementDisplayed(waitMoment, getElementByXPath(
                format(profilePO.getCommentWithTextPosition(), position, comment)));
    }

    public void clickCancelButton() {
        clickOn(profilePO.getCommentCancelButton());
    }

    public boolean isWorldCheckProfileCommentDisplayed(int position, String comment) {
        return isElementDisplayed(waitMoment, getElementByXPath(
                format(profilePO.getCommentWithTextPosition(), position, comment)));
    }

    public String getCommentLengthMessage() {
        return getElementText(profilePO.getCommentLengthMessage());
    }

}
