package com.refinitiv.asts.test.ui.pageActions.login;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.login.LoginPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static com.refinitiv.asts.test.ui.constants.TestConstants.VALIDATION_MESSAGE;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class LoginPage extends BasePage<LoginPage> {

    private final LoginPO loginPO;

    public LoginPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        loginPO = new LoginPO();
    }

    @Override
    protected ExpectedCondition<LoginPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, loginPO.getSignInButton());
    }

    @Override
    public void load() {

    }

    public void navigateToLoginPage() {
        logger.info("Application URL: " + URL);
        this.driver.get(URL);
    }

    public void loginUser(UserData userData) {
        fillInUserName(userData.getUsername());
        fillInPassword(userData.getPassword());
        clickSignInButton();
    }

    public void fillInUserName(String userName) {
        clickOn(loginPO.getUsernameField(), waitLong);
        clearAndInputField(loginPO.getUsernameField(), userName);
    }

    public void fillInPassword(String password) {
        By passwordInput = loginPO.getUserPasswordField();
        clearText(passwordInput);
        waitMoment.until(visibilityOfElementLocated(passwordInput)).sendKeys(password);
    }

    public void fillInNewPassword(String password) {
        driver.findElement(loginPO.getNewPasswordInput()).sendKeys(password);
    }

    public void fillInConfirmPassword(String password) {
        driver.findElement(loginPO.getConfirmPasswordInput()).sendKeys(password);
    }

    public void fillInEmail(String password) {
        driver.findElement(loginPO.getUsernameField()).sendKeys(password);
    }

    public void clickSignInButton() {
        clickOn(loginPO.getSignInButton());
    }

    public void clickForgotPasswordButton() {
        clickOn(loginPO.getForgotPasswordButton(), waitLong);
    }

    public void clickResetButton() {
        clickOn(loginPO.getResetButton(), waitShort);
    }

    public void clickOkButton() {
        clickOn(loginPO.getOkButton(), waitLong);
    }

    public boolean isConfirmationDialogOpened(String userName) {
        By okButtonLocator = loginPO.getOkButton();
        try {
            waitShort.until(elementToBeClickable(okButtonLocator));
        } catch (TimeoutException e) {
            if (isElementDisplayed(loginPO.getServerErrorCode())) {
                clickOn(loginPO.getBackToLoginButton());
                clickOn(loginPO.getForgotPasswordButton(), waitMoment);
                fillInEmail(userName);
                clickResetButton();
            }
        }
        return isElementDisplayed(waitShort, okButtonLocator);
    }

    public void clickSaveButton() {
        clickOn(loginPO.getSaveButton(), waitShort);
    }

    public void clickPrivacyPolicyFooterLink() {
        clickOn(loginPO.getPrivacyPolicyFooterLink(), waitShort);
    }

    public void fillInInputField(String fieldName, String value) {
        clearAndInputField(xpath(format(loginPO.getInputField(), fieldName)), value);
    }

    public String getErrorMessageText() {
        return getElementText(loginPO.getErrorMessage());
    }

    public String getServerErrorMessage() {
        return getElementText(loginPO.getServerErrorMessage());
    }

    public String getPageText() {
        return waitLong.until(visibilityOfElementLocated((loginPO.getFormWrapper()))).getText();
    }

    public String getModalText() {
        return waitLong.until(visibilityOfElementLocated(loginPO.getInfoModal())).getText();
    }

    public String getFooterText() {
        return waitShort.until(visibilityOfElementLocated(loginPO.getLoginFooter())).getText();
    }

    public String getUsernameValidationMessage() {
        return driver.findElement(loginPO.getUsernameField()).getAttribute(VALIDATION_MESSAGE);
    }

    public String getInputFieldValidationMessage(String fieldName) {
        return driver.findElement(xpath(format(loginPO.getInputField(), fieldName))).getAttribute(VALIDATION_MESSAGE);
    }

    public boolean isErrorMessageDisplayed() {
        return isElementDisplayed(waitShort, loginPO.getErrorMessage());
    }

    public boolean isTextElementDisplayed(String text) {
        return isElementDisplayed(waitLong, xpath(format(loginPO.getElementWithText(), text)));
    }

    public boolean isInputFieldDisplayed(String fieldPlaceholder) {
        return isElementDisplayed(xpath(format(loginPO.getInputField(), fieldPlaceholder)));
    }

}
