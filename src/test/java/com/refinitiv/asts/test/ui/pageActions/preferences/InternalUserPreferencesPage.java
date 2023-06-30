package com.refinitiv.asts.test.ui.pageActions.preferences;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.preferences.InternalUserPreferencesPO;
import com.refinitiv.asts.test.ui.utils.ImageUtil;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.SneakyThrows;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.net.URL;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.ON;
import static com.refinitiv.asts.test.ui.constants.Pages.UI_PREFERENCES;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.attributeContains;

public class InternalUserPreferencesPage extends BasePage<InternalUserPreferencesPage> {

    private final InternalUserPreferencesPO preferencesPO;

    public InternalUserPreferencesPage(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
        preferencesPO = new InternalUserPreferencesPO(driver);
    }

    @Override
    protected ExpectedCondition<InternalUserPreferencesPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public String getDateFormatValue() {
        return getElementValue(preferencesPO.getDateFormat());
    }

    public String getPersonalDetailsFieldText(String fieldName) {
        return getElementText(xpath(format(preferencesPO.getPersonalDetailsFieldName(), fieldName)));
    }

    public String getFirstName() {
        return getAttributeValue(preferencesPO.getFirstName(), VALUE);
    }

    public String getLastName() {
        return getAttributeValue(preferencesPO.getLastName(), VALUE);
    }

    public String getPosition() {
        return getAttributeValue(preferencesPO.getPosition(), VALUE);
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, preferencesPO.getMyPreferencesPage());
    }

    @Override
    public void load() {

    }

    public void navigateToPreferencesPage() {
        this.driver.get(URL + UI_PREFERENCES);
    }

    public void waitNewLanguageIsApplied() {
        String expectedTabName = getFromDictionaryIfExists("preferences.myPreferences").toUpperCase();
        waitShort.ignoring(StaleElementReferenceException.class, NullPointerException.class).until(driver -> {
            refreshPage();
            return getElementText(preferencesPO.getMyPreferencesTab()).equals(expectedTabName);
        });
    }

    public void clickSaveButton() {
        clickOn(preferencesPO.getSaveButton(), waitShort);
    }

    public void fillInFirstName(String firstName) {
        clearAndInputField(preferencesPO.getFirstName(), firstName);
    }

    public void fillInLastName(String lastName) {
        clearAndInputField(preferencesPO.getLastName(), lastName);
    }

    public void fillInPosition(String position) {
        clearAndInputField(preferencesPO.getPosition(), position);
    }

    public void clickOnEmailNotification() {
        clickOn(preferencesPO.getEmailNotificationButton());
    }

    public void clearFirstName() {
        clearText(preferencesPO.getFirstName());
    }

    public void clearLastName() {
        clearText(preferencesPO.getLastName());
    }

    public void uploadPhoto(String fileName) {
        driver.findElement(preferencesPO.getUploadLinkInput()).sendKeys(getFilePath(fileName));
    }

    public void fillInLanguage(String language) {
        clearAndFillInValueAndSelectFromDropDown(language, preferencesPO.getLanguageDropdown());
    }

    public void waitForEmailNotificationButtonState(String buttonState) {
        if (buttonState.equals(ON)) {
            waitMoment.until(attributeContains(preferencesPO.getEmailNotificationButton(), CLASS, CHECKED));
        } else {
            waitMoment.until(
                    driver -> !getAttributeValue(preferencesPO.getEmailNotificationButton(), CLASS).contains(CHECKED));
        }
    }

    public boolean isPersonalDetailsFieldEnabled(String fieldName) {
        return isElementEnabled(xpath(format(preferencesPO.getPersonalDetailsFieldInput(), fieldName)));
    }

    public boolean isSystemSettingsDateFormatFieldEnabled() {
        return isElementEnabled(preferencesPO.getDateFormat());
    }

    public boolean isPhotoPlaceholderEnabled() {
        return isElementEnabled(preferencesPO.getPhotoPlaceholder());
    }

    public boolean isSystemSettingsEmailNotificationDisplayed() {
        return isElementDisplayed(preferencesPO.getEmailNotificationButton());
    }

    public boolean isSaveButtonDisabled() {
        return isElementAttributeContains(preferencesPO.getSaveButton(), CLASS, DISABLED);
    }

    public boolean isEmailNotificationOnSelected() {
        return isElementAttributeContains(waitMoment, preferencesPO.getEmailNotificationButton(), CLASS,
                                          CHECKED);
    }

    public boolean isUploadPhotoLinkDisplayed() {
        return isElementDisplayed(preferencesPO.getUploadButton());
    }

    public String getErrorMessage(String field) {
        return getElementText(xpath(format(preferencesPO.getErrorMessage(), field)));
    }

    public String getErrorMessageElementCSS(String fieldName, String cssAttribute) {
        return driver.findElement(xpath(format(preferencesPO.getErrorMessage(), fieldName)))
                .getCssValue(cssAttribute);
    }

    public String getLanguageValue() {
        return getAttributeValue(preferencesPO.getLanguageDropdown(), VALUE);
    }

    @SneakyThrows
    public String getAvatarImageUiPath() {
        String imageSource = getElement(preferencesPO.getAvatar()).getAttribute(SRC);
        return new URL(imageSource).getPath();
    }

    public boolean isFieldInvalidAriaDisplayed(String field) {
        return isElementAttributeContains(xpath(format(preferencesPO.getPersonalDetailsFieldInputWrapper(), field)),
                                          CLASS, ERROR);
    }

    public boolean isAvatarMatchedWithExpectedImage(String expectedPhoto) {
        String imagePath = "/ui/filesForUpload/%s";
        return ImageUtil.isDownloadedImageCorrect(imagePath, expectedPhoto, getElement(preferencesPO.getAvatar()));
    }

    public boolean isPasswordElementDisplayed() {
        return isElementDisplayed(preferencesPO.getPasswordElement());
    }

}
