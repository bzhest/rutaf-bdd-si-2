package com.refinitiv.asts.test.ui.pageActions.preferences;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.preferences.ExternalUserPreferencesPO;
import com.refinitiv.asts.test.ui.utils.ImageUtil;
import lombok.SneakyThrows;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.net.URL;

import static com.refinitiv.asts.test.ui.constants.Pages.EXTERNAL_USER_PREFERENCES;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.WHITE;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;

public class ExternalUserPreferencesPage extends BasePage<ExternalUserPreferencesPage> {

    private final ExternalUserPreferencesPO preferencesPO;

    public ExternalUserPreferencesPage(WebDriver driver) {
        super(driver);
        preferencesPO = new ExternalUserPreferencesPO();
    }

    @Override
    protected ExpectedCondition<ExternalUserPreferencesPage> getPageLoadCondition() {
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

    @SneakyThrows
    public String getAvatarImageUiPath() {
        String imageSource = getElement(preferencesPO.getAvatar()).getAttribute(SRC);
        return new URL(imageSource).getPath();
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, preferencesPO.getMyPreferencesPage());
    }

    @Override
    public void load() {

    }

    public void navigateToPreferencesPage() {
        this.driver.get(URL + EXTERNAL_USER_PREFERENCES);
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

    public boolean isPersonalDetailsFieldEnabled(String fieldName) {
        return isElementEnabled(xpath(format(preferencesPO.getPersonalDetailsFieldInput(), fieldName)));
    }

    public boolean isSystemSettingsDateFormatFieldEnabled() {
        return isElementEnabled(preferencesPO.getDateFormat());
    }

    public boolean isPhotoPlaceholderEnabled() {
        return isElementEnabled(preferencesPO.getPhotoPlaceHolder());
    }

    public boolean isSystemSettingsEmailNotificationDisplayed() {
        return isElementDisplayed(preferencesPO.getEmailNotificationButton());
    }

    public boolean isSaveButtonDisabled() {
        return getAttributeValue(preferencesPO.getSaveButton(), CLASS).contains(DISABLED);
    }

    public boolean isEmailNotificationTurnedOn() {
        return isElementAttributeContains(preferencesPO.getTurnOnButton(), CLASS, GREEN);
    }

    public boolean isEmailNotificationOnSelected() {
        return isElementAttributeContains(waitMoment, preferencesPO.getOnEmailNotification(), CLASS,
                                          WHITE.toString().toLowerCase());
    }

    public boolean isUploadPhotoLinkDisplayed() {
        return isElementDisplayed(preferencesPO.getUploadLink());
    }

    public void uploadPhoto(String fileName) {
        driver.findElement(preferencesPO.getUploadLinkInput()).sendKeys(getFilePath(fileName));
    }

    public boolean isAvatarMatchedWithExpectedImage(String imageName) {
        String imagePath = "/ui/filesForUpload/%s";
        return ImageUtil.isDownloadedImageCorrect(imagePath, imageName, getElement(preferencesPO.getAvatar()));
    }

    public boolean isOutOfOfficeTabDisplayed() {
        return isElementDisplayed(preferencesPO.getOooTab());
    }

}
