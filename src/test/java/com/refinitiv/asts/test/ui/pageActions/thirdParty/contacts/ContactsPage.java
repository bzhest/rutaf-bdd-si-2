package com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ApiRequestBuilder;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.mediacheck.MediaCheckUpdateRequest;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.enums.WCOEntityType;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.commonPO.ShowReactPO;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.contacts.ContactsPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.AssociatedPartyIndividualData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.SIPublicApi.getReferencesCountries;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.Pages.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.GREY;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.*;
import static com.refinitiv.asts.test.ui.enums.WCOEntityType.INDIVIDUAL;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage.STATUS;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ContactsPage extends BasePage<ContactsPage> {

    private final ContactsPO contactsPO;
    private final ShowReactPO showReactPO;

    public ContactsPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        contactsPO = new ContactsPO(driver, translator);
        showReactPO = new ShowReactPO(driver);
        this.get();
    }

    @Override
    protected ExpectedCondition<ContactsPage> getPageLoadCondition() {
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

    public void openContactsForCreatedThirdParty() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId + Pages.CONTACT);
        waitWhilePreloadProgressbarIsDisappeared();
    }

    public void openCreatedContactForThirdParty(WCOEntityType type) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String contactId = (String) context.getScenarioContext().getContext(CONTACT_ID);
        if (INDIVIDUAL.equals(type)) {
            driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId + Pages.CONTACT + SLASH + contactId +
                               VIEW_INDIVIDUAL_ASSOCIATED_PARTY);
        } else {
            driver.get(URL + Pages.THIRD_PARTY + SLASH + thirdPartyId + Pages.CONTACT + SLASH + contactId +
                               VIEW_ORGANISATION_ASSOCIATED_PARTY);
        }

    }

    public void turnOnAllCheckTypes(String searchName, String countryName) {
        String countryCode = getReferencesCountries().getData().stream()
                .filter(country -> country.getDescription().equals(countryName))
                .findFirst().get().getCode();
        String associatedPartyId = (String) context.getScenarioContext().getContext(ASSOCIATED_PARTY_ORGANIZATIONAL_ID);
        MediaCheckUpdateRequest mediaCheckUpdateRequest =
                ApiRequestBuilder.turnOnAllCheckTypes(searchName, countryCode);
        ConnectApi.updateCheckTypes(mediaCheckUpdateRequest, associatedPartyId);
    }

    public boolean isContactWithNameDisplayed(String contactName) {
        return isElementDisplayed(xpath(format(contactsPO.getRowWithName(), contactName)));
    }

    public boolean isConfirmationDialogDisplayed() {
        return isElementDisplayed(contactsPO.getDeleteConfirmationDialog());
    }

    public boolean isCreateContactPageDisappeared() {
        return isElementInvisible(waitLong, contactsPO.getAddContactPage());
    }

    public void clickOnConfirmDeleteContactButton() {
        clickOn(contactsPO.getConfirmDeleteButton());
    }

    public void clickDeleteContactWithName(String contactName) {
        clickOn(xpath(format(contactsPO.getDeleteRowWithNameButton(), contactName)), waitShort);
    }

    public void clickEditContactWithName(String contactName) {
        clickOn(xpath(format(contactsPO.getEditRowWithNameButton(), contactName)), waitShort);
    }

    public void clickOnContactWithFirstName(String name) {
        clickOn(waitLong.until(
                presenceOfElementLocated(xpath(format(contactsPO.getContactsTableRowWithText(), name)))));
    }

    public void clickAddAssociatedPartyButton() {
        clickOn(contactsPO.getAddAssociatedPartyButton(), waitLong);
    }

    public void clickKeyPrincipleCheckbox(String contactName) {
        clickWithJS(driver.findElement(xpath(format(contactsPO.getRowButtonCheckbox(), contactName))));
    }

    public void hoverOverEditButton(String contactName) {
        waitLong.until(visibilityOfElementLocated(xpath(format(contactsPO.getEditRowWithNameButton(), contactName))));
        hoverOverElement(xpath(format(contactsPO.getEditRowWithNameButton(), contactName)));
    }

    public boolean isKeyPrincipalChecked(String contactName) {
        return getElement(xpath(format(contactsPO.getRowButtonCheckbox(), contactName))).isSelected();
    }

    public String getTooltipText() {
        String tooltipText = getElementText(contactsPO.getTooltip());
        clickOn(contactsPO.getBody());
        return tooltipText;
    }

    public String getEmptyContactTableText() {
        return getElementText(contactsPO.getEmptyContactTable());
    }

    public List<AssociatedPartyIndividualData> getContactsList() {
        List<String> headers = getContactTableColumns();
        return IntStream.rangeClosed(1, driver.findElements(contactsPO.getContactRows()).size())
                .mapToObj(i -> AssociatedPartyIndividualData.builder()
                        .keyPrinciple(getKeyPrinciple(i))
                        .title(getTextFromTableCell(i, headers.indexOf(TITLE.getName().toUpperCase())))
                        .firstName(getTextFromTableCell(i, headers.indexOf(FIRST_NAME.getName().toUpperCase())))
                        .lastName(getTextFromTableCell(i, headers.indexOf(LAST_NAME.getName().toUpperCase())))
                        .addressCountry(getTextFromTableCell(i, headers.indexOf(COUNTRY.getName().toUpperCase())))
                        .status(getTextFromTableCell(i, headers.indexOf(STATUS.toUpperCase())))
                        .build()).collect(Collectors.toList());
    }

    private String getTextFromTableCell(int cellNumber, int headerPosition) {
        return getElementText(waitShort, xpath(format(contactsPO.getTableCellValue(), cellNumber, headerPosition + 1)));
    }

    public List<String> getContactTableColumns() {
        return getElementsText(waitMoment.ignoring(StaleElementReferenceException.class)
                                       .until(visibilityOfAllElementsLocatedBy(contactsPO.getTableColumn()))).stream()
                .filter(text -> !text.equals(SPACE)).collect(Collectors.toList());
    }

    private Boolean getKeyPrinciple(int i) {
        WebElement keyPrincipleElement = getElement(waitMoment,
                                                    () -> getElement(xpath(format(contactsPO.getKeyPrincipal(), i))));
        return isNull(keyPrincipleElement) ? null :
                keyPrincipleElement.getAttribute(CLASS).contains(MUI_CHECKED);
    }

    public boolean isAddAssociatedPartyButtonDisplayed() {
        return isElementDisplayed(contactsPO.getAddAssociatedPartyButton());
    }

    public boolean areDeleteButtonsDisplayedForEachRow() {
        return driver.findElements(contactsPO.getContactRows()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(contactsPO.getDeleteButton())));
    }

    public boolean areEditButtonsDisplayedForEachRow() {
        return driver.findElements(contactsPO.getContactRows()).stream()
                .allMatch(row -> isElementDisplayed(row.findElement(contactsPO.getEditButton())));
    }

    public boolean isEditButtonEnabledForContact(String contactName) {
        return !getAttributeValue(xpath(format(contactsPO.getEditRowWithNameButton(), contactName)), CLASS).contains(
                GREY.toString().toLowerCase());
    }

    public boolean isEditButtonsDisplayedForContact(String contactName) {
        return isElementDisplayed(xpath(format(contactsPO.getEditRowWithNameButton(), contactName)));
    }

    public void clickOnContactsFirstRow() {
        WebElement firstRow = getElements(showReactPO.getTableRows())
                .stream()
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Contacts table rows are not displayed"));
        clickOn(firstRow);
    }

    public void clickOnAssociatedOrganisation() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(contactsPO.getAssociatedOrganisationButton());
    }

    public void enterName(String name) {
        waitShort.until(visibilityOfElementLocated(contactsPO.getNameField()));
        clearAndInputField(contactsPO.getNameField(), name);
    }

    public void clickOnCollapseElapseButton(String sectionName) {
        clickOn(xpath(format(contactsPO.getCollapseElapseButton(), sectionName)));
    }

    public String getGroupsValue() {
        return getAttributeValue(contactsPO.getAssociatedOrganisationGroupsInput(), VALUE);
    }

    public void selectAssociatedOrganisationScreeningGroup(int value) {
        clickOn(contactsPO.getAssociatedOrganisationGroupsInput(), waitShort);
        clickOn(waitMoment.until(visibilityOfAllElementsLocatedBy(contactsPO.getDropDownOptions())).get(value));
    }

    public void clickAssociatedOrganisationSaveButton() {
        clickOn(contactsPO.getAssociatedOrganisationSaveButton());
    }

    public void hoverToGroupsDropDown(int value) {
        clickOn(contactsPO.getAssociatedOrganisationGroupsInput(), waitMoment);
        hoverOverElement(
                waitMoment.until(visibilityOfAllElementsLocatedBy(contactsPO.getDropDownOptions())).get(value));
    }

    public String getGroupsToolTip() {
        return getElementText(contactsPO.getTooltip());
    }

    public void hoverToGroupsField() {
        hoverOverElement(contactsPO.getAssociatedOrganisationGroupsInput());
    }

    public String getDuplicateCheckModalText() {
        return getElementText(contactsPO.getDuplicateCheckModal());
    }

    public void clickDuplicateCheckCancelButton() {
        clickOn(contactsPO.getDuplicateCheckCancelButton());
    }

    public boolean isDuplicateCheckModalDisappeared() {
        return isElementDisappeared(waitMoment, contactsPO.getDuplicateCheckModal());
    }

    public void clickDuplicateCheckConfirmButton() {
        clickOn(contactsPO.getDuplicateCheckConfirmButton());
    }

    public boolean isDuplicateCheckModalDisplayed() {
        return isElementDisplayed(waitShort, contactsPO.getDuplicateCheckModal());
    }

    public void clickDuplicateCheckHyperlink(String text) {
        clickOn(driver.findElement(new By.ByLinkText(text)));
    }

    public String getAssociatedOrganisationName() {
        waitLong.until(visibilityOfElementLocated(contactsPO.getNameField()));
        return getElementValue(contactsPO.getNameField());
    }

}
