package com.refinitiv.asts.test.ui.pageActions.setUp;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.EmailManagementPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.EmailTemplate;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.Pages.EMAIL_MANAGEMENT;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;

public class EmailManagementPage extends BasePage<EmailManagementPage> {

    public static final String SUBJECT = "Subject";
    public static final String TEMPLATE_NAME = "Template Name";
    public static final String CATEGORY = "Category";
    public static final String STATUS = "Status";
    public static final String EMAIL_TEMPLATE_NAME = "Email Template Name";
    private final EmailManagementPO emailManagementPO;

    public EmailManagementPage(WebDriver driver) {
        super(driver);
        emailManagementPO = new EmailManagementPO(driver);
    }

    @Override
    protected ExpectedCondition<EmailManagementPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public String getInputFieldValue(String fieldName) {
        String attributeValue = getAttributeValue(xpath(format(emailManagementPO.getInputField(), fieldName)), VALUE);
        return isNull(attributeValue) ? StringUtils.EMPTY : attributeValue;
    }

    public List<EmailTemplate> getAllTemplateList() {
        return IntStream.rangeClosed(1, driver.findElements(emailManagementPO.getTableRow()).size())
                .mapToObj(this::getTemplateFullRowDetails).collect(Collectors.toList());
    }

    public EmailTemplate getTemplateFullRowDetails(int roleNo) {
        return EmailTemplate.builder()
                .templateName(getElementText(xpath(format(emailManagementPO.getRowTemplateName(), roleNo))))
                .category(getElementText(xpath(format(emailManagementPO.getRowCategory(), roleNo))))
                .status(getElementText(xpath(format(emailManagementPO.getRowStatus(), roleNo))))
                .build();
    }

    public List<String> getAllFieldNames() {
        return getElementsText(emailManagementPO.getTemplateFields());
    }

    public String getErrorMessageText(String fieldName) {
        return getElementText(xpath(format(emailManagementPO.getErrorMessage(), fieldName)));
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, emailManagementPO.getEmailNotificationTable());
    }

    public boolean isPageDisplayed(String templateName) {
        return isElementDisplayed(waitShort, xpath(format(emailManagementPO.getEmailTemplatePage(), templateName)));
    }

    public boolean isSaveButtonDisplayed() {
        return isElementDisplayed(emailManagementPO.getSaveTemplateButton());
    }

    public boolean isCancelButtonDisplayed() {
        return isElementDisplayed(emailManagementPO.getCancelTemplateButton());
    }

    public boolean isFieldReadOnly(String emailTemplateName) {
        return isElementAttributeContains(xpath(format(emailManagementPO.getInputField(), emailTemplateName)), CLASS,
                                          DISABLED);
    }

    public boolean isBoldTextDisplayed(String text) {
        return isElementDisplayed(xpath(format(emailManagementPO.getBoldText(), text)));
    }

    public boolean isItalicTextDisplayed(String text) {
        return isElementDisplayed(xpath(format(emailManagementPO.getItalicText(), text)));
    }

    public boolean isUnderlineTextDisplayed(String text) {
        return isElementDisplayed(xpath(format(emailManagementPO.getUnderlineText(), text)));
    }

    public boolean isTextAlignDisplayed(String text, String textAlign) {
        return isElementDisplayed(xpath(format(emailManagementPO.getTextParagraphAlign(), text, textAlign)));
    }

    public boolean isTableDisplayed() {
        return isElementDisplayed(emailManagementPO.getTable());
    }

    public boolean isLinkDisplayed(String linkText) {
        return isElementDisplayed(xpath(format(emailManagementPO.getLink(), linkText)));
    }

    public boolean isTextDisplayed(String variable) {
        return isElementDisplayed(xpath(format(emailManagementPO.getText(), variable)));
    }

    public boolean isActiveCheckboxChecked() {
        return isCheckboxChecked(emailManagementPO.getActiveCheckbox());
    }

    @Override
    public void load() {

    }

    public void navigatesToEmailManagementPage() {
        this.driver.get(URL + EMAIL_MANAGEMENT);
    }

    public void clickEditButton(String templateName) {
        clickOn(xpath(format(emailManagementPO.getEditRowButton(), templateName)));
    }

    public void inputFieldValue(String fieldName, String value) {
        fillInText(xpath(format(emailManagementPO.getInputField(), fieldName)), value);
    }

    public void inputEmailBodyValue(String value) {
        enterViaKeyboard(Keys.ENTER);
        fillInText(emailManagementPO.getEmailBody(), value);
    }

    public void clickEmailBodyParagraph() {
        clickOn(emailManagementPO.getEmailBodyParagraph());
    }

    public void clickTextStyleButton(String textStyle) {
        clickOn(cssSelector(format(emailManagementPO.getTextStyle(), textStyle)));
    }

    public void clickTextAlignButton(String textStyle) {
        clickOn(cssSelector(format(emailManagementPO.getTextAlign(), textStyle)));
    }

    public void clickInsertTableButton() {
        clickOn(emailManagementPO.getInsertTableButton());
    }

    public void clickSelectTableButton() {
        clickOn(emailManagementPO.getSelectTableButton());
    }

    public void clickSaveButton() {
        clickOn(emailManagementPO.getSaveTemplateButton());
    }

    public void clickCancelButton() {
        clickOn(emailManagementPO.getCancelTemplateButton());
    }

    public void clickInsertLinkButton() {
        clickOn(emailManagementPO.getInsertLinkButton());
    }

    public void fillInUrl(String url) {
        fillInText(emailManagementPO.getUrlInput(), url);
    }

    public void clickOkInsertUrl() {
        clickOn(emailManagementPO.getInsertUrlButton());
    }

    public String getBodyText() {
        return getElementText(emailManagementPO.getEmailBody());
    }

    public void clickActiveCheckbox() {
        clickOn(emailManagementPO.getActiveCheckbox());
    }

}
