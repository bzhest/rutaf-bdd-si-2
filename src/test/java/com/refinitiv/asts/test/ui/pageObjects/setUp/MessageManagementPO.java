package com.refinitiv.asts.test.ui.pageObjects.setUp;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.AccessLevel;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class MessageManagementPO extends BasePO {

    private final String buttonWithName = "//*[text()='%s']/parent::button";
    private final By pageTitle = xpath("(//h6)[last()]");
    private final By backButton = cssSelector("button[id=message-management-back-button]");
    private final By editMessageButtons = cssSelector("[aria-label=edit-message]");
    private final By cloneMessageButtons = cssSelector("[aria-label=clone-message]");
    private final String messageWithName = "//tr//td[1]//*[text()='%s']";
    private final String cloneMessageButton = messageWithName + "/ancestor::tr//*[@aria-label='clone-message']";
    private final String editMessageButton = messageWithName + "/ancestor::tr//*[@aria-label='edit-message']";
    private final String columnHeader = "//thead//span[text()='%s']/ancestor::th";
    private final By auditDateRangeFrom = cssSelector("#date-from");
    private final By auditDateRangeTo = cssSelector("#date-to");


    /**
     * Add/Edit Message page
     **/
    private final String fieldName = "//*[text()='%s']/ancestor::fieldset";

    @Getter(AccessLevel.NONE)
    private final String inputField = "/preceding-sibling::input";
    private final String inputFieldWithName = fieldName + inputField;
    private final By versionInput = xpath(String.format(fieldName, "Version") + inputField);
    private final By versionOpenCloseButton =
            xpath(String.format(fieldName, "Version") + "/preceding-sibling::*//button");
    private final By messageNameInput = cssSelector("[aria-label='Message Name']>input");
    private final By messageHeader = cssSelector("[name=header]");
    private final By messageHeaderInput = cssSelector("[aria-label='Message Header']>input");
    private final By publishToInput = xpath(String.format(fieldName, "Publish To") + inputField);
    private final By publishToOpenCloseButton =
            xpath(String.format(fieldName, "Publish To") + "/preceding-sibling::*//button");
    private final By publishTo = xpath("//*[text()='Publish To']/parent::*/following-sibling::*");
    private final By effectiveDateInput = xpath(String.format(fieldName, "Effective Date") + inputField);
    private final By effectiveDate = xpath("//*[text()='Effective Date']/ancestor::label/following-sibling::*");
    private final By createDate = xpath("//*[text()='Date Created']/ancestor::label/following-sibling::*");
    private final By updateDate = xpath("//*[text()='Last Update Date']/ancestor::label/following-sibling::*");
    private final By everyInput = xpath(String.format(fieldName, "Every") + inputField);
    private final By every = xpath("//*[text()='Every']/parent::*/following-sibling::*");
    private final By unitInput = xpath(String.format(fieldName, "Unit") + inputField);
    private final By unit = xpath("//*[text()='Unit']/parent::*/following-sibling::*");
    private final By unitOpenCloseButton =
            xpath(String.format(fieldName, "Unit") + "/preceding-sibling::*//button");
    private final By contentInput = cssSelector("[role=application] [class*=fr-wrapper][dir=auto]>div");
    private final By editIcon = cssSelector("button[title=Edit]");
    private final By messageNameLimitText =
            xpath("//*[@name='name']/ancestor::div[contains(@class, 'MuiForm')]/following-sibling::p");
    private final By messageHeaderLimitText =
            xpath("//*[@name='header']/ancestor::div[contains(@class, 'MuiForm')]/following-sibling::p");
    private final By contentLimitText = cssSelector(".fr-counter");

    /**
     * Clone Message Window
     **/
    private final By messageName = cssSelector("[name=name]");
    private final By newMessageName = cssSelector("[name=newName]");
    private final By newMessageNameError = cssSelector("[aria-label='New Message Name']~p");
    private final By newMessageLimitText =
            xpath("//*[@name='newName']/ancestor::div[contains(@class, 'MuiForm')]/following-sibling::p");

    public MessageManagementPO(WebDriver driver) {
        super(driver);
    }

}
