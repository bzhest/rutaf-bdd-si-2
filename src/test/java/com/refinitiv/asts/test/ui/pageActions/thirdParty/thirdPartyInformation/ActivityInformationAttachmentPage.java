package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ActivityInformationAttachmentPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ActivityInformationAttachmentData;
import com.refinitiv.asts.test.ui.utils.data.ui.ActivityInformationAttachmentDTO;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_SORT;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static io.netty.karate.util.internal.StringUtil.SPACE;
import static java.lang.String.format;
import static java.util.Collections.reverseOrder;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfAllElementsLocatedBy;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class ActivityInformationAttachmentPage extends BasePage<ActivityInformationAttachmentPage> {

    private final ActivityInformationAttachmentPO activityInformationAttachmentPO;

    public ActivityInformationAttachmentPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        activityInformationAttachmentPO = new ActivityInformationAttachmentPO(driver);
    }

    @Override
    protected ExpectedCondition<ActivityInformationAttachmentPage> getPageLoadCondition() {
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

    public boolean isDescriptionFieldDisplayed(boolean isVisibilityExpected) {
        return isVisibilityExpected ? isElementDisplayed(waitLong, activityInformationAttachmentPO.getDescription()) :
                isElementDisplayedNow(activityInformationAttachmentPO.getDescription());
    }

    public boolean isCancelButtonDisplayed() {
        return isElementDisplayedNow(activityInformationAttachmentPO.getCancelAttachmentButton());
    }

    public boolean isUploadButtonDisplayed() {
        return isElementDisplayedNow(activityInformationAttachmentPO.getUploadAttachmentButton());
    }

    public boolean isUploadButtonDisabled() {
        return getAttributeValue(activityInformationAttachmentPO.getUploadAttachmentButton(), CLASS)
                .contains(MUI_DISABLED);
    }

    public boolean isBrowseButtonDisplayed() {
        return isElementDisplayed(activityInformationAttachmentPO.getBrowseButton());
    }

    public void addDescription(String text) {
        clearAndInputField(activityInformationAttachmentPO.getDescription(), text);
    }

    public void uploadFile(String file) {
        String path = getFilePath(file);
        if (isElementDisplayed(activityInformationAttachmentPO.getUploadFileCrossButton())) {
            clickOn(activityInformationAttachmentPO.getUploadFileCrossButton());
        }
        driver.findElement(activityInformationAttachmentPO.getUploadFile()).sendKeys(path);
        waitLong.until(visibilityOfElementLocated(activityInformationAttachmentPO.getUploadFileCrossButton()));
    }

    public void clickUploadButton() {
        clickOn(activityInformationAttachmentPO.getUploadAttachmentButton(), waitMoment);
    }

    public void clickCancelButton() {
        clickOn(activityInformationAttachmentPO.getCancelAttachmentButton(), waitMoment);
    }

    public List<ActivityInformationAttachmentDTO> getAllAttachmentsElements() {
        waitWhilePreloadProgressbarIsDisappeared();
        List<ActivityInformationAttachmentDTO> list = new ArrayList<>();
        try {
            waitShort.until(visibilityOfAllElementsLocatedBy(activityInformationAttachmentPO.getTableRow()));
            for (WebElement row : getElements(activityInformationAttachmentPO.getTableRow())) {
                list.add(new ActivityInformationAttachmentDTO()
                                 .setFileName(row.findElement(activityInformationAttachmentPO.getRowFileName()))
                                 .setDescription(
                                         row.findElement(activityInformationAttachmentPO.getRowDescription()))
                                 .setUploadDate(row.findElement(activityInformationAttachmentPO.getRowUploadDate()))
                                 .setDownloadIcon(getElement(waitMoment, () -> row.findElement(
                                         activityInformationAttachmentPO.getRowDownloadIcon())))
                                 .setDeleteIcon(getElement(waitMoment, () -> row.findElement(
                                         activityInformationAttachmentPO.getRowDeleteIcon()))));
            }
            return list;
        } catch (TimeoutException ex) {
            logger.info("Attachment's table is empty");
            return list;
        }
    }

    public List<ActivityInformationAttachmentData> getAllAttachmentsData(boolean isPendingExpected) {
        waitShort.ignoring(StaleElementReferenceException.class)
                .pollingEvery(Duration.ofMillis(100))
                .until(visibilityOfAllElementsLocatedBy(activityInformationAttachmentPO.getTableRow()));
        return IntStream.rangeClosed(1, getElements(activityInformationAttachmentPO.getTableRow()).size())
                .mapToObj(i -> new ActivityInformationAttachmentData()
                        .setFileName(getRowChildElementText(
                                cssSelector(format(activityInformationAttachmentPO.getTableRowWithNumber(), i)),
                                activityInformationAttachmentPO.getRowFileName()))
                        .setDescription(getRowChildElementText(
                                cssSelector(format(activityInformationAttachmentPO.getTableRowWithNumber(), i)),
                                activityInformationAttachmentPO.getRowDescription()))
                        .setUploadDate(getUploadDateCellText(
                                cssSelector(format(activityInformationAttachmentPO.getTableRowWithNumber(), i)),
                                activityInformationAttachmentPO.getRowUploadDate(),
                                isPendingExpected))
                        .setDownloadIconPresent(!isNull(getElement(waitMoment, () -> getElements(
                                activityInformationAttachmentPO.getTableRow()).get(i - 1).findElement(
                                activityInformationAttachmentPO.getRowDownloadIcon()))))
                        .setDeleteIconPresent(!isNull(getElement(waitMoment, () -> getElements(
                                activityInformationAttachmentPO.getTableRow()).get(i - 1).findElement(
                                activityInformationAttachmentPO.getRowDeleteIcon()))))).collect(
                        Collectors.toList());
    }

    private String getUploadDateCellText(By rowLocator, By childLocator, boolean isPendingExpected) {
        if (!isPendingExpected) {
            waitShort.until(driver -> !getRowChildElementText(rowLocator, childLocator).equals(PENDING));
        }
        return getRowChildElementText(rowLocator, childLocator);
    }

    public ActivityInformationAttachmentDTO getAttachment(String attachment) {
        return getAllAttachmentsElements().stream()
                .filter(element -> nonNull(element.getFileName().getText()) && element.getFileName().getText()
                        .contains(attachment))
                .findFirst()
                .orElse(null);
    }

    public ActivityInformationAttachmentData getAttachmentData(String attachment, boolean isPendingExpected) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return getAllAttachmentsData(isPendingExpected).stream()
                .filter(element -> element.getFileName()
                        .equals(attachment))
                .findFirst()
                .orElse(null);
    }

    public String getWarningMessage() {
        return getElementText(activityInformationAttachmentPO.getFileWarningMessage());
    }

    public void clickDeleteAttachmentIcon(String attachment) {
        WebElement deleteIcon = getAttachment(attachment).getDeleteIcon();
        waitElementIsClickable(deleteIcon);
        clickOn(deleteIcon);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickHeaderColumn(String column) {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(xpath(format(activityInformationAttachmentPO.getHeaderColumn(), column)));
    }

    public List<ActivityInformationAttachmentDTO> getSortedActivityAttachmentsTableRows(String sortedBy,
            String sortOrder) {
        Comparator<ActivityInformationAttachmentDTO> comparator;
        List<ActivityInformationAttachmentDTO> activityTableRows = getAllAttachmentsElements();

        switch (ActivityAttachmentFields.valueOf(sortedBy.toUpperCase().replace(SPACE, '_'))) {
            case FILE_NAME:
                comparator = new ActivityInformationAttachmentDTO.ActivityAttachmentFilenameComparator();
                break;
            case DESCRIPTION:
                comparator = new ActivityInformationAttachmentDTO.ActivityDescriptionComparator();
                break;
            case UPLOAD_DATE:
                comparator = new ActivityInformationAttachmentDTO.ActivityAttachmentDateComparator();
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + ActivityAttachmentFields.valueOf(sortedBy));
        }
        if (sortOrder.equals(DEFAULT_SORT)) {
            activityTableRows.sort(reverseOrder(comparator));
        } else {
            activityTableRows.sort(comparator);
        }
        return activityTableRows;
    }

    public List<String> getTableColumns() {
        scrollIntoView(activityInformationAttachmentPO.getSectionHeader());
        return getElementsText(activityInformationAttachmentPO.getHeaderColumnName());
    }

    public boolean isActivityInformationAttachmentsTableEmpty() {
        return isElementDisplayed(activityInformationAttachmentPO.getNoAvailableDataTitle());
    }

    public void clickCollapseExpandIcon() {
        clickOn(activityInformationAttachmentPO.getCollapseExpandIcon());
    }

    public boolean isAttachmentsBlockExpanded() {
        return getAttributeValue(activityInformationAttachmentPO.getAttachmentsBlock(), CLASS).contains(MUI_EXPANDED);
    }

    public String getDescriptionLimitText() {
        return isElementDisplayedNow(activityInformationAttachmentPO.getDescriptionLimitMessage()) ?
                getElementText(activityInformationAttachmentPO.getDescriptionLimitMessage()) : null;
    }

}
