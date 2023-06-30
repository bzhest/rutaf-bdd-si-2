package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.KeyPrincipleFormPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.KeyPrincipleData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.PSA_ORDER_ID;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.*;
import static com.refinitiv.asts.test.ui.enums.KeyData.COUNTRY;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.DueDiligenceOrderPage.ADDRESS;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.apache.commons.lang3.StringUtils.isNotEmpty;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class KeyPrincipleFormPage extends BasePage<KeyPrincipleFormPage> {

    private final KeyPrincipleFormPO keyPrincipleFormPO;

    public KeyPrincipleFormPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        this.driver = driver;
        keyPrincipleFormPO = new KeyPrincipleFormPO(driver, translator);

    }

    @Override
    protected ExpectedCondition<KeyPrincipleFormPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    public void openDDOrderManageKeyPrincipalPage() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String orderId = (String) context.getScenarioContext().getContext(PSA_ORDER_ID);
        String url = URL + THIRD_PARTY + SLASH + thirdPartyId + DD_ORDER + orderId + MANAGE_KEY_PRINCIPAL;
        driver.get(url);
    }

    public String getAddFieldIndicator(String field) {
        return getElementText(xpath(format(keyPrincipleFormPO.getIndicator(), field)));
    }

    public String getAddressFieldIndicator(String field) {
        return getElementText(xpath(format(keyPrincipleFormPO.getAddressFieldIndicator(), field)));
    }

    public String getNote() {
        return getElementText(keyPrincipleFormPO.getNote());
    }

    public String getElementErrorMessage(String fieldName) {
        return getElementText(xpath(format(keyPrincipleFormPO.getFieldInputHelpText(), fieldName)));
    }

    public String getErrorMessageElementCSS(String fieldName, String cssAttribute) {
        return driver.findElement(xpath(format(keyPrincipleFormPO.getFieldInputHelpText(), fieldName)))
                .getCssValue(cssAttribute);
    }

    public List<KeyPrincipleData> getKeyPrincipleTableValues() {
        List<String> columnNames =
                driver.findElements(keyPrincipleFormPO.getKeyPrincipalTableColumns()).stream().map(WebElement::getText)
                        .collect(Collectors.toList());
        List<WebElement> rows = driver.findElements(keyPrincipleFormPO.getKeyPrincipleTableRows());
        return rows.stream()
                .map(row -> KeyPrincipleData.builder()
                        .isChecked(driver.findElement(
                                        xpath(format(keyPrincipleFormPO.getCheckbox(), rows.indexOf(row) + 1)))
                                           .getAttribute(CLASS).contains(CHECKED))
                        .title(getColumnValue(row, columnNames, TITLE.getName().toUpperCase()))
                        .firstName(getColumnValue(row, columnNames, FIRST_NAME.getName().toUpperCase()))
                        .lastName(getColumnValue(row, columnNames, LAST_NAME.getName().toUpperCase()))
                        .addressLine(getColumnValue(row, columnNames, ADDRESS.toUpperCase()))
                        .country(getColumnValue(row, columnNames, COUNTRY.getName())).build()
                ).collect(Collectors.toList());
    }

    private String getColumnValue(WebElement row, List<String> columnNames, String columnName) {
        int columnNameIndex = columnNames.indexOf(columnName) + 1;
        return columnNameIndex == 0 ? null :
                getRowChildElementText(row, xpath(format(keyPrincipleFormPO.getTableRowValue(), columnNameIndex)));
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, keyPrincipleFormPO.getKeyManagementPage());
    }

    @Override
    public void load() {

    }

    public void fillAllKeyPrincipleData(KeyPrincipleData data) {
        if (!isElementDisplayed(waitShort, keyPrincipleFormPO.getKeyManagementPage())) {
            logger.error("Key principle form is not loaded");
        }
        if (isNotEmpty(data.getTitle())) {
            fillInTitleWithValue(data.getTitle());
        }
        if (isNotEmpty(data.getEmail())) {
            fillInEmailWithValue(data.getEmail());
        }
        if (isNotEmpty(data.getLocalLanguageName())) {
            fillInLanguageNameWithValue(data.getLocalLanguageName());
        }
        if (isNotEmpty(data.getAddressLine())) {
            fillInAddressLineWithValue(data.getAddressLine());
        }
        if (isNotEmpty(data.getZip())) {
            fillInZipWithValue(data.getZip());
        }
        if (isNotEmpty(data.getCity())) {
            fillInCityWithValue(data.getCity());
        }
        if (isNotEmpty(data.getState())) {
            fillInStateWithValue(data.getState());
        }

        fillInFirstNameWithValue(data.getFirstName());
        fillInLastNameWithValue(data.getLastName());
        selectDropDownWithRetry(keyPrincipleFormPO.getCountryInput(), data.getCountry(),
                                keyPrincipleFormPO.getDropDownOption());
        clickAddButton();
    }

    public void clickAddButton() {
        clickOn(keyPrincipleFormPO.getAddButton(), waitShort);
    }

    public void acceptDialog() {
        if (isElementDisplayed(waitShort, keyPrincipleFormPO.getKeyManagementPage()) &&
                isElementDisplayed(waitShort, keyPrincipleFormPO.getAcceptDialogButton())) {
            clickOn(keyPrincipleFormPO.getAcceptDialogButton(), waitShort);
        }
    }

    public void clickOnButtonWithText(String buttonText) {
        clickOn(xpath(format(keyPrincipleFormPO.getButtonWithText(), buttonText.toLowerCase())), waitLong);
    }

    public void selectCountry(String country) {
        if (SPACE.equals(country)) {
            clearText(keyPrincipleFormPO.getCountryInput());
            clickOn(keyPrincipleFormPO.getCountryInput());
            clickOn(keyPrincipleFormPO.getBody());
        } else {
            clearInputAndEnterField(getElement(keyPrincipleFormPO.getCountryInput()), country);
        }
    }

    public void fillInFirstNameWithValue(String name) {
        clearAndInputField(waitLong.until(visibilityOfElementLocated(keyPrincipleFormPO.getFirstName())), name);
    }

    public void fillInLastNameWithValue(String lastName) {
        clearAndInputField(keyPrincipleFormPO.getLastName(), lastName);
    }

    public void fillInTitleWithValue(String title) {
        waitLong.until(visibilityOfElementLocated(keyPrincipleFormPO.getTitle()));
        clearAndInputField(keyPrincipleFormPO.getTitle(), title);
    }

    public void fillInEmailWithValue(String email) {
        clearAndInputField(keyPrincipleFormPO.getEmail(), email);
    }

    public void fillInLanguageNameWithValue(String languageName) {
        clearAndInputField(keyPrincipleFormPO.getLocalLanguageName(), languageName);
    }

    public void fillInAddressLineWithValue(String addressLine) {
        clearAndInputField(keyPrincipleFormPO.getAddressLine(), addressLine);
    }

    public void fillInZipWithValue(String zip) {
        clearAndInputField(keyPrincipleFormPO.getZip(), zip);
    }

    public void fillInCityWithValue(String city) {
        clearAndInputField(keyPrincipleFormPO.getCity(), city);
    }

    public void fillInStateWithValue(String state) {
        clearAndInputField(keyPrincipleFormPO.getState(), state);
    }

    public void clickAddToListButton() {
        clickOn(keyPrincipleFormPO.getAddToListButton(), waitLong);
    }

    public void clickEditButton(String firstName) {
        clickOn(xpath(format(keyPrincipleFormPO.getEditButton(), firstName)), waitShort);
    }

    public void clickCheckbox(String firstName) {
        clickOn(xpath(format(keyPrincipleFormPO.getRowCheckbox(), firstName)));
    }

    public boolean isAddInputFieldDisplayed(String name) {
        return isElementDisplayed(xpath(format(keyPrincipleFormPO.getFieldInput(), name)));
    }

    public boolean isAddressInputFieldDisplayed(String name) {
        return isElementDisplayed(xpath(format(keyPrincipleFormPO.getAddressField(), name)));
    }

    public boolean isFieldInvalidAriaDisplayed(String fieldName) {
        return !getAttributeValue(xpath(format(keyPrincipleFormPO.getFieldInput(), fieldName)), ARIA_INVALID)
                .equals(Boolean.toString(false));
    }

    public boolean isKeyPrincipalTableDisplayed() {
        return isElementDisplayed(xpath(keyPrincipleFormPO.getKeyPrincipalTable()));
    }

}
