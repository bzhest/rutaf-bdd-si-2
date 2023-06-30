package com.refinitiv.asts.test.ui.pageObjects.preferences;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class InternalUserPreferencesPO extends BasePO {

    public InternalUserPreferencesPO(WebDriver driver) {
        super(driver);
    }

    private final By dateFormat = id("system-settings-date-format");
    private final By saveButton = id("user-preferences-save-button");
    private final By myPreferencesPage = xpath("//h6[text()='Personal Details']");
    private final By firstName = id("personal-details-first-name");
    private final By lastName = id("personal-details-last-name");
    private final By position = id("personal-details-position");
    private final By emailNotificationButton =
            xpath("//input[@name='Email Notification']/ancestor::span[contains(@class, 'MuiButtonBase-root')]");
    private final String personalDetailsFieldName = "//span[contains(., '%s')]/..";
    private final String personalDetailsFieldInput =
            personalDetailsFieldName + "/ancestor::fieldset/preceding-sibling::input";
    private final String personalDetailsFieldInputWrapper =
            personalDetailsFieldName + "/ancestor::fieldset/preceding-sibling::input/..";
    private final By photoPlaceholder = xpath("//*[contains(@class, 'MuiPaper-outlined')]");
    private final By photoImage = xpath("//*[contains(@class, 'MuiPaper-outlined')]/img");
    private final By uploadButton = xpath("//label[@for='user-avatar-upload']");
    private final By uploadLinkInput = id("user-avatar-upload");
    private final String errorMessage = personalDetailsFieldName + "/../..//p";
    private final By languageDropdown = id("system-settings-language");
    private final By myPreferencesTab = xpath("//button[@role=\"tab\"][1]/span");
    private final By avatar = cssSelector("[alt=avatar]");
    private final By passwordElement = xpath("//*[contains(., 'Password')]");

}
