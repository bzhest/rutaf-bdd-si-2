package com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class GroupFormPO extends BasePO {

    public GroupFormPO(WebDriver driver) {
        super(driver);
    }

    private final String activeCheckboxSpan = "//span[contains(text(), 'Active')]";
    private final By activeCheckboxInput = xpath(activeCheckboxSpan + "/ancestor::label//input");
    private final By saveGroupButton = xpath("//*[text()='Save']/parent::button");
    private final By cancelGroupButton = xpath("//*[text()='Cancel']/parent::button");
    private final String userGroupFormPage =
            "//*[contains(@class, 'MuiBreadcrumbs-separator')]/following-sibling::li//*[text()='%s']";
    private final String groupFormInput =
            "//span[contains(., '%s')]/../..//input | //span[contains(., '%<s')]/../..//textarea";
    private final By membersDropDownItem = xpath("//li[contains(@id, '-option-')]");
    private final String dropDownSelectedItems =
            "//span[contains(., '%s')]/ancestor::fieldset/preceding-sibling::div[@role='button']";
    private final String dropDownSelectedItem = "//span[contains(., '%s')]/ancestor::div[@role='button']";
    private final By dropDownClearButton = cssSelector("[type=button][title=Clear]");
    private final String groupFormFieldset = "//span[text()='%s']/ancestor::fieldset";
    private final String groupFormInputAsterisk = "//span[contains(., '%s')]/following-sibling::span";
    private final By inputFieldError = xpath("//div[contains(@class, 'error')]");
    private final String validationMessage =
            "//span[contains(., '%s')]/../../../..//p | //span[contains(., '%<s')]/../../../../../div/following-sibling::p";
    private final By editButton = xpath("//form/div[1]//button");
    private final By groupMenuButton =
            xpath("//p[text()='User Management']/../../following-sibling::div//p[text()='Groups']");
    private final String crossControlButton = dropDownSelectedItem + "/*[contains(@class, 'Svg')]";
    private final By breadcrumb = xpath("//nav");

}