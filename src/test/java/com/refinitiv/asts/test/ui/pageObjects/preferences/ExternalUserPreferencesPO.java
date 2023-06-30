package com.refinitiv.asts.test.ui.pageObjects.preferences;

import lombok.Data;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.*;

@Data
public class ExternalUserPreferencesPO {

    private final By dateFormat = id("system-settings-date-format");
    private final By saveButton = id("user-preferences-save-button");
    private final By myPreferencesPage = xpath("//h6[text()='Personal Details']");
    private final By firstName = id("personal-details-first-name");
    private final By lastName = id("personal-details-last-name");
    private final By position = id("personal-details-position");
    private final By emailNotificationButton =
            xpath("//input[@name='Email Notification']/ancestor::span[contains(@class, 'MuiButtonBase-root')]");
    private final By onEmailNotification = xpath("//span[text()='ON']");
    private final String personalDetailsFieldName =
            "//h6[text()='Personal Details']/../following-sibling::div//span[contains(., '%s')]/..";
    private final String personalDetailsFieldInput =
            personalDetailsFieldName + "/ancestor::fieldset/preceding-sibling::input";
    private final String personalDetailsFieldInputWrapper =
            personalDetailsFieldName + "/ancestor::fieldset/preceding-sibling::input/..";
    private final By avatar = cssSelector("[alt=avatar]");
    private final By photoPlaceHolder = xpath("//*[contains(@class, 'MuiPaper-outlined')]");
    private final By turnOnButton = xpath("//span[text()='ON']");
    private final By uploadLink = cssSelector("[for='user-avatar-upload']");
    private final By uploadLinkInput = id("user-avatar-upload");
    private final By oooTab = xpath("//span[text()='Out of office']/ancestor::button[@role='tab']");

}
