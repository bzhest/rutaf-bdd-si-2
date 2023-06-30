package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.MessageManagementPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MessageManagementData;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static io.netty.karate.util.internal.StringUtil.isNullOrEmpty;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.openqa.selenium.By.xpath;

public class MessageManagementPage extends BasePage<MessageManagementPage> {

    private static final String MESSAGE_NAME = "Message Name";
    private static final String STATUS = "Status";
    private static final String VERSION = "Version";
    private static final String PUBLISH_TO = "Publish To";
    private static final String EFFECTIVE_DATE = "Effective Date";

    private final MessageManagementPO messageManagementPO;

    public MessageManagementPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        messageManagementPO = new MessageManagementPO(driver);
    }

    @Override
    protected ExpectedCondition<MessageManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public String getPageTitle(String expectedTitle) {
        waitShort.until(driver -> expectedTitle.equalsIgnoreCase(getElementText(messageManagementPO.getPageTitle())));
        return getElementText(messageManagementPO.getPageTitle());
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public void navigateToMessageManagementPage() {
        driver.get(URL + MESSAGE_MANAGEMENT);
    }

    public boolean isButtonPresent(String buttonName) {
        return isElementDisplayed(By.xpath(format(messageManagementPO.getButtonWithName(), buttonName)));
    }

    public void clickOnButton(String buttonName) {
        clickOn(By.xpath(format(messageManagementPO.getButtonWithName(), buttonName)));
    }

    public List<WebElement> getEditMessageButtons() {
        return getElements(messageManagementPO.getEditMessageButtons());
    }

    public List<WebElement> getCloneMessageButtons() {
        return getElements(messageManagementPO.getCloneMessageButtons());
    }

    public void navigateToAddMessagePage() {
        driver.get(URL + MESSAGE_MANAGEMENT_ADD);
    }

    public void navigateToViewMessagePage(String messageId) {
        driver.get(URL + format(MESSAGE_MANAGEMENT_VIEW, messageId));
    }

    public void navigateToEditMessagePage(String messageId) {
        driver.get(URL + format(MESSAGE_MANAGEMENT_EDIT, messageId));
    }

    public void hoverOverElementOnRow(WebElement row, By elementLocator) {
        WebElement button = row.findElement(elementLocator);
        scrollIntoView(button);
        hoverOverElement(row.findElement(elementLocator));
    }

    public void hoverOverCloneButtonOnRow(WebElement row) {
        hoverOverElementOnRow(row, messageManagementPO.getCloneMessageButtons());
    }

    public void clickOnFirstCloneButton() {
        clickOn(getCloneMessageButtons().get(0));
    }

    public void clickOnCloneButton(String messageName) {
        clickOn(xpath(format(messageManagementPO.getCloneMessageButton(), messageName)));
    }

    public void clickOnEditButton(String messageName) {
        clickOn(xpath(format(messageManagementPO.getEditMessageButton(), messageName)));
    }

    public void clickOnMessage(String messageName) {
        clickOn(xpath(format(messageManagementPO.getMessageWithName(), messageName)));
    }

    public void hoverOverEditButtonOnRow(WebElement row) {
        hoverOverElementOnRow(row, messageManagementPO.getEditMessageButtons());
    }

    public void hoverOverMessageNameOnFirstRow() {
        List<String> headers = getTableHeaders();
        WebElement firstRow = getTableRowsElements().get(0);
        WebElement nameCell = firstRow.findElements(messageManagementPO.getTableRowColumns())
                .get(headers.indexOf(MESSAGE_NAME.toUpperCase()));
        hoverOverElement(nameCell);
    }

    public boolean isCloneButtonPresentOnRow(WebElement row) {
        return isButtonPresentOnRow(row, messageManagementPO.getCloneMessageButtons());
    }

    public boolean isEditButtonPresentOnRow(WebElement row) {
        return isButtonPresentOnRow(row, messageManagementPO.getEditMessageButtons());
    }

    public boolean isButtonPresentOnRow(WebElement row, By element) {
        try {
            setImplicitWaitToZero();
            return isElementDisplayed(row.findElement(element));
        } catch (NoSuchElementException exception) {
            return false;
        } finally {
            revertImplicitWaitToDefaults();
        }
    }

    public List<WebElement> getTableRowsElements() {
        return getElements(messageManagementPO.getTableRows());
    }

    public List<MessageManagementData> getTableRowsValues() {
        return getTableRowsElements().stream().map(
                        row -> new MessageManagementData()
                                .setName(getRowChildElementText(row, MESSAGE_NAME.toUpperCase()))
                                .setStatus(getRowChildElementText(row, STATUS.toUpperCase()))
                                .setVersion(Integer.valueOf(getRowChildElementText(row, VERSION.toUpperCase())))
                                .setPublishTo(getRowChildElementText(row, PUBLISH_TO.toUpperCase()))
                                .setEffectiveDateTime(getRowChildElementText(row, EFFECTIVE_DATE.toUpperCase())))
                .collect(Collectors.toList());
    }

    public MessageManagementData getFirstTableRowValues() {
        WebElement firstRow = getTableRowsElements().get(0);
        return new MessageManagementData()
                .setName(getRowChildElementText(firstRow, MESSAGE_NAME.toUpperCase()))
                .setStatus(getRowChildElementText(firstRow, STATUS.toUpperCase()))
                .setVersion(Integer.valueOf(getRowChildElementText(firstRow, VERSION.toUpperCase())))
                .setPublishTo(getRowChildElementText(firstRow, PUBLISH_TO.toUpperCase()))
                .setEffectiveDateTime(getRowChildElementText(firstRow, EFFECTIVE_DATE.toUpperCase()));
    }

    public List<String> getMessagesNames() {
        return getTableRowsElements().stream().map(row -> getRowChildElementText(row, MESSAGE_NAME.toUpperCase()))
                .collect(Collectors.toList());
    }

    private String getRowChildElementText(WebElement row, String childColumnName) {
        List<String> headers = getTableHeaders();
        return getElementText(row.findElements(messageManagementPO.getTableRowColumns())
                                      .get(headers.indexOf(childColumnName)));
    }

    public List<WebElement> getTableRowsWithStatus(String status) {
        List<String> headers = getTableHeaders();
        int columnIndex = headers.indexOf(STATUS.toUpperCase());
        return getTableRowsElements().stream().filter(
                row -> row.findElements(messageManagementPO.getTableRowColumns())
                        .get(columnIndex)
                        .getText()
                        .equals(status)).collect(Collectors.toList());
    }

    public void clickColumnHeader(String headerName) {
        clickOn(xpath(format(messageManagementPO.getColumnHeader(), headerName)));
    }

    public void clickBackButton() {
        clickOn(messageManagementPO.getBackButton());
    }

    public void clickOnFirstRecord() {
        context.getScenarioContext().setContext(ContextConstants.MESSAGE_NAME, getFirstTableRowValues().getName());
        clickOn(messageManagementPO.getRow());
    }

    public void fillInMessageManagementData(MessageManagementData messageManagementData) {
        fillInName(messageManagementData.getName());
        fillInHeader(messageManagementData.getHeader());
        fillInPublishTo(messageManagementData.getPublishTo());
        fillInEffectiveDate(messageManagementData.getEffectiveDateTime());
        if (Objects.nonNull(messageManagementData.getFrequency())) {
            fillInEvery(String.valueOf(messageManagementData.getFrequency().getValue()));
            fillInUnit(messageManagementData.getFrequency().getUnit());
        }
        fillInContent(messageManagementData.getContent());
    }

    public void fillInName(String name) {
        if (!isNullOrEmpty(name)) {
            clearAndInputField(messageManagementPO.getMessageNameInput(), name);
        }
    }

    public void fillInHeader(String header) {
        if (!isNullOrEmpty(header)) {
            clearAndInputField(messageManagementPO.getMessageHeaderInput(), header);
        }
    }

    private void fillInPublishTo(String publishTo) {
        if (!isNullOrEmpty(publishTo)) {
            clearAndFillInValueAndSelectFromDropDown(publishTo, messageManagementPO.getPublishToInput());
        }
    }

    private void fillInEffectiveDate(String effectiveDate) {
        if (!isNullOrEmpty(effectiveDate)) {
            clearAndInputField(messageManagementPO.getEffectiveDateInput(), effectiveDate);
        }
    }

    private void fillInEvery(String every) {
        if (!isNullOrEmpty(every)) {
            clearAndFillInValueAndSelectFromDropDown(every, messageManagementPO.getEveryInput());
        }
    }

    private void fillInUnit(String unit) {
        if (!isNullOrEmpty(unit)) {
            clearAndFillInValueAndSelectFromDropDown(unit, messageManagementPO.getUnitInput());
        }
    }

    public void fillInContent(String content) {
        if (!isNullOrEmpty(content)) {
            clearAndInputField(messageManagementPO.getContentInput(), content);
        }
    }

    public void fillInVersion(String version) {
        if (!isNullOrEmpty(version)) {
            clearAndFillInValueAndSelectFromDropDown(version, messageManagementPO.getVersionInput());
        }
    }

    public String getCloneWindowMessageName() {
        return getElementText(waitShort, messageManagementPO.getMessageName());
    }

    public String getCloneWindowNewMessageName() {
        return getElementValue(messageManagementPO.getNewMessageName());
    }

    public boolean isNewMessageFieldRequired() {
        return Boolean.parseBoolean(getAttributeValue(messageManagementPO.getNewMessageName(), REQUIRED));
    }

    public void fillInCloneWindowNewMessageName(String name) {
        clearAndInputField(messageManagementPO.getNewMessageName(), name);
    }

    public String getNewMessageLimitText() {
        return getElementText(messageManagementPO.getNewMessageLimitText());
    }

    public String getMessageNameLimitText() {
        return getElementText(messageManagementPO.getMessageNameLimitText());
    }

    public String getMessageHeaderLimitText() {
        return getElementText(messageManagementPO.getMessageHeaderLimitText());
    }

    public String geContentLimitText() {
        return getElementText(messageManagementPO.getContentLimitText());
    }

    public boolean isButtonDisplayed(String buttonName) {
        return isElementDisplayed(waitMoment, xpath(format(messageManagementPO.getButtonWithName(), buttonName)));
    }

    public String getNewMessageFieldError() {
        return getElementText(messageManagementPO.getNewMessageNameError());
    }

    public boolean isFieldInputDisplayed(String field) {
        return isElementDisplayedNow(xpath(format(messageManagementPO.getInputFieldWithName(), field)));
    }

    public boolean isContentInputDisplayed() {
        return isElementDisplayedNow((messageManagementPO.getContentInput()));
    }

    public String getFieldInputValue(String fieldName) {
        return getElementValue(xpath(format(messageManagementPO.getInputFieldWithName(), fieldName)));
    }

    public void clickEditIcon() {
        clickOn(messageManagementPO.getEditIcon());
    }

    public boolean isEditIconDisplayed() {
        return isElementDisplayed(waitMoment, messageManagementPO.getEditIcon());
    }

    public String getBreadcrumbText(String expectedTitle) {
        waitShort.until(driver -> getElementText(messageManagementPO.getBreadcrumbs()).replace(LF, SPACE)
                .equalsIgnoreCase(expectedTitle));
        return getElementText(messageManagementPO.getBreadcrumbs());
    }

    public MessageManagementData getMessageManagementData() {
        return new MessageManagementData()
                .setName(getElementText(messageManagementPO.getMessageName()))
                .setHeader(getElementText(messageManagementPO.getMessageHeader()))
                .setVersion(Integer.valueOf(getAttributeValue(messageManagementPO.getVersionInput(), VALUE)
                                                    .replace(VERSION + SPACE, StringUtils.EMPTY)))
                .setPublishTo(getElementText(messageManagementPO.getPublishTo()))
                .setEffectiveDateTime(getElementText(messageManagementPO.getEffectiveDate()))
                .setFrequency(new MessageManagementData.Frequency()
                                      .setUnit(getElementText(messageManagementPO.getUnit()))
                                      .setValue(Integer.valueOf(getElementText(messageManagementPO.getEvery()))))
                .setCreatedDateTime(getElementText(messageManagementPO.getCreateDate()))
                .setUpdatedDateTime(getElementText(messageManagementPO.getUpdateDate()))
                .setContent(getElementText(messageManagementPO.getContentInput()));
    }

    public String getMessageContent() {
        return getElementText(messageManagementPO.getContentInput());
    }

    public MessageManagementData getMessageManagementDataOnInputFields() {
        return new MessageManagementData()
                .setName(getElementValue(messageManagementPO.getMessageNameInput()))
                .setHeader(getElementValue(messageManagementPO.getMessageHeader()))
                .setVersion(Integer.valueOf(getElementValue(messageManagementPO.getVersionInput())
                                                    .replace(VERSION + SPACE, StringUtils.EMPTY)))
                .setPublishTo(getElementValue(messageManagementPO.getPublishToInput()))
                .setEffectiveDateTime(getElementValue(messageManagementPO.getEffectiveDateInput()))
                .setFrequency(new MessageManagementData.Frequency()
                                      .setUnit(getElementValue(messageManagementPO.getUnitInput()))
                                      .setValue(Integer.valueOf(getElementValue(messageManagementPO.getEveryInput()))))
                .setContent(getElementText(messageManagementPO.getContentInput()));
    }

    public void clickOnPublishToOpenCloseButton() {
        clickOn(messageManagementPO.getPublishToOpenCloseButton());
    }

    public void clickOnUnitOpenCloseButton() {
        clickOn(messageManagementPO.getUnitOpenCloseButton());
    }

    public void clickOnVersionOpenCloseButton() {
        clickOn(messageManagementPO.getVersionOpenCloseButton());
    }

    public boolean isMessageNameInputDisabled() {
        return Boolean.parseBoolean(getAttributeValue(messageManagementPO.getMessageNameInput(), DISABLED));
    }

    public void fillInDateFrom(String date) {
        clearAndInputField(messageManagementPO.getAuditDateRangeFrom(), date);
    }

    public void fillInDateTo(String date) {
        clearAndInputField(messageManagementPO.getAuditDateRangeTo(), date);
    }

}
