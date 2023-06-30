package com.refinitiv.asts.test.ui.pageObjects.login;

import lombok.Getter;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.*;

@Getter
public class LoginPO {

    private final By usernameField = cssSelector("[placeholder='Username*'], [data-qid='ForgotPassword-input'");
    private final By userPasswordField = xpath("//*[@placeholder='Password*']");
    private final By signInButton = xpath("//*[@data-qid='SignIn-button-login']");
    private final By errorMessage = id("error-msg");
    private final By serverErrorMessage = id("server-error-msg");
    private final By serverErrorCode = id("server-error-code");
    private final By forgotPasswordButton = id("passwordRecoverLink");
    private final By resetButton = id("recoverySubmit");
    private final By okButton = xpath("//button[contains(text(), 'OK')]");
    private final By newPasswordInput = id("reset-password");
    private final By confirmPasswordInput = id("reset-password2");
    private final By saveButton = id("submit");
    private final By formWrapper = xpath("//*[@class='boarder-all padding-double']");
    private final By infoModal = cssSelector(".modal-content");
    private final By privacyPolicyFooterLink = xpath("//footer//a[contains(text(), 'Privacy Policy')]");
    private final By loginFooter = className("footer");
    private final By backToLoginButton = id("recoveryCancel");
    private final String elementWithText = "//*[contains(text(), '%s')]";
    private final String inputField = "//input[@placeholder='%s']";

}