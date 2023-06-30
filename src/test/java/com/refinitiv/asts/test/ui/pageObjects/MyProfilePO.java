package com.refinitiv.asts.test.ui.pageObjects;

import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

@Getter
public class MyProfilePO extends BasePO {

    private final By myProfileHeader = xpath("//span[text()='My Profile']");
    private final String myProfileTab = "//span[text()='%s']/ancestor::button";
    private final String fieldInput = "//span[text()='%s']/ancestor::fieldset/preceding-sibling::input";
    private final String fieldValue = "//span[text()='%s']/ancestor::fieldset/parent::div/preceding-sibling::label";
    private final String section = "//*[text()='%s']/ancestor::*[contains(@class, 'MuiAccordion-root')]";
    private final String sectionFieldValue = section + fieldValue;
    private final String sectionFieldInput = section + fieldInput;
    private final By tabs = cssSelector("#ExternalUsers-ProfilePageHeader button[role=tab]");
    private final String uncollapseArrow = "//*[text()='%s']/preceding-sibling::*[name()='svg']";
    private final String profileErrorMessage = "//*[contains(., '%s')]/../following-sibling::p";
    private final String profileFieldInputError =
            "//*[contains(., '%s')]/../following-sibling::div[contains(@class, 'error')]";
    private final By contactsColumnsNames = cssSelector("thead th span[role=button]");
    private final String columnName = "//thead//span[text()='%s']";

    public MyProfilePO(WebDriver driver) {
        super(driver);
    }

}
