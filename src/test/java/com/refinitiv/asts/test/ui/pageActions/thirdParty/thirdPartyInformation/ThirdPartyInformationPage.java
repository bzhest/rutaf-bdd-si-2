package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.google.common.base.Strings;
import com.mysql.jdbc.StringUtils;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.CustomFieldItem;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.enums.*;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.ThirdPartyPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DdOrdersData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.OnboardingActivityData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.apache.commons.lang.WordUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.BaseApi.ALL_ITEMS;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getCustomFields;
import static com.refinitiv.asts.test.ui.constants.APIConstants.ALL;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.ORDER_ID;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.NONE;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ActivityFields.TYPE;
import static com.refinitiv.asts.test.ui.enums.ActivityFields.*;
import static com.refinitiv.asts.test.ui.enums.AddressFields.COUNTRY;
import static com.refinitiv.asts.test.ui.enums.AddressFields.REGION;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.DIVISION;
import static com.refinitiv.asts.test.ui.enums.ThirdPartyInformationSectors.getThirdPartyInformationSection;
import static com.refinitiv.asts.test.ui.pageActions.setUp.CountryChecklistPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static java.util.stream.IntStream.range;
import static org.openqa.selenium.By.cssSelector;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ThirdPartyInformationPage extends BasePage<ThirdPartyInformationPage> {

    private final ThirdPartyPO thirdPartyPO;

    public ThirdPartyInformationPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        thirdPartyPO = new ThirdPartyPO(driver, translator);
    }

    @Override
    protected ExpectedCondition<ThirdPartyInformationPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return isElementDisplayed(waitLong, thirdPartyPO.getThirdPartyInformationTab()) ||
                isElementDisplayed(waitLong, thirdPartyPO.getActionButton());
    }

    @Override
    public void load() {

    }

    public void scrollToGeneralInformation() {
        scrollIntoView(driver.findElement(thirdPartyPO.getGeneralInfoSection()));
    }

    private int getSectionIndex(List<String> elementsList, String sectionText) {
        return elementsList.indexOf(sectionText);
    }

    public void clickOn(String elementName) {
        clickOn(getElementByName(elementName), waitLong);
    }

    public void clickWithJS(String elementName) {
        clickWithJS(waitLong.until(elementToBeClickable(getElementByName(elementName))));
    }

    public void waitAndClickOn(String elementName) {
        ExpectedCondition<Boolean> isEnabled = driver -> !driver.findElement(getElementByName(elementName))
                .getAttribute(CLASS).contains(DISABLED);
        waitShort.until(isEnabled);
        clickOn(elementName);
    }

    public boolean isButtonDisappeared(String buttonName) {
        return isElementDisappeared(waitMoment, xpath(format(thirdPartyPO.getButtonWithName(), buttonName)));
    }

    public boolean isElementVisible(String element) {
        return isElementDisplayed(waitShort, getElementByName(element));
    }

    public boolean isElementInvisible(String element) {
        return isElementInvisible(waitMoment, getElementByName(element));
    }

    public boolean isElementDisappeared(String element) {
        return isElementDisappeared(waitMoment, getElementByName(element));
    }

    public void clickSaveThirdPartyButton() {
        //Part from Selenium 4 for getting request body after clicking on 'Save' button
        driver = new Augmenter().augment(driver);
        DevTools devTool = ((HasDevTools) driver).getDevTools();
        devTool.createSession();
        devTool.send(Network.enable(Optional.empty(), Optional.empty(), Optional.empty()));
        devTool.addListener(Network.requestWillBeSent(), requestSent -> {

            System.out.println("Response Url => " + requestSent.getRequest().getUrl());
            System.out.println(
                    "Response Body => " + devTool.send(Network.getResponseBody(requestSent.getRequestId())).getBody());
            System.out.println("------------------------------------------------------");
        });

        clickWithJS(driver.findElement(thirdPartyPO.getSaveThirdPartyButton()));
    }

    public String getSectionTextColor(String section) {
        return getElement(xpath(format(thirdPartyPO.getSectionText(), section))).getCssValue(COLOR);
    }

    public void clickSaveAndNewButton() {
        clickOn(thirdPartyPO.getSaveAndNewButton(), waitShort);
    }

    public void clickDuplicateCheckConfirmButton() {
        clickOn(thirdPartyPO.getConfirmDuplicateCheckButton(), waitShort);
    }

    public void clickCancelButton() {
        clickOn(xpath(thirdPartyPO.getCancelBtn()), waitShort);
    }

    public void clickOnCreateOrderButton() {
        clickOn(thirdPartyPO.getCreateOrderButton(), waitLong);
    }

    public void openOrderWithStatus(String status) {
        By orderIdLocator = xpath(format(thirdPartyPO.getOrdersTableRowWithStatus(), status));
        context.getScenarioContext().setContext(ORDER_ID, getElementText(orderIdLocator));
        clickOn(orderIdLocator, waitShort);
    }

    public void hoverOverRiskRatingHelpIcon() {
        hoverOverElement(thirdPartyPO.getRiskRatingHelpIcon());
    }

    public String getRiskRatingHelpText() {
        return driver.findElement(thirdPartyPO.getRiskRatingHelpIcon()).getAttribute(TITLE_ATR);
    }

    public List<String> getDdOrdersTableHeaders() {
        return getElementsText(waitLong.until(numberOfElementsToBeMoreThan(thirdPartyPO.getDdOrdersTableHeader(), 0)));
    }

    public DdOrdersData getDdOrdersTable() {
        List<String> headers = getDdOrdersTableHeaders();
        scrollIntoView(waitLong.until(visibilityOfElementLocated(xpath(thirdPartyPO.getDdOrderSection()))));
        return new DdOrdersData().setOrders(
                waitShort.until(numberOfElementsToBeMoreThan(thirdPartyPO.getDdOrdersTableRow(), 0)).stream()
                        .map(row -> new DdOrdersData.DdOrder()
                                .setOrderId(getColumnValue(row, headers,
                                                           DdOrderFields.ORDER_ID.getName().toUpperCase()))
                                .setOrderType(getColumnValue(row, headers,
                                                             DdOrderFields.ORDER_TYPE.getName().toUpperCase()))
                                .setSubjectName(getColumnValue(row, headers,
                                                               DdOrderFields.SUBJECT_NAME.getName().toUpperCase()))
                                .setScope(getColumnValue(row, headers, DdOrderFields.SCOPE.getName().toUpperCase()))
                                .setStatus(
                                        getColumnValue(row, headers, DdOrderFields.STATUS.getName().toUpperCase()))
                                .setDueDate(getColumnValue(row, headers,
                                                           DdOrderFields.DUE_DATE.getName().toUpperCase()))
                                .setRiskRating(getColumnValue(row, headers,
                                                              DdOrderFields.RISK_RATING.getName().toUpperCase()))
                        ).collect(Collectors.toList()));
    }

    private String getColumnValue(WebElement row, List<String> columnNames, String columnName) {
        List<WebElement> cells = row.findElements(thirdPartyPO.getDdOrdersTableCell());
        int columnNameIndex = columnNames.indexOf(columnName);
        return columnNameIndex == -1 ? null : getElementText(cells.get(columnNameIndex));
    }

    public void sortDdOrders(String columnName) {
        clickOn(xpath(format(thirdPartyPO.getSortIcon(), columnName)));
    }

    public void clickComponentTab(String componentName) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        clickOn(
                waitShort.until(presenceOfElementLocated(
                        xpath(format(thirdPartyPO.getComponentTab(), componentName, componentName.toUpperCase())))));
    }

    public void clickActivity(String activityName) {
        waitLong.ignoring(StaleElementReferenceException.class)
                .until(driver -> {
                    clickOn(xpath(format(thirdPartyPO.getTableActivitiesRowName(), activityName)));
                    return true;
                });
    }

    public void clickEditActivity(String activityName) {
        waitLong.until(visibilityOfAllElementsLocatedBy(thirdPartyPO.getTableActivitiesRows()));
        moveToElementAndClick(
                driver.findElement(xpath(format(thirdPartyPO.getTableActivityEditButton(), activityName))));
    }

    public boolean isEditActivityButtonDisplayed(String activityName) {
        waitLong.until(visibilityOfAllElementsLocatedBy(thirdPartyPO.getTableActivitiesRows()));
        return isElementDisplayed(xpath(format(thirdPartyPO.getTableActivityEditButton(), activityName)));
    }

    public void clickInfoAddressIcon() {
        clickOn(thirdPartyPO.getAddressInfoIcons());
    }

    public boolean isSectionBeforeOtherSection(String beforeSection, String afterSection) {
        List<String> sectionList = getElementsText(thirdPartyPO.getThirdPartySectionsList());
        int beforeSectionIndex = getSectionIndex(sectionList, beforeSection);
        int afterSectionIndex = getSectionIndex(sectionList, afterSection);
        return afterSectionIndex - beforeSectionIndex == 1;
    }

    public boolean isAddContactSectionBeforeOtherSection(String beforeSection, String afterSection) {
        List<String> sectionList = getElementsText(thirdPartyPO.getSectionsList());
        int beforeSectionIndex = getSectionIndex(sectionList, beforeSection);
        int afterSectionIndex = getSectionIndex(sectionList, afterSection);
        return (afterSectionIndex - beforeSectionIndex) == 1;
    }

    public String getThirdPartyName() {
        return getElementText(waitShort, thirdPartyPO.getThirdPartyName());
    }

    public boolean isAddressAlertMessageInvisible() {
        return isElementInvisible(waitShort, thirdPartyPO.getAddressAlertMessages());
    }

    public boolean isAddressAlertMessageDisappeared() {
        waitShort.until(numberOfElementsToBe(thirdPartyPO.getAddressAlertMessages(), 0));
        return isElementDisplayed(thirdPartyPO.getAddressAlertMessages());
    }

    public boolean isDownloadIconIsDisplayed(String fileName) {
        return driver.findElement(xpath(format(thirdPartyPO.getDownloadIconForFile(), fileName))).isDisplayed();
    }

    public boolean isDeleteIconIsDisplayed(String fileName) {
        return driver.findElement(xpath(format(thirdPartyPO.getDeleteIconForFile(), fileName))).isDisplayed();
    }

    public boolean isBrowseButtonDisplayed() {
        return driver.findElement(thirdPartyPO.getBrowseButton()).isDisplayed();
    }

    public boolean isDescriptionInputDisplayed() {
        return isElementDisplayed(thirdPartyPO.getFileDescription());
    }

    public boolean isUploadFileButtonDisplayed() {
        return isElementDisplayed(thirdPartyPO.getUploadFileButton());
    }

    public boolean isCancelFileButtonDisplayed() {
        return isElementDisplayed(thirdPartyPO.getCancelFileButton());
    }

    public boolean isComponentDisplayed() {
        return isElementDisplayed(thirdPartyPO.getComponentOverview());
    }

    public boolean isOnboardingRenewalDisappeared() {
        return isElementDisappeared(waitMoment, thirdPartyPO.getOnboardingSection());
    }

    public boolean isOnboardingDateFieldDisappeared(String fieldName) {
        return isElementDisappeared(waitMoment, xpath(format(thirdPartyPO.getOnboardingDateField(), fieldName)));
    }

    public boolean isOnboardingDateDisplayed(String fieldName) {
        return isElementDisplayed(waitMoment, xpath(format(thirdPartyPO.getOnboardingDateField(), fieldName)));
    }

    public boolean isSectionNotEditable(By editButton) {
        if (!isElementDisplayed(editButton)) {
            return true;
        }
        return getElement(editButton).getAttribute(CLASS).contains(DISABLED) ||
                getElement(editButton).getAttribute(DATA_NG_CLASS).contains(DISABLED);
    }

    public boolean isGeneralInfoSectionNotEditable() {
        return isSectionNotEditable(thirdPartyPO.getEditGeneralAndOtherInfoButton());
    }

    public boolean areGeneralAndOtherInformationInnerSectionsDisplayed() {
        return isElementDisplayed(thirdPartyPO.getGeneralAndOtherInformationInnerSections());
    }

    public boolean isFieldInvalidAriaDisplayed(String fieldName) {
        return getAttributeValue(xpath(format(thirdPartyPO.getInputField(), fieldName)), ARIA_INVALID)
                .equals(Boolean.toString(true));
    }

    public boolean isAddressSectionFieldInvalidAriaDisplayed(String fieldName) {
        return driver.findElement(xpath(format(thirdPartyPO.getInputAddressSectionField(), fieldName)))
                .getAttribute(ARIA_INVALID)
                .equals(Boolean.toString(true));
    }

    public boolean isAddThirdPartyWindowDisplayed() {
        waitWhilePreloadProgressbarIsDisappeared();
        return isElementDisplayed(thirdPartyPO.getAddThirdPartyWindow());
    }

    public boolean isAddThirdPartyWindowButtonDisplayed(String buttonName) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getAddThirdPartyButton(), buttonName)));
    }

    public boolean isDuplicateCheckPopupDisplayed() {
        return isElementDisplayed(waitMoment, thirdPartyPO.getDuplicateCheckPopupTitle());
    }

    /**
     * =================================================================================================================
     * Retrieve third-party's profile details steps
     * =================================================================================================================
     */

    public ThirdPartyData getThirdPartyInformationDetails() {
        return new ThirdPartyData()
                .setReferenceNo(getGeneralInformationValue(GeneralInformationFields.REFERENCE_NO.getName()))
                .setName(getGeneralInformationValue(GeneralInformationFields.NAME.getName()))
                .setCompanyType(getGeneralInformationValue(GeneralInformationFields.COMPANY_TYPE.getName()))
                .setOrganisationSize(getGeneralInformationValue(GeneralInformationFields.ORGANISATION_SIZE.getName()))
                .setDateOfIncorporation(
                        getGeneralInformationValue(GeneralInformationFields.DATE_OF_INCORPORATION.getName()))
                .setResponsibleParty(getGeneralInformationValue(GeneralInformationFields.RESPONSIBLE_PARTY.getName()))
                .setDivision(getGeneralInformationValue(DIVISION.getName()))
                .setWorkflowGroup(getGeneralInformationValue(GeneralInformationFields.WORKFLOW_GROUP.getName()))
                .setCurrency(getGeneralInformationValue(GeneralInformationFields.CURRENCY.getName()))
                .setIndustryType(getGeneralInformationValue(GeneralInformationFields.INDUSTRY_TYPE.getName()))
                .setBusinessCategory(getGeneralInformationValue(GeneralInformationFields.BUSINESS_CATEGORY.getName()))
                .setRevenue(getGeneralInformationValue(GeneralInformationFields.REVENUE.getName()))
                .setLiquidationDate(getGeneralInformationValue(GeneralInformationFields.LIQUIDATION_DATE.getName()))
                .setAffiliation(getGeneralInformationValue(GeneralInformationFields.AFFILIATION.getName()))
                .setSpendCategory(getThirdPartySegmentationValue(ThirdPartySegmentationFields.SPEND_CATEGORY.getName()))
                .setDesignAgreement(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.DESIGN_AGREEMENT.getName()))
                .setRelationshipVisibility(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.RELATIONSHIP_VISIBILITY.getName()))
                .setCommodityType(getThirdPartySegmentationValue(ThirdPartySegmentationFields.COMMODITY_TYPE.getName()))
                .setSourcingMethod(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.SOURCING_METHOD.getName()))
                .setSourcingType(getThirdPartySegmentationValue(ThirdPartySegmentationFields.SOURCING_TYPE.getName()))
                .setProductImpact(getThirdPartySegmentationValue(ThirdPartySegmentationFields.PRODUCT_IMPACT.getName()))
                .setBankName(getBankDetailsValue(BankDetailsFields.BANK_NAME.getName(), 1))
                .setAccountNo(getBankDetailsValue(BankDetailsFields.ACCOUNT_NO.getName(), 1))
                .setBranchName(getBankDetailsValue(BankDetailsFields.BRANCH_NAME.getName(), 1))
                .setBankAddressLine(getBankDetailsValue(BankDetailsFields.ADDRESS_LINE.getName(), 1))
                .setBankCity(getBankDetailsValue(BankDetailsFields.CITY.getName(), 1))
                .setBankCountry(getBankDetailsValue(BankDetailsFields.COUNTRY.getName(), 1))
                .setAddressLine(getAddressDetailsValue(AddressFields.ADDRESS_LINE.getName()))
                .setCity(getAddressDetailsValue(AddressFields.CITY.getName()))
                .setZipCode(getAddressDetailsValue(AddressFields.ZIP_POSTAL_CODE.getName()))
                .setStateProvince(getAddressDetailsValue(AddressFields.STATE_PROVINCE.getName()))
                .setRegion(getAddressDetailsValue(REGION.getName()))
                .setCountry(getAddressDetailsValue(COUNTRY.getName()))
                .setPhoneNumber(getContactValue(ContactFields.PHONE_NUMBER.getName()))
                .setFax(getContactValue(ContactFields.FAX.getName()))
                .setWebsite(getContactValue(ContactFields.WEBSITE.getName()))
                .setEmailAddress(getContactValue(ContactFields.EMAIL_ADDRESS.getName()))
                .setDescription(getDescription());
    }

    public ThirdPartyData getGeneralInformationSectionDetails() {
        waitWhilePreloadProgressbarIsDisappeared();
        return new ThirdPartyData()
                .setReferenceNo(getGeneralInformationValue(GeneralInformationFields.REFERENCE_NO.getName()))
                .setName(getGeneralInformationValue(GeneralInformationFields.NAME.getName()))
                .setCompanyType(getGeneralInformationValue(GeneralInformationFields.COMPANY_TYPE.getName()))
                .setOrganisationSize(getGeneralInformationValue(GeneralInformationFields.ORGANISATION_SIZE.getName()))
                .setDateOfIncorporation(
                        getGeneralInformationValue(GeneralInformationFields.DATE_OF_INCORPORATION.getName()))
                .setResponsibleParty(getGeneralInformationValue(GeneralInformationFields.RESPONSIBLE_PARTY.getName()))
                .setDivision(getGeneralInformationValue(DIVISION.getName()))
                .setWorkflowGroup(getGeneralInformationValue(GeneralInformationFields.WORKFLOW_GROUP.getName()))
                .setCurrency(getGeneralInformationValue(GeneralInformationFields.CURRENCY.getName()))
                .setIndustryType(getGeneralInformationValue(GeneralInformationFields.INDUSTRY_TYPE.getName()))
                .setBusinessCategory(getGeneralInformationValue(GeneralInformationFields.BUSINESS_CATEGORY.getName()))
                .setRevenue(getGeneralInformationValue(GeneralInformationFields.REVENUE.getName()))
                .setLiquidationDate(getGeneralInformationValue(GeneralInformationFields.LIQUIDATION_DATE.getName()))
                .setAffiliation(getGeneralInformationValue(GeneralInformationFields.AFFILIATION.getName()));
    }

    public ThirdPartyData getThirdPartySegmentationSectionDetails() {
        waitWhilePreloadProgressbarIsDisappeared();
        return new ThirdPartyData()
                .setSpendCategory(getThirdPartySegmentationValue(ThirdPartySegmentationFields.SPEND_CATEGORY.getName()))
                .setDesignAgreement(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.DESIGN_AGREEMENT.getName()))
                .setRelationshipVisibility(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.RELATIONSHIP_VISIBILITY.getName()))
                .setCommodityType(getThirdPartySegmentationValue(ThirdPartySegmentationFields.COMMODITY_TYPE.getName()))
                .setSourcingMethod(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.SOURCING_METHOD.getName()))
                .setSourcingType(getThirdPartySegmentationValue(ThirdPartySegmentationFields.SOURCING_TYPE.getName()))
                .setProductImpact(
                        getThirdPartySegmentationValue(ThirdPartySegmentationFields.PRODUCT_IMPACT.getName()));
    }

    public List<ThirdPartyData> getBankSectionDetails() {
        return IntStream.rangeClosed(1, driver.findElements(
                        xpath(format(thirdPartyPO.getBankDetailsFields(), BankDetailsFields.BANK_NAME.getName()))).size())
                .mapToObj(i -> new ThirdPartyData().setBankName(
                                getBankDetailsValue(BankDetailsFields.BANK_NAME.getName(), i))
                        .setAccountNo(getBankDetailsValue(BankDetailsFields.ACCOUNT_NO.getName(), i))
                        .setBranchName(getBankDetailsValue(BankDetailsFields.BRANCH_NAME.getName(), i))
                        .setBankAddressLine(getBankDetailsValue(BankDetailsFields.ADDRESS_LINE.getName(), i))
                        .setBankCity(getBankDetailsValue(BankDetailsFields.CITY.getName(), i))
                        .setBankCountry(getBankDetailsValue(BankDetailsFields.COUNTRY.getName(), i))
                ).collect(Collectors.toList());
    }

    public ThirdPartyData getAddressSectionDetails() {
        waitWhilePreloadProgressbarIsDisappeared();
        expandSectionIfCollapsed(ADDRESS);
        return new ThirdPartyData().setAddressLine(getAddressDetailsValue(AddressFields.ADDRESS_LINE.getName()))
                .setCity(getAddressDetailsValue(AddressFields.CITY.getName()))
                .setZipCode(getAddressDetailsValue(AddressFields.ZIP_POSTAL_CODE.getName()))
                .setStateProvince(getAddressDetailsValue(AddressFields.STATE_PROVINCE.getName()))
                .setRegion(getAddressDetailsValue(REGION.getName()))
                .setCountry(getAddressDetailsValue(COUNTRY.getName()));
    }

    public ThirdPartyData getContactSectionDetails() {
        expandSectionIfCollapsed(CONTACT);
        return new ThirdPartyData().setPhoneNumber(getContactValue(ContactFields.PHONE_NUMBER.getName()))
                .setFax(getContactValue(ContactFields.FAX.getName()))
                .setWebsite(getContactValue(ContactFields.WEBSITE.getName()))
                .setEmailAddress(getContactValue(ContactFields.EMAIL_ADDRESS.getName()));
    }

    public ThirdPartyData getScreeningCriteriaSectionDetails() {
        return new ThirdPartyData().setSearchTerm(
                        getScreeningCriteriaValue(ScreeningCriteriaFields.SEARCH_TERM.getName()))
                .setCountryOfRegistration(
                        getScreeningCriteriaValue(ScreeningCriteriaFields.COUNTRY_OF_LOCATION.getName()));
    }

    public String getAddressDetailsValue(String fieldName) {
        expandSectionIfCollapsed(ADDRESS);
        By addressElementPath;
        if (fieldName.equals(REGION.getName()) || fieldName.equals(COUNTRY.getName())) {
            addressElementPath = xpath(format(thirdPartyPO.getAddressDetailsAlternativeFieldValue(), fieldName));
        } else {
            addressElementPath = xpath(format(thirdPartyPO.getAddressDetailsFieldValue(), fieldName));
        }
        String text = null;
        if (isElementDisplayed(addressElementPath)) {
            text = getElementText(addressElementPath);
        }
        return fieldName.equals(text) ? null : text;
    }

    public String getGeneralInformationValue(String fieldName) {
        expandSectionIfCollapsed(GENERAL_INFORMATION);
        WebElement textElement;
        if (fieldName.equals(DIVISION.getName())) {
            textElement = getElement(thirdPartyPO.getGeneralInformationDivisionValue());
        } else {
            try {
                textElement =
                        driver.findElement(xpath(format(thirdPartyPO.getGeneralInformationFieldValue(), fieldName)));
            } catch (NoSuchElementException exception) {
                textElement =
                        getElementByXPath(format(thirdPartyPO.getGeneralInformationDropdownFieldValue(), fieldName));
            }
        }
        String elementText = nonNull(textElement) ? getAttributeOrText(textElement, TITLE_ATR) : null;
        return Strings.isNullOrEmpty(elementText) || elementText.equals(fieldName) ? null : elementText;
    }

    public String getThirdPartySegmentationValue(String fieldName) {
        expandSectionIfCollapsed(THIRD_PARTY_SEGMENTATION);
        By segmentationField = xpath(format(thirdPartyPO.getThirdPartySegmentationFieldValue(), fieldName));
        return isElementDisplayed(segmentationField) ? getElementText(segmentationField) : null;
    }

    public String getBankDetailsValue(String fieldName, int bankPosition) {
        expandSectionIfCollapsed(THIRD_PARTY_BANK_DETAILS);
        WebElement textElement;
        if (fieldName.equals(BankDetailsFields.COUNTRY.getName())) {
            List<WebElement> countryValues = getElements(thirdPartyPO.getBankDetailsCountryValue());
            textElement = countryValues.isEmpty() ? null : countryValues.get(bankPosition - 1);
        } else {
            textElement =
                    getElements(format(thirdPartyPO.getBankDetailsFieldValue(), fieldName)).get(bankPosition - 1);
        }
        String elementText = getElementText(textElement);
        return StringUtils.isNullOrEmpty(elementText) || elementText.equals(fieldName) ? null : elementText;
    }

    public String getContactValue(String fieldName) {
        expandSectionIfCollapsed(CONTACT);
        WebElement textElement = driver.findElement(xpath(format(thirdPartyPO.getContactFieldValue(), fieldName)));
        String elementText = textElement.getText();
        return elementText.isEmpty() ? null : elementText;
    }

    public String getScreeningCriteriaValue(String fieldName) {
        WebElement textElement =
                driver.findElement(xpath(format(thirdPartyPO.getScreeningCriteriaFieldValue(), fieldName)));
        String elementText = textElement.getText();
        return elementText.isEmpty() ? null : elementText;
    }

    public String getDescription() {
        expandSectionIfCollapsed(DESCRIPTION);
        return getElementText((thirdPartyPO.getDescriptionInput()));
    }

    public boolean isAddressCountryAlertToastMessageDisplayed() {
        return isElementDisplayed(waitShort, thirdPartyPO.getAddressAlertMessages());
    }

    public List<String> getAddressCountryAlertToastMessage() {
        return getElementsText(waitShort.ignoring(StaleElementReferenceException.class)
                                       .until(visibilityOfAllElementsLocatedBy(
                                               thirdPartyPO.getAddressAlertMessages())));
    }

    public String getComponentTabCSS(String cssValue, String componentName) {
        return getCssValue(xpath(format(thirdPartyPO.getComponentTabText(), componentName)), cssValue);
    }

    public List<String> getTableRowsCSS(String cssValue, String expectedValue) {
        return waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfAllElementsLocatedBy(thirdPartyPO.getTableActivitiesRows())).stream()
                .map(element -> {
                    waitShort.until(attributeToBe(element, cssValue, expectedValue));
                    final String[] value = new String[1];
                    waitShort.ignoring(StaleElementReferenceException.class).until(driver -> {
                        value[0] = element.getCssValue(cssValue);
                        return true;
                    });
                    return value[0];
                }).collect(Collectors.toList());
    }

    public String getTableRowCSS(String activityName, String cssValue, String expectedValue) {
        waitWhilePreloadProgressbarIsDisappeared();
        waitShort.ignoring(StaleElementReferenceException.class)
                .until(visibilityOfAllElementsLocatedBy(thirdPartyPO.getTableActivitiesRows()));
        waitShort.until(attributeToBe(xpath(format(thirdPartyPO.getTableActivitiesRow(), activityName)), cssValue,
                                      expectedValue));
        return driver.findElement(xpath(format(thirdPartyPO.getTableActivitiesRow(), activityName)))
                .getCssValue(cssValue);
    }

    public List<String> getFileTableColumnNames() {
        scrollIntoBottomView(thirdPartyPO.getRelatedFilesSection());
        return getElementsText(driver.findElements(thirdPartyPO.getFileTableColumnNames()));
    }

    public List<Attachment> getFileTableRowValues() {
        waitLong.until(numberOfElementsToBeMoreThan(thirdPartyPO.getFileTableRowValues(), 0));
        List<Attachment> attachments = new ArrayList<>();
        List<WebElement> rows = getElements(thirdPartyPO.getFileTableRows());
        range(0, rows.size())
                .forEach(index ->
                                 attachments.add(new Attachment()
                                                         .setFilename(getElementText(rows.get(index).findElement(
                                                                 thirdPartyPO.getFileName())))
                                                         .setDescription(getElementText(rows.get(index).findElement(
                                                                 thirdPartyPO.getDescription())))
                                                         .setDateUploaded(getElementText(rows.get(index).findElement(
                                                                 thirdPartyPO.getUploadedDate())))));
        return attachments;
    }

    public String getElementErrorMessage(String fieldName) {
        return getElementText(xpath(format(thirdPartyPO.getInputFieldErrorMessage(), fieldName)));
    }

    public String getAddressSectionElementErrorMessage(String fieldName) {
        return getElementText(xpath(format(thirdPartyPO.getInputAddressSectionFieldErrorMessage(), fieldName)));
    }

    public String getErrorMessageElementCSS(String fieldName, String cssValue) {
        return driver.findElement(xpath(format(thirdPartyPO.getInputFieldErrorMessage(), fieldName)))
                .getCssValue(cssValue);
    }

    public String getAddressSectionErrorMessageElementCSS(String fieldName, String cssValue) {
        return driver.findElement(xpath(format(thirdPartyPO.getInputAddressSectionFieldErrorMessage(), fieldName)))
                .getCssValue(cssValue);
    }

    public String getElementColor(String element) {
        return getCssValue(getElementByName(element), BACKGROUND_COLOR);
    }

    /**
     * =================================================================================================================
     * Create third-party steps
     * =================================================================================================================
     */
    public void fillInGeneralInformationDetails(ThirdPartyData thirdPartyDataToEdit) {
        expandSectionIfCollapsed(GENERAL_INFORMATION);
        fillInReferenceNo(thirdPartyDataToEdit);
        fillInName(thirdPartyDataToEdit);
        selectCompanyType(thirdPartyDataToEdit);
        selectOrganisationSize(thirdPartyDataToEdit);
        fillInDateOfIncorporation(thirdPartyDataToEdit);
        selectResponsibleParty(thirdPartyDataToEdit);
        selectDivision(thirdPartyDataToEdit);
        selectWorkFlowGroup(thirdPartyDataToEdit);
        selectCurrency(thirdPartyDataToEdit);
        selectIndustryType(thirdPartyDataToEdit);
        selectBusinessCategory(thirdPartyDataToEdit);
        selectRevenue(thirdPartyDataToEdit);
        fillInLiquidationDate(thirdPartyDataToEdit);
        selectAffiliation(thirdPartyDataToEdit);
    }

    public void fillInThirdPartySegmentationDetails(ThirdPartyData thirdPartyTestData) {
        expandSectionIfCollapsed(THIRD_PARTY_SEGMENTATION);
        selectSpendCategory(thirdPartyTestData);
        selectDesignAgreement(thirdPartyTestData);
        selectRelationshipVisibility(thirdPartyTestData);
        selectCommodityType(thirdPartyTestData);
        selectSourcingMethod(thirdPartyTestData);
        selectSourcingType(thirdPartyTestData);
        selectProductImpact(thirdPartyTestData);
    }

    public void fillInBankDetails(ThirdPartyData thirdPartyTestData) {
        expandSectionIfCollapsed(THIRD_PARTY_BANK_DETAILS);
        fillInBankName(thirdPartyTestData);
        fillInAccountNo(thirdPartyTestData);
        fillInBranchName(thirdPartyTestData);
        fillInBankAddressLine(thirdPartyTestData);
        fillInBankCity(thirdPartyTestData);
        selectBankCountry(thirdPartyTestData.getBankCountry());
    }

    public void fillInAddressDetails(ThirdPartyData thirdPartyTestData) {
        expandSectionIfCollapsed(PageElementNames.ADDRESS);
        fillInAddressLine(thirdPartyTestData);
        fillInCity(thirdPartyTestData);
        fillInZipCode(thirdPartyTestData);
        fillInStateProvince(thirdPartyTestData);
        selectRegion(thirdPartyTestData.getRegion());
        selectThirdPartyAddressCountry(thirdPartyTestData.getCountry());
    }

    public void fillInContactDetails(ThirdPartyData thirdPartyTestData) {
        expandSectionIfCollapsed(CONTACT);
        fillInPhoneNumber(thirdPartyTestData);
        fillInFax(thirdPartyTestData);
        fillInWebsite(thirdPartyTestData);
        fillInEmailAddress(thirdPartyTestData);
    }

    public void fillInScreeningCriteria(String country) {
        clearAndFillInValueAndSelectFromDropDown(country, thirdPartyPO.getCountryOfRegistrationInput());
    }

    public void fillInPhoneNumber(String phoneNumber, String row) {
        expandSectionIfCollapsed(CONTACT);
        if (nonNull(phoneNumber)) {
            clearAndInputField(xpath(format(thirdPartyPO.getPhoneNumberInputByRow(), row)), phoneNumber);
        }
    }

    public void fillInDescription(String description) {
        expandSectionIfCollapsed(DESCRIPTION);
        if (nonNull(description)) {
            clearAndInputField(thirdPartyPO.getDescriptionInput(), description);
        }
    }

    public void selectThirdPartyAddressCountry(String countryName) {
        expandSectionIfCollapsed(PageElementNames.ADDRESS);
        if (nonNull(countryName)) {
            clearAndFillInValueAndSelectFromDropDown(countryName, thirdPartyPO.getAddressCountryInput());
        }
    }

    public void cleanDivisionField() {
        List<WebElement> divisions = driver.findElements(thirdPartyPO.getDivisionDeleteButtonList());
        for (int i = 0; i < divisions.size(); i++) {
            clickOn(thirdPartyPO.getFirstDivisionDeleteButton());
        }
    }

    public void fillInReferenceNo(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getReferenceNo())) {
            waitShort.until(visibilityOfElementLocated(thirdPartyPO.getReferenceNoInput()));
            clearAndInputField(thirdPartyPO.getReferenceNoInput(), thirdPartyTestData.getReferenceNo());
        }
    }

    private void fillInName(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getName())) {
            waitLong.until(visibilityOfElementLocated(thirdPartyPO.getNameThirdPartyField()));
            clearAndInputField(thirdPartyPO.getNameThirdPartyField(), thirdPartyTestData.getName());
        }
    }

    private void selectCompanyType(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getCompanyType())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getCompanyType(),
                                                     thirdPartyPO.getCompanyTypeInput());
        }
    }

    private void selectOrganisationSize(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getOrganisationSize())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getOrganisationSize(),
                                                     thirdPartyPO.getOrganisationSizeInput());
        }
    }

    private void fillInDateOfIncorporation(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getDateOfIncorporation()) &&
                thirdPartyTestData.getDateOfIncorporation().contains(TODAY_LABEL)) {
            clickOn(thirdPartyPO.getDateOfIncorporationButton());
            enterViaKeyboard(Keys.ENTER);
        } else if (nonNull(thirdPartyTestData.getDateOfIncorporation())) {
            String dateOfIncorporation = updateDayFormatForFillInForm(thirdPartyTestData.getDateOfIncorporation());
            driver.findElement(thirdPartyPO.getDateOfIncorporationInput()).sendKeys(dateOfIncorporation);
            enterViaKeyboard(Keys.ENTER);
        }
    }

    private void selectResponsibleParty(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getResponsibleParty())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getResponsibleParty(),
                                                     thirdPartyPO.getResponsiblePartyInput());
        }
    }

    private void selectDivision(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getDivision())) {
            cleanDivisionField();
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getDivision(),
                                                     thirdPartyPO.getDivisionInput());
        }
    }

    private void selectWorkFlowGroup(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getWorkflowGroup())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getWorkflowGroup(),
                                                     thirdPartyPO.getWorkflowGroup(), thirdPartyPO.getDropDownOption());
        }
    }

    private void selectCurrency(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getCurrency())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getCurrency(),
                                                     thirdPartyPO.getCurrencyInput());
        }
    }

    private void selectIndustryType(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getIndustryType())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getIndustryType(),
                                                     thirdPartyPO.getIndustryTypeInput());
        }
    }

    private void selectBusinessCategory(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getBusinessCategory())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getBusinessCategory(),
                                                     thirdPartyPO.getBusinessCategoryInput());
        }
    }

    private void selectRevenue(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getRevenue())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getRevenue(),
                                                     thirdPartyPO.getRevenueInput());
        }
    }

    private void fillInLiquidationDate(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getLiquidationDate()) &&
                thirdPartyTestData.getLiquidationDate().contains(TODAY_LABEL)) {
            clickOn(thirdPartyPO.getLiquidationDateButton());
            enterViaKeyboard(Keys.ENTER);
        } else if (nonNull(thirdPartyTestData.getLiquidationDate())) {
            String liquidationDate = updateDayFormatForFillInForm(thirdPartyTestData.getLiquidationDate());
            driver.findElement(thirdPartyPO.getLiquidationDateInput()).sendKeys(liquidationDate);
            enterViaKeyboard(Keys.ENTER);
        }
    }

    private void selectAffiliation(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getAffiliation())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getAffiliation(),
                                                     thirdPartyPO.getAffiliationInput());
        }
    }

    private void selectSpendCategory(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getSpendCategory())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getSpendCategory(),
                                                     thirdPartyPO.getSpendCategoryInput());
        }
    }

    private void selectDesignAgreement(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getDesignAgreement())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getDesignAgreement(),
                                                     thirdPartyPO.getDesignAgreementInput());
        }
    }

    private void selectRelationshipVisibility(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getRelationshipVisibility())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getRelationshipVisibility(),
                                                     thirdPartyPO.getRelationshipVisibilityInput());
        }
    }

    private void selectCommodityType(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getCommodityType())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getCommodityType(),
                                                     thirdPartyPO.getCommodityTypeInput());
        }
    }

    private void selectSourcingMethod(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getSourcingMethod())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getSourcingMethod(),
                                                     thirdPartyPO.getSourcingMethodInput());
        }
    }

    private void selectSourcingType(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getSourcingType())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getSourcingType(),
                                                     thirdPartyPO.getSourcingTypeInput());
        }
    }

    private void selectProductImpact(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getProductImpact())) {
            clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getProductImpact(),
                                                     thirdPartyPO.getProductImpactInput());
        }
    }

    private void fillInBankName(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getBankName())) {
            driver.findElement(thirdPartyPO.getBankNameInput()).sendKeys(thirdPartyTestData.getBankName());
        }
    }

    private void fillInAccountNo(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getAccountNo())) {
            driver.findElement(thirdPartyPO.getAccountNoInput()).sendKeys(thirdPartyTestData.getAccountNo());
        }
    }

    private void fillInBranchName(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getBranchName())) {
            driver.findElement(thirdPartyPO.getBranchNameInput()).sendKeys(thirdPartyTestData.getBranchName());
        }
    }

    private void fillInBankAddressLine(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getBankAddressLine())) {
            driver.findElement(thirdPartyPO.getBankAddressLineInput())
                    .sendKeys(thirdPartyTestData.getBankAddressLine());
        }
    }

    private void fillInBankCity(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getBankCity())) {
            driver.findElement(thirdPartyPO.getBankCityInput()).sendKeys(thirdPartyTestData.getBankCity());
        }
    }

    public void selectBankCountry(String countryName) {
        if (nonNull(countryName)) {
            expandSectionIfCollapsed(THIRD_PARTY_BANK_DETAILS);
            clearAndFillInValueAndSelectFromDropDown(countryName, thirdPartyPO.getBankCountryInput());
        }
    }

    private void fillInAddressLine(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getAddressLine())
                && !thirdPartyTestData.getAddressLine().isEmpty()) {
            driver.findElement(thirdPartyPO.getAddressLine()).sendKeys(thirdPartyTestData.getAddressLine());
        }
    }

    private void fillInCity(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getCity())
                && !thirdPartyTestData.getCity().isEmpty()) {
            driver.findElement(thirdPartyPO.getCity()).sendKeys(thirdPartyTestData.getCity());
        }
    }

    private void fillInZipCode(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getZipCode())
                && !thirdPartyTestData.getZipCode().isEmpty()) {
            driver.findElement(thirdPartyPO.getZipCode()).sendKeys(thirdPartyTestData.getZipCode());
        }
    }

    private void fillInStateProvince(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getStateProvince())
                && !thirdPartyTestData.getStateProvince().isEmpty()) {
            driver.findElement(thirdPartyPO.getStateProvince()).sendKeys(thirdPartyTestData.getStateProvince());
        }
    }

    public void selectRegion(String region) {
        if (nonNull(region)) {
            clearAndFillInValueAndSelectFromDropDown(region, thirdPartyPO.getRegionInput(),
                                                     thirdPartyPO.getDropDownOption());
            waitWhileSeveralPreloadProgressBarsAreDisappeared();
        }
    }

    private void fillInPhoneNumber(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getPhoneNumber())) {
            driver.findElement(thirdPartyPO.getPhoneNumberInput()).sendKeys(thirdPartyTestData.getPhoneNumber());
        }
    }

    private void fillInFax(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getFax())) {
            driver.findElement(thirdPartyPO.getFaxInput()).sendKeys(thirdPartyTestData.getFax());
        }
    }

    private void fillInWebsite(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getWebsite())) {
            driver.findElement(thirdPartyPO.getWebsiteInput()).sendKeys(thirdPartyTestData.getWebsite());
        }
    }

    private void fillInEmailAddress(ThirdPartyData thirdPartyTestData) {
        if (nonNull(thirdPartyTestData.getEmailAddress())) {
            driver.findElement(thirdPartyPO.getEmailInput()).sendKeys(thirdPartyTestData.getEmailAddress());
        }
    }

    public void expandSectionIfCollapsed(String sectionName) {
        if (isSectionDisplayed(sectionName)) {
            WebElement section = getThirdPartySection(sectionName);
            scrollIntoView(section);
            if (!isElementAttributeContains(section, CLASS, MUI_EXPANDED)) {
                clickOn(section);
            }
        }
    }

    public void collapseSection(String sectionName) {
        WebElement section = getThirdPartySection(sectionName);
        scrollIntoView(section);
        if (isElementAttributeContains(section, CLASS, MUI_EXPANDED)) {
            clickOn(section.findElement(thirdPartyPO.getChild()));
        }
    }

    public boolean isSectionExpanded(String sectionName) {
        WebElement section = getThirdPartySection(sectionName);
        scrollIntoView(section);
        return isElementAttributeContains(section, CLASS, MUI_EXPANDED);
    }

    public boolean isSectionDisplayed(String sectionName) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getSection(), getAdaptedSectionName(sectionName))));
    }

    private String getAdaptedSectionName(String sectionName) {
        String[] nameParts = sectionName.split("( |-)");
        StringBuilder sectionTranslatorKey = new StringBuilder("thirdPartyInformation." + nameParts[0].toLowerCase());
        for (int i = 1; i < nameParts.length; i++) {
            sectionTranslatorKey.append(WordUtils.capitalizeFully(nameParts[i]));
        }
        if (!translator.getValue(sectionTranslatorKey.toString()).contains(NOT_EXIST)) {
            sectionName = translator.getValue(sectionTranslatorKey.toString());
        }
        return sectionName;
    }

    private WebElement getThirdPartySection(String sectionName) {
        return waitShort.until(visibilityOfElementLocated(
                xpath(format(thirdPartyPO.getSection(), getAdaptedSectionName(sectionName)))));
    }

    /**
     * =================================================================================================================
     * Edit third-party's profile steps
     * =================================================================================================================
     */

    public void fillInRenewalCycle(String value) {
        clearInputAndEnterField(
                waitMoment.until(visibilityOfElementLocated(thirdPartyPO.getAssessmentDetailsRenewalCycle())), value);
    }

    public boolean isRenewalCycleReadonly() {
        String readOnly = getAttributeValue(thirdPartyPO.getAssessmentDetailsRenewalCycle(), READONLY);
        return Boolean.parseBoolean(readOnly);
    }

    public void fillInProfileEditBankDetails(ThirdPartyData thirdPartyTestData, int bankPosition) {
        expandSectionIfCollapsed(THIRD_PARTY_BANK_DETAILS);
        fillInProfileEditBankName(thirdPartyTestData, bankPosition);
        fillInProfileEditAccountNo(thirdPartyTestData, bankPosition);
        fillInProfileEditBranchName(thirdPartyTestData, bankPosition);
        fillInProfileEditBankAddressLine(thirdPartyTestData, bankPosition);
        fillInProfileEditBankCity(thirdPartyTestData, bankPosition);
        selectProfileEditBankCountry(thirdPartyTestData, bankPosition);
    }

    private void fillInProfileEditBankName(ThirdPartyData thirdPartyTestData, int bankPosition) {
        if (nonNull(thirdPartyTestData.getBankName())) {
            WebElement bankNameInput = getElements(thirdPartyPO.getBankNameInput()).get(bankPosition - 1);
            clearAndInputField(bankNameInput, thirdPartyTestData.getBankName());
        }
    }

    private void fillInProfileEditAccountNo(ThirdPartyData thirdPartyTestData, int bankPosition) {
        if (nonNull(thirdPartyTestData.getAccountNo())) {
            WebElement accountNoInput = getElements(thirdPartyPO.getAccountNoInput()).get(bankPosition - 1);
            clearAndInputField(accountNoInput, thirdPartyTestData.getAccountNo());
        }
    }

    private void fillInProfileEditBranchName(ThirdPartyData thirdPartyTestData, int bankPosition) {
        if (nonNull(thirdPartyTestData.getBranchName())) {
            WebElement branchNameInput =
                    getElements(thirdPartyPO.getBranchNameInput()).get(bankPosition - 1);
            clearAndInputField(branchNameInput, thirdPartyTestData.getBranchName());
        }
    }

    private void fillInProfileEditBankAddressLine(ThirdPartyData thirdPartyTestData, int bankPosition) {
        if (nonNull(thirdPartyTestData.getBankAddressLine())) {
            WebElement addressLineInput =
                    getElements(thirdPartyPO.getBankAddressLineInput()).get(bankPosition - 1);
            clearAndInputField(addressLineInput, thirdPartyTestData.getBankAddressLine());
        }
    }

    private void fillInProfileEditBankCity(ThirdPartyData thirdPartyTestData, int bankPosition) {
        if (nonNull(thirdPartyTestData.getBankCity())) {
            WebElement bankCityInput = getElements(thirdPartyPO.getBankCityInput()).get(bankPosition - 1);
            clearAndInputField(bankCityInput, thirdPartyTestData.getBankCity());
        }
    }

    private void selectProfileEditBankCountry(ThirdPartyData thirdPartyTestData, int bankPosition) {
        WebElement bankCountryInput = getElements(thirdPartyPO.getProfileEditBankCountryInput()).get(bankPosition - 1);
        moveToElement(bankCountryInput);
        clearAndFillInValueAndSelectFromDropDown(thirdPartyTestData.getBankCountry(), bankCountryInput);
    }

    public void clickGeneralInformationSectionSaveButton() {
        clickOn(thirdPartyPO.getSaveGeneralAndOtherInfoButton(), waitShort);
    }

    public void clickGeneralInformationSectionEditButton() {
        scrollToGeneralInformation();
        clickOn(thirdPartyPO.getEditGeneralAndOtherInfoButton(), waitShort);
    }

    public void clickGeneralInformationSectionCancelButton() {
        scrollToGeneralInformation();
        clickOn(thirdPartyPO.getCancelGeneralAndOtherInfoButton(), waitShort);
    }

    public void clickBankDetailsSectionAddButton() {
        clickOn(thirdPartyPO.getAddBankDetailsButton(), waitShort);
    }

    public void clickAssessmentDetailsSaveButton() {
        clickOn(thirdPartyPO.getAssessmentDetailsSaveButton(), waitShort);
    }

    public void clickThirdPartyInformationTab() {
        clickOn(thirdPartyPO.getThirdPartyInformationTab());
    }

    public void fillInCustomField(String customFieldName, String customFieldValue) {
        clearAndInputField(xpath(format(thirdPartyPO.getOtherInformationInputField(), customFieldName)),
                           customFieldValue);
    }

    public void selectCustomFieldOption(String customFieldName, String customFieldValue) {
        clearAndFillInValueAndSelectFromDropDown(customFieldValue,
                                                 xpath(format(thirdPartyPO.getOtherInformationInputField(),
                                                              customFieldName)),
                                                 thirdPartyPO.getDropDownFirstOption());
    }

    public void selectCustomFieldOptionWithoutClearing(String customFieldName, String customFieldValue) {
        fillInValueAndSelectFromDropDown(customFieldValue,
                                         xpath(format(thirdPartyPO.getOtherInformationInputField(),
                                                      customFieldName)),
                                         thirdPartyPO.getDropDownFirstOption());
    }

    public boolean isCustomFieldDisplayed(String customFieldName, String pageState) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (VIEW.equalsIgnoreCase(pageState)) {
            return isElementDisplayed(waitMoment,
                                      xpath(format(thirdPartyPO.getOtherInformationViewField(), customFieldName)));
        } else {
            return isElementDisplayed(waitMoment,
                                      xpath(format(thirdPartyPO.getOtherInformationInputField(), customFieldName)));

        }
    }

    public boolean isCustomFieldRequired(String customFieldName, String pageState) {
        if (VIEW.equalsIgnoreCase(pageState)) {
            return isAttributePresent(xpath(format(thirdPartyPO.getOtherInformationViewField(), customFieldName)),
                                      REQUIRED);
        } else {
            return isAttributePresent(xpath(format(thirdPartyPO.getOtherInformationInputField(), customFieldName)),
                                      REQUIRED);

        }
    }

    public void uploadFile(String fileName) {
        String path = getFilePath(fileName);
        driver.findElement(thirdPartyPO.getUploadFileInput()).sendKeys(path);
    }

    public void addModalDescription(String description) {
        clearAndInputField(thirdPartyPO.getAttachmentDescription(), description);
    }

    public boolean isAssessmentDetailsSaveButtonDisplayed() {
        return isElementDisplayedNow(thirdPartyPO.getAssessmentDetailsSaveButton());
    }

    public boolean isAssessmentDetailsCancelButtonDisplayed() {
        return isElementDisplayedNow(thirdPartyPO.getAssessmentDetailsCancelButton());
    }

    public boolean isGeneralInformationSaveButtonDisplayed() {
        return isElementDisplayedNow(thirdPartyPO.getSaveGeneralAndOtherInfoButton());
    }

    public boolean isGeneralInformationSaveButtonEnabled() {
        return !getAttributeValue(thirdPartyPO.getSaveGeneralAndOtherInfoButton(), CLASS).contains(DISABLED);
    }

    public boolean isGeneralInformationCancelButtonEnabled() {
        return !getAttributeValue(thirdPartyPO.getCancelGeneralAndOtherInfoButton(), CLASS).contains(DISABLED);
    }

    public boolean isGeneralInformationCancelButtonDisplayed() {
        return isElementDisplayedNow(thirdPartyPO.getCancelGeneralAndOtherInfoButton());
    }

    public void clickAssessmentDetailsEditButton() {
        clickOn(thirdPartyPO.getAssessmentDetailsEditButton(), waitShort);
    }

    public void clickAssessmentDetailsCancelButton() {
        clickOn(thirdPartyPO.getAssessmentDetailsCancelButton(), waitShort);
    }

    public void clickOnCollapseElapseButton(String sectionName) {
        clickOn(xpath(format(thirdPartyPO.getCollapseElapseButton(), sectionName)));
    }

    /**
     * =================================================================================================================
     * third-party's profile single checks
     * =================================================================================================================
     */

    public boolean isCustomFieldDisplayedInOtherInfoSection(String name) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getOtherInformationFields(), name)));
    }

    public void clickUploadFileButton() {
        clickOn(thirdPartyPO.getUploadFileButton(), waitShort);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void clickBrowseFileButton() {
        clickOn(thirdPartyPO.getBrowseButton(), waitShort);
    }

    public void fillInFileDescription(String description) {
        driver.findElement(thirdPartyPO.getFileDescription()).sendKeys(description);
    }

    public void clickCloseActivityOverview() {
        clickOn(thirdPartyPO.getCloseActivityOverviewButton());
    }

    public void clickRemoveBankButton(int bankPosition) {
        clickOn(xpath(format(thirdPartyPO.getRemoveBankDetailsButton(), bankPosition)));
    }

    public void clickDeleteDivisionButton(String divisionName) {
        clickOn(xpath(format(thirdPartyPO.getDivisionDeleteButton(), divisionName)));
    }

    private By getElementByName(String elementName) {
        switch (elementName) {
            case ASSOCIATED_PARTIES_TAB:
                return thirdPartyPO.getAssociatedPartiesTab();
            case START_ONBOARDING_BUTTON:
                return thirdPartyPO.getStartOnboardingButton();
            case DECLINE_ONBOARDING_BUTTON:
                return thirdPartyPO.getDeclineOnboardingButton();
            case STOP_ONBOARDING:
                return thirdPartyPO.getStopOnboardingButton();
            case OFFBOARD_BUTTON:
                return thirdPartyPO.getOffboardButton();
            case THIRD_PARTY_OVERVIEW:
                return thirdPartyPO.getThirdPartyOverviewButton();
            case ADVANCED_SEARCH:
                return thirdPartyPO.getAdvancedSearchBackButton();
            case THIRD_PARTY:
                return thirdPartyPO.getThirdPartyButton();
            case THIRD_PARTY_INFORMATION_TAB:
                return thirdPartyPO.getThirdPartyInformationTab();
            case QUESTIONNAIRE_TAB:
                return thirdPartyPO.getThirdPartyQuestionnaireTab();
            case RISK_MANAGEMENT_TAB:
                return thirdPartyPO.getThirdPartyRiskManagementTab();
            case DATA_PROVIDERS_TAB:
                return thirdPartyPO.getDataProvidersTab();
            case RENEW_BUTTON:
                return thirdPartyPO.getRenewButton();
            case DECLINE_RENEWAL_BUTTON:
                return thirdPartyPO.getDeclineRenewalButton();
            case STOP_RENEWAL_BUTTON:
                return thirdPartyPO.getStopRenewalButton();
            case BACK_BUTTON:
                return thirdPartyPO.getBackButton();
            case SCREENING:
                return thirdPartyPO.getScreeningTab();
            default:
                throw new RuntimeException("Unsupported web element " + elementName);
        }
    }

    public String getOnboardingDate(String fieldName) {
        scrollIntoView(xpath(format(thirdPartyPO.getOnboardingDate(), fieldName)));
        return getElementText(xpath(format(thirdPartyPO.getOnboardingDate(), fieldName)));
    }

    public String getThirdPartyOnboardingWorkflow() {
        return getElementText(waitLong.until(visibilityOfElementLocated(thirdPartyPO.getRelatedWorkflowName())));
    }

    public String getAssessmentDetailsSectionText() {
        return getElementText(thirdPartyPO.getAssessmentDetailsSection());
    }

    public String getThirdPartyOnboardingWorkflowDescription() {
        return getElementText(thirdPartyPO.getRelatedWorkflowDescription());
    }

    public String getThirdPartyStatus(String expectedText) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        waitLong.until(textToBePresentInElement(
                waitLong.until(visibilityOfElementLocated(thirdPartyPO.getThirdPartyStatus())), expectedText));
        return getElementText(thirdPartyPO.getThirdPartyStatus());
    }

    public String getThirdPartyStatus() {
        waitShort.until(textMatches(thirdPartyPO.getThirdPartyStatus(), Pattern.compile(NON_EMPTY_TEXT_REGEX)));
        return getElementText(thirdPartyPO.getThirdPartyStatus());
    }

    public String getThirdPartyStatusField() {
        waitWhilePreloadProgressbarIsDisappeared();
        return getElementText(waitShort.until(visibilityOfElementLocated(thirdPartyPO.getThirdPartyStatusField())));
    }

    public List<String> getActivityTableColumns() {
        return getElementsText(thirdPartyPO.getTableActivitiesColumns());
    }

    public OnboardingActivityData getActivityRowByActivityName(String activityName) {
        return getActivityTableRows().stream().filter(activity -> activity.getName().equals(activityName))
                .findFirst()
                .orElse(null);
    }

    public List<OnboardingActivityData> getActivityTableRows() {
        waitWhilePreloadProgressbarIsDisappeared();
        List<WebElement> tableActivitiesRows =
                waitShort.until(visibilityOfAllElementsLocatedBy(thirdPartyPO.getTableActivitiesRows()));
        return IntStream.rangeClosed(1, tableActivitiesRows.size())
                .mapToObj(
                        i -> new OnboardingActivityData().setName(getActivityRowValue(i, ActivityFields.NAME.getName()))
                                .setType(getActivityRowValue(i, TYPE.getName()))
                                .setAssignedTo(getActivityRowValue(i, ASSIGNED_TO.getName()))
                                .setDueDate(getActivityRowValue(i, DUE_DATE.getName()))
                                .setStatus(getActivityRowValue(i, ActivityFields.STATUS.getName())))
                .collect(Collectors.toList());
    }

    private String getActivityRowValue(int rowIndex, String rowName) {
        List<String> headers = getActivityTableColumns();
        int headerIndex = headers.indexOf(rowName.toUpperCase()) + 1;
        return getElementText(cssSelector(format(thirdPartyPO.getTableActivitiesRowValue(), rowIndex, headerIndex)));
    }

    public String getTooltipText(String componentName) {
        By component = xpath(format(thirdPartyPO.getComponentTab(), componentName, componentName.toUpperCase()));
        hoverOverElement(component);
        hoverOverElement(thirdPartyPO.getStopOnboardingButton());
        String text = getAttributeValue(component, TITLE_ATR);
        if (Objects.isNull(text)) {
            hoverOverElement(component);
            text = getTooltipText();
        }
        return text;
    }

    public List<String> getCurrenciesList() {
        clickOn(thirdPartyPO.getCurrencyInput());
        return getDropDownOptions(thirdPartyPO.getDropDownOptions());
    }

    public List<String> getCountryList() {
        clickOn(thirdPartyPO.getAddressCountryInput());
        return getDropDownOptions(thirdPartyPO.getDropDownOptions());
    }

    public List<String> getDropDownList(String dropDownName) {
        clickOn(xpath(format(thirdPartyPO.getDropdownInput() + thirdPartyPO.getParent(), dropDownName)));
        return getDropDownOptions(thirdPartyPO.getDropDownOptions());
    }

    public List<String> getDivisionDropDownList(boolean areDisabled) {
        expandSectionIfCollapsed(GENERAL_INFORMATION);
        clickOn(thirdPartyPO.getDivisionInput());
        List<String> divisionsList = getDropDownOptions(thirdPartyPO.getDropDownOptions(), areDisabled);
        clickOn(thirdPartyPO.getBody());
        return divisionsList;
    }

    public List<String> getSelectedDivisionList() {
        return getElementsText(driver.findElements(thirdPartyPO.getSelectedDivisions()));
    }

    public String getRenewalCycle() {
        return getElementText(xpath(format(thirdPartyPO.getAssessmentViewField(), RENEWAL_CYCLE)));
    }

    public String getCustomFieldValue(String customFieldName) {
        String value = getElementText(xpath(format(thirdPartyPO.getOtherInformationFieldValue(), customFieldName)));
        return org.apache.commons.lang3.StringUtils.equals(customFieldName, value) ? null : value;
    }

    public void clickAssessmentEditButton() {
        clickWithJS(driver.findElement(thirdPartyPO.getAssessmentDetailsEditButton()));
    }

    public void fillRenewalCurrentDate() {
        String currentDate = getTodayDate(REACT_FORMAT);
        driver.findElement(thirdPartyPO.getAssessmentDetailsNextRenewalDate()).sendKeys(currentDate);
    }

    public void fillRenewalCycle(String renewalDaysNumber) {
        WebElement renewalCycle = getElement(thirdPartyPO.getAssessmentDetailsRenewalCycle());
        renewalCycle.clear();
        renewalCycle.sendKeys(renewalDaysNumber);
    }

    public void clickAssessmentSaveButton() {
        clickOn(thirdPartyPO.getAssessmentDetailsSaveButton());
    }

    public boolean isButtonPresent(String buttonName) {
        return isElementDisplayed(waitMoment, xpath(format(thirdPartyPO.getButtonWithName(), buttonName)));
    }

    public boolean isButtonActive(String buttonName) {
        return isElementEnabled(xpath(format(thirdPartyPO.getButtonWithName(), buttonName)));
    }

    public boolean isAssessmentDetailsFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getAssessmentDetailsFields(), field)));
    }

    public boolean isGeneralInformationFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getGeneralInformationFields(), field)));
    }

    public boolean isThirdPartySegmentationFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getThirdPartySegmentationFields(), field)));
    }

    public boolean isOtherInformationFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getOtherInformationFields(), field)));
    }

    public boolean isBankDetailsFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getBankDetailsFields(), field)));
    }

    public boolean isAddressFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getAddressViewField(), field)));
    }

    public boolean isContactFieldDisplayed(String field) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getContactFields(), field)));
    }

    public String getDescriptionValueText() {
        return getElementText(thirdPartyPO.getDescriptionInput());
    }

    public boolean isCountryOfRegistrationDisplayed(String country) {
        By countryLocator =
                xpath(format(thirdPartyPO.getCountryOfRegistrationValue(), country));
        waitLong.until(visibilityOfElementLocated(countryLocator));
        return isElementDisplayedNow(countryLocator);
    }

    public void updateSearchTermValue(String currentValue, String newValue) {
        WebElement columnElement = getElementByXPath(format(thirdPartyPO.getSearchTermInput(), currentValue));
        clickOn(columnElement);
        clearText(columnElement);
        columnElement.sendKeys(newValue);
    }

    public boolean isSearchTermValueDisplayed(String searchTerm) {
        By searchTermLocator =
                xpath(format(thirdPartyPO.getSearchTermInput(), searchTerm));
        waitLong.until(visibilityOfElementLocated(searchTermLocator));
        return isElementDisplayedNow(searchTermLocator);
    }

    public void clickSameAsAddressCountryCheckbox() {
        clickOn(thirdPartyPO.getSameAsAddressCountryCheckbox());
    }

    public void clickAddPhoneNumber() {
        clickOn(thirdPartyPO.getAddPhoneNumber());
    }

    public boolean isCountryValueDisplayed(String country) {
        By countryLocator = thirdPartyPO.getCountryOfRegistrationInput();
        waitLong.until(visibilityOfElementLocated(countryLocator));
        return getElement(countryLocator).getAttribute(VALUE).equals(country);
    }

    public boolean isScreeningCriteriaSectionFieldInvalidAriaDisplayed(String fieldName) {
        return driver.findElement(xpath(format(thirdPartyPO.getInputScreeningCriteriaSectionField(), fieldName)))
                .getAttribute(ARIA_INVALID)
                .equals(Boolean.toString(true));
    }

    public String getScreeningCriteriaSectionElementErrorMessage(String fieldName) {
        return getElementText(
                xpath(format(thirdPartyPO.getInputScreeningCriteriaSectionFieldErrorMessage(), fieldName)));
    }

    public String getScreeningCriteriaSectionErrorMessageColor(String fieldName, String color) {
        return driver.findElement(
                        xpath(format(thirdPartyPO.getInputScreeningCriteriaSectionFieldErrorMessage(), fieldName)))
                .getCssValue(color);
    }

    public boolean isSectionBeforeOtherSectionOnAddThirdParty(String beforeSection, String afterSection) {
        List<String> sectionList = getElementsText(thirdPartyPO.getSectionsList());
        int beforeSectionIndex = getSectionIndex(sectionList, beforeSection);
        int afterSectionIndex = getSectionIndex(sectionList, afterSection);
        return (afterSectionIndex - beforeSectionIndex) == 1;
    }

    public void clearThirdPartyNameValue(String currentValue) {
        WebElement columnElement =
                getElement(cssSelector(format(thirdPartyPO.getNameThirdPartyInput(), currentValue)));
        clearText(columnElement);
    }

    public void clickOngoingScreening(String ongoingName) {
        clickOn(xpath(format(thirdPartyPO.getOngoingScreening(), ongoingName)));
    }

    public boolean isOngoingScreeningChecked(String ongoingName) {
        By ongoingScreeningLocator =
                xpath(format(thirdPartyPO.getOngoingScreening(), ongoingName));
        waitLong.until(visibilityOfElementLocated(ongoingScreeningLocator));
        return getElement(ongoingScreeningLocator).getAttribute(CLASS).contains(MUI_CHECKED);
    }

    public boolean isRecipientsTypeChecked(String recipientsType) {
        By recipientsTypeLocator =
                xpath(format(thirdPartyPO.getRecipientsType(), recipientsType));
        waitLong.until(visibilityOfElementLocated(recipientsTypeLocator));
        return getElement(recipientsTypeLocator).getAttribute(CLASS).contains(MUI_CHECKED);
    }

    public boolean isRecipientsNameDisplayed(String recipient) {
        waitLong.until(visibilityOfElementLocated(thirdPartyPO.getRecipientsName()));
        return getElement(thirdPartyPO.getRecipientsName()).getAttribute(VALUE).equals(recipient);
    }

    public void changeNotificationRecipient(String recipientName) {
        clearAndFillInValueAndSelectFromDropDown(recipientName, thirdPartyPO.getNotificationRecipients());
    }

    public boolean isAssociatedPartiesTabLoaded() {
        return isElementDisplayed(waitLong, thirdPartyPO.getAssociatedPartiesTab());
    }

    public boolean areAllInputAssessmentDetailsFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getAssessmentInputField());
    }

    public boolean areAllViewAssessmentDetailsFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getAssessmentViewField());
    }

    public boolean areAllInputGeneralInformationFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getGeneralInformationInputField());
    }

    public boolean areAllViewGeneralInformationFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getGeneralInformationViewField());
    }

    public boolean areAllInputThirdPartySegmentationFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getThirdPartySegmentationInputField());
    }

    public boolean areAllViewThirdPartySegmentationFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getThirdPartySegmentationViewField());
    }

    public boolean areAllInputOtherInformationFieldsDisplayed() {
        return areAllFieldsDisplayed(getActiveCustomFieldsNames(), thirdPartyPO.getOtherInformationInputField());
    }

    public boolean areAllViewOtherInformationFieldsDisplayed() {
        return areAllFieldsDisplayed(getActiveCustomFieldsNames(), thirdPartyPO.getOtherInformationViewField());
    }

    private List<String> getActiveCustomFieldsNames() {
        return getCustomFields(ALL_ITEMS, ALL).getObjects().stream()
                .filter(item -> item.getStatus().equals(CustomFields.ACTIVE.getStatus().toUpperCase()))
                .map(CustomFieldItem::getName)
                .collect(Collectors.toList());
    }

    public boolean areAllInputBankDetailsFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getBankDetailsInputField());
    }

    public boolean areAllViewBankDetailsFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getBankDetailsViewField());
    }

    public boolean areAllInputAddressFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getAddressInputField());
    }

    public boolean areAllViewAddressFieldsDisplayed(List<String> fieldNames) {
        String elementLocator;
        boolean areFieldsDisplayed = false;
        for (String fieldName : fieldNames) {
            if (fieldName.equals(REGION.getDefaultName()) || fieldName.equals(COUNTRY.getDefaultName())) {
                elementLocator = thirdPartyPO.getAddressViewRegionCountryField();
            } else {
                elementLocator = thirdPartyPO.getAddressViewField();
            }
            if (isElementDisplayed(xpath(format(elementLocator, fieldName)))) {
                areFieldsDisplayed = true;
            } else {
                logger.info(fieldName + " field is not displayed");
                logger.info("Field locator " + format(elementLocator, fieldName));
                return false;
            }
        }
        return areFieldsDisplayed;
    }

    public boolean areAllInputContactFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getContactInputField());
    }

    public boolean isContactAddFieldButtonDisabled(String field) {
        return isAttributePresent(xpath(format(thirdPartyPO.getContactAddFieldButton(), field)), DISABLED);
    }

    public boolean areAllViewContactFieldsDisplayed(List<String> fieldNames) {
        return areAllFieldsDisplayed(fieldNames, thirdPartyPO.getContactViewField());
    }

    public boolean areAllViewPhoneNumberFieldsDisplayed(List<String> phoneNumber) {
        return areAllFieldsDisplayed(phoneNumber, thirdPartyPO.getContactPhoneNumberViewField());
    }

    public boolean isInputDescriptionFieldDisplayed() {
        return isElementDisplayed(thirdPartyPO.getDescriptionInput());
    }

    public boolean isInputDescriptionFieldEditable() {
        expandSectionIfCollapsed(DESCRIPTION);
        return isElementEnabled(thirdPartyPO.getDescriptionInput());
    }

    public boolean isAddBankDetailsButtonActive() {
        return !isAttributePresent(thirdPartyPO.getAddBankDetailsButton(), DISABLED);
    }

    public boolean isRemoveBankDetailsButtonActive(int bankPosition) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getRemoveBankDetailsButton(), bankPosition)));
    }

    public boolean isDeleteButtonForDivisionDisabled(String divisionName) {
        return getElement(xpath(format(thirdPartyPO.getDivisionDeleteButton(), divisionName)))
                .findElement(thirdPartyPO.getParentElement()).getAttribute(CLASS).contains(MUI_BUTTON_BASE);
    }

    public boolean isSaveButtonDisabled() {
        return getAttributeValue(thirdPartyPO.getSaveThirdPartyButton(), CLASS).contains(DISABLED);
    }

    public boolean isSaveAndNewButtonDisabled() {
        return getAttributeValue(thirdPartyPO.getSaveAndNewButton(), CLASS).contains(DISABLED);
    }

    public boolean isCancelButtonDisabled() {
        return getAttributeValue(xpath(thirdPartyPO.getCancelBtn()), CLASS).contains(DISABLED);
    }

    public boolean isSectionIconDisplayed(String iconType, String section) {
        waitWhilePreloadProgressbarIsDisappeared();
        switch (getThirdPartyInformationSection(section)) {
            case ADDRESS:
                section = translator.getValue("thirdPartyInformation.address");
                break;
            case BANK_DETAILS:
                section = translator.getValue("thirdPartyInformation.bankDetails");
                break;
            case SCREENING_CRITERIA:
                section = translator.getValue("thirdPartyInformation.screening");
                break;
            case THIRD_PARTY_SEGMENTATION:
                section = translator.getValue("thirdPartyInformation.thirdPartySegmentation");
                break;
            default:
                throw new IllegalArgumentException(
                        "Section " + section + " is not recognized or not added to switch statement yet");
        }
        scrollToTop(waitShort.ignoring(StaleElementReferenceException.class)
                            .until(visibilityOfElementLocated(
                                    xpath(format(thirdPartyPO.getThirdPartySectionIcon(), section)))));
        List<WebElement> alertIcons =
                getElements(waitMoment, xpath(format(thirdPartyPO.getThirdPartySectionIcon(), section)));
        if (!alertIcons.isEmpty()) {
            switch (iconType) {
                case INFORMATIONAL:
                    return alertIcons.stream().anyMatch(c -> c.getCssValue(COLOR).equals(REACT_BLUE.getColorRgba()));
                case CAUTION:
                    return alertIcons.stream().anyMatch(c -> c.getCssValue(COLOR).equals(ORANGE.getColorRgba()));
                case WARNING:
                    return alertIcons.stream().anyMatch(c -> c.getCssValue(COLOR).equals(REACT_RED.getColorRgba()));
                default:
                    throw new IllegalArgumentException(iconType + " alert icon type is incorrect");
            }
        } else {
            logger.warn("Alert icon is not displayed");
            return false;
        }
    }

    public boolean isSectionHidden(String sectionName) {
        return isElementDisplayed(xpath(format(thirdPartyPO.getSectionHidden(), sectionName)));
    }

    public boolean isComponentActivityDisabled(String activityName) {
        return isElementContainsCssValue(xpath(format(thirdPartyPO.getTableActivitiesRowName(), activityName)),
                                         POINTER_EVENTS, NONE);
    }

    public boolean isGroupsNameDisplayed(String groupsValue) {
        return getElement(thirdPartyPO.getGroupsName()).getAttribute(VALUE).equals(groupsValue);

    }

    public void selectGroup(int value) {
        clickOn(thirdPartyPO.getGroupsInput(), waitShort);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy((thirdPartyPO.getDropDownOptions()))).get(value));
    }

    public void hoverToGroups() {
        hoverOverElement(thirdPartyPO.getGroupsName());
    }

    public void hoverToGroupsDropDown(int value) {
        clickOn(thirdPartyPO.getGroupsInput(), waitShort);
        hoverOverElement(
                waitMoment.until(visibilityOfAllElementsLocatedBy((thirdPartyPO.getDropDownOptions()))).get(value));
    }

    public boolean isRiskModelValueIsDisplayed() {
        return isElementDisplayed(thirdPartyPO.getRiskModelValue());
    }

    public boolean isScreeningAccordionCollapsed() {
        return getElement(thirdPartyPO.getScreeningCriteriaAccordion()).getAttribute(ARIA_EXPANDED)
                .equals(Boolean.toString(false));
    }

    public void clickOnScreeningAccordion() {
        clickOn(thirdPartyPO.getScreeningCriteriaAccordion());
    }

    public boolean isAsteriskDisplayedForField(String fieldName, String sectionName) {
        expandSectionIfCollapsed(sectionName);
        return isElementDisplayed(xpath(format(thirdPartyPO.getRequiredFieldAsteriskCharacter(), fieldName)));
    }

    public boolean isFinalAssessmentDisplayed(String fieldName) {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return isElementDisplayed(thirdPartyPO.getFinalAssessment());
    }

}