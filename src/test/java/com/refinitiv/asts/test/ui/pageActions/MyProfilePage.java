package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.test.ui.enums.AddressFields;
import com.refinitiv.asts.test.ui.pageObjects.MyProfilePO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.CLASS;
import static com.refinitiv.asts.test.ui.constants.TestConstants.MUI_EXPANDED;
import static com.refinitiv.asts.test.ui.enums.AddressFields.*;
import static com.refinitiv.asts.test.ui.enums.ContactFields.*;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.*;
import static java.lang.String.format;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfAllElementsLocatedBy;

public class MyProfilePage extends BasePage<MyProfilePage> {

    private final MyProfilePO myProfilePO;

    public MyProfilePage(WebDriver driver) {
        super(driver);
        myProfilePO = new MyProfilePO(driver);
    }

    @Override
    protected ExpectedCondition<MyProfilePage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public String getProfileErrorMessage(String fieldName) {
        return getElementText(xpath(format(myProfilePO.getProfileErrorMessage(), fieldName)));
    }

    public String getProfileErrorMessageElementCSS(String fieldName, String cssValue) {
        return getElementByXPath(format(myProfilePO.getProfileErrorMessage(), fieldName)).getCssValue(cssValue);
    }

    public List<String> getTabNames() {
        return getElementsText(waitShort.until(visibilityOfAllElementsLocatedBy(myProfilePO.getTabs())));
    }

    public ThirdPartyData getCompanyInformationData() {
        return ThirdPartyData.builder()
                .referenceNo(getElementValue(xpath(format(myProfilePO.getFieldInput(), REFERENCE_NUMBER.getName()))))
                .name(getElementValue(xpath(format(myProfilePO.getFieldInput(), NAME.getName()))))
                .companyType(getElementValue(xpath(format(myProfilePO.getFieldInput(), COMPANY_TYPE.getName()))))
                .organisationSize(
                        getElementValue(xpath(format(myProfilePO.getFieldInput(), ORGANISATION_SIZE.getName()))))
                .dateOfIncorporation(
                        getElementValue(xpath(format(myProfilePO.getFieldInput(), DATE_OF_INCORPORATION.getName()))))
                .affiliation(getElementValue(xpath(format(myProfilePO.getFieldInput(), AFFILIATION.getName()))))
                .currency(getElementValue(xpath(format(myProfilePO.getFieldInput(), CURRENCY.getName()))))
                .industryType(getElementValue(xpath(format(myProfilePO.getFieldInput(), INDUSTRY_TYPE.getName()))))
                .businessCategory(
                        getElementValue(xpath(format(myProfilePO.getFieldInput(), BUSINESS_CATEGORY.getName()))))
                .revenue(getElementValue(xpath(format(myProfilePO.getFieldInput(), REVENUE.getName()))))
                .addressLine(
                        getElementValue(xpath(format(myProfilePO.getFieldInput(), ADDRESS_LINE.getName()))))
                .city(getElementValue(xpath(format(myProfilePO.getFieldInput(), CITY.getName()))))
                .stateProvince(getElementValue(
                        xpath(format(myProfilePO.getFieldInput(), STATE_PROVINCE.getName()))))
                .zipCode(getElementValue(xpath(format(myProfilePO.getFieldInput(), ZIP_POSTAL_CODE.getName()))))
                .region(getElementValue(xpath(format(myProfilePO.getFieldInput(), REGION.getName()))))
                .country(getElementValue(xpath(format(myProfilePO.getFieldInput(), AddressFields.COUNTRY.getName()))))
                .phoneNumber(getElementValue(xpath(format(myProfilePO.getFieldInput(), PHONE_NUMBER.getName()))))
                .fax(getElementValue(xpath(format(myProfilePO.getFieldInput(), FAX.getName()))))
                .website(getElementValue(xpath(format(myProfilePO.getFieldInput(), WEBSITE.getName()))))
                .emailAddress(getElementValue(xpath(format(myProfilePO.getFieldInput(), EMAIL_ADDRESS.getName()))))
                .build();
    }

    public List<String> getContactsColumnsNames() {
        return getElementsText(myProfilePO.getContactsColumnsNames());
    }

    public void clickMyProfileTab() {
        clickOn(myProfilePO.getMyProfileHeader());
    }

    public void clickMyProfileTab(String tabName) {
        clickOn(xpath(format(myProfilePO.getMyProfileTab(), tabName)), waitLong);
    }

    public void clickColumnName(String columnName) {
        clickOn(xpath(format(myProfilePO.getColumnName(), columnName)));
    }

    public void clickSectionArrow(String sectionName) {
        clickOn(xpath(format(myProfilePO.getUncollapseArrow(), sectionName)));
    }

    public boolean isOverviewFieldDisplayed(String sectionName, String field) {
        return isElementDisplayed(waitShort, xpath(format(myProfilePO.getSectionFieldValue(), sectionName, field)));
    }

    public boolean isInputSectionFieldEnabled(String sectionName, String field) {
        return getElementByXPath(format(myProfilePO.getSectionFieldInput(), sectionName, field)).isEnabled();
    }

    public boolean isSectionCollapsed(String sectionName) {
        return getAttributeValue(xpath(format(myProfilePO.getSection(), sectionName)), CLASS).contains(MUI_EXPANDED);
    }

    public boolean isProfileFieldInvalidAriaDisplayed(String fieldName) {
        return isElementDisplayed(xpath(format(myProfilePO.getProfileFieldInputError(), fieldName)));
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getContactsColumnsNames().indexOf(columnName) + 1;
        return getElementsTextsWithBlank(cssSelector(format(myProfilePO.getCellsWithIndex(), columnIndex)));
    }

}
