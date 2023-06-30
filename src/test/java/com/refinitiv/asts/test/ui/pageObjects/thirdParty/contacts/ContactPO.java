package com.refinitiv.asts.test.ui.pageObjects.thirdParty.contacts;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class ContactPO extends BasePO {

    public ContactPO(WebDriver driver) {
        super(driver);
    }

    public ContactPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    /**
     * =================================================================================================================
     * Supplier page's tabs and common buttons
     * =================================================================================================================
     */
    private final String collapseElapseButton = "//*[contains(text(), \"%s\")]//ancestor::div[@role='button']";
    private final String sectionHidden = "//p[text()='%s']/ancestor::div[@aria-expanded='false']";
    private final String sectionEntered = "//p[text()='%s']/ancestor::div[@aria-expanded='true']";
    private final By contactProfileBackButton = id("contacts-back-button");
    private final By associatedPartyHeaderName =
            xpath("//*[text()=\"" + translator.getValue("associatedParties.associatedPartyOverview") +
                          "\"]/ancestor::li/following-sibling::li/h6");
    private final By associatedPartyBreadcrumbBackButton =
            xpath("//*[text()=\"" + translator.getValue("associatedParties.associatedPartyOverview") +
                          "\"]/../..//button");
    private final By contactSectionsList = cssSelector("[class^=MuiAccordionSummary]");
    private final By saveContactButton =
            xpath("//span[text()='" + translator.getValue("associatedParties.saveButton") +
                          "']/parent::button[contains(@class, 'containedPrimary')]");
    private final By saveAndNewAssociatedPartyButton = xpath("//*[text()='Save and New']/ancestor::button");
    private final By cancelAddContactButton = xpath("//span[text()='Cancel']/parent::button");
    private final By enabledAsUserCheckbox =
            xpath("//*[text()=\"" + translator.getValue("contact.enabledAsUser") +
                          "\"]/parent::span/preceding-sibling::span");
    private final By viewExternalUserButton = xpath("//span[text()='View External User']/parent::button");
    private final String buttonWithText =
            "//button/span[contains(text(), '%s')] | //button/span//*[contains(text(), '%<s')]";
    private final String textInput = "//span[text()='%s']/ancestor::fieldset/preceding-sibling::input";
    private final String textInputOnPosition = "(//span[text()='%s']/ancestor::fieldset/preceding-sibling::input)[%s]";
    private final String validationMessage =
            "//*[text()='%s']/ancestor::div[contains(@class,'item') or contains(@class,'TextField')]//p[contains(@class, 'Mui-error')]";
    private final String section =
            "//*[text()=\"%s\"]/ancestor::*[contains(@class, 'MuiAccordion') and contains(@class, 'MuiPaper')]";
    private final String inputField = "//*[contains(text(),\"%s\")]/parent::div//div//input";
    private final String viewField = "//label[contains(text(), \"%s\")]";
    private final String sectionEditButton = section + "//button//*[name()='svg']";
    private final String contactSectionEditButton = section + "//button";
    private final String sectionCancelButton = section + "//*[text()='Cancel']/parent::button";
    private final String sectionSaveButton =
            section + "//*[text()=\"" + translator.getValue("contact.saveButton") + "\"]/parent::button";
    private final String dropdownField = "//*[text()='%s']/ancestor::div[contains(@class, 'MuiGrid')][1]";
    private final String dropdownInput = dropdownField + "//input/parent::div";
    private final String inputFieldErrorMessage =
            "//*[text()='%s']/ancestor::div[contains(@class,'item') or contains(@class,'TextField')]//p[contains(@class, 'Mui-error')]";
    private final String sectionFieldName = section + "//label";
    private final String requiredIndicator =
            "//*[contains(text(), '%s')]/ancestor::*[contains(@class, 'MuiFormControl')]//span[text()='*']";
    private final String sectionFieldInput = section + inputField;
    private final String sectionDropdownFieldInput = section + dropdownInput;
    private final By addContactModal =
            xpath("//button/following-sibling::p[text()='ASSOCIATED PARTY OVERVIEW']/ancestor::li" +
                          "/following-sibling::li//span[text()='ADD ASSOCIATED PARTY']");
    /**
     * =================================================================================================================
     * External User Modal
     * =================================================================================================================
     */
    private final By cancelExternalUserModal = id("simpleModalCancelButton");
    private final By resetPassword = id("simpleModalSuccessButton");
    private final String externalUserFieldValue =
            "//*[text()='EXTERNAL USER']//ancestor::div[@role='dialog']//span[text()='%s']/ancestor::fieldset/preceding-sibling::input";

    /**
     * =================================================================================================================
     * Contact's profile General Information section
     * =================================================================================================================
     * <p>
     * Overview supplier contact General Information section
     */
    private final By editGeneralInformation =
            xpath(format(sectionEditButton, translator.getValue("thirdPartyInformation.generalInformation")));
    private final By cancelGeneralInformation =
            xpath(format(sectionCancelButton, translator.getValue("thirdPartyInformation.generalInformation")));
    private final String generalInformationFieldValue =
            format(section, translator.getValue("thirdPartyInformation.generalInformation")) + inputField;

    /**
     * Create contact General Information section
     */
    private final By lastNameField = name("lastName");
    private final By firstNameField = name("firstName");
    private final String firstNameInput = "//input[@name='firstName' and @value='%s']";
    private final String lastNameInput = "//input[@name='lastName' and @value='%s']";
    private final By autoScreenSwitcher =
            xpath("//*[@id='autoScreen']/ancestor::span[contains(@class, 'MuiSwitch-switchBase')]");
    private final By keyPrincipalCheckbox = xpath("//*[text()='Key Principal']/parent::*/preceding-sibling::*");
    /**
     * Edit contact General Information section
     */
    private final By saveGeneralInformation = xpath(format(sectionSaveButton, "General Information"));
    private final String generalInformationInputField = format(section, "General Information") + inputField;
    private final String generalInformationViewField = format(section, "General Information") + viewField;

    /**
     * =================================================================================================================
     * Contact's profile Address section
     * =================================================================================================================
     * <p>
     * Overview Contact Address section
     */

    private final String addressDetailsValue =
            format(section, translator.getValue("thirdPartyInformation.address")) + inputField;
    private final String addressDetailsDropdownValue =
            format(section, translator.getValue("thirdPartyInformation.address")) + inputField +
                    "/preceding-sibling::div";
    private final By addressDividers =
            xpath(format(section, translator.getValue("thirdPartyInformation.address")) +
                          "//*[contains(@class, 'MuiDivider')]/following-sibling::div[contains(@class, 'MuiGrid')][2]");
    private final String removeAddressButton =
            "(//*[text()='Address']//ancestor::div[contains(@class, 'MuiAccordion-root')]//div[contains(@class, 'MuiGrid')]/button[not(@data-cid)])[%s]";
    private final String addressViewField =
            format(section, translator.getValue("thirdPartyInformation.address")) + viewField;

    /**
     * Create/Edit supplier Address section
     */
    private final By saveAddressButton =
            xpath(format(sectionSaveButton, translator.getValue("thirdPartyInformation.address")));
    private final By editAddressButton =
            xpath(format(sectionEditButton, translator.getValue("thirdPartyInformation.address")));
    private final By cancelAddressButton =
            xpath(format(sectionCancelButton, translator.getValue("thirdPartyInformation.address")));
    private final By addressCountryInput = xpath("//input[@name='country']");
    private final By addressRegionInput = xpath("//input[@name='region']");
    private final By addressLine = name("addressLine");
    private final By city = name("city");
    private final By zipPostalCode = name("postalCode");
    private final By stateProvince = name("province");
    private final By addAddressButton =
            xpath(format(section, translator.getValue("thirdPartyInformation.address")) +
                          "//span[text()='Add address']/ancestor::button");

    /**
     * =================================================================================================================
     * Contact's profile Contact section
     * =================================================================================================================
     * <p>
     * Overview supplier Contact section
     */
    private final String contactFieldValue =
            format(section, translator.getValue("addThirdParty.contactSection")) + inputField;
    private final By editContactButton =
            xpath(format(sectionEditButton, translator.getValue("addThirdParty.contactSection")));
    private final By cancelContactButton =
            xpath(format(sectionCancelButton, translator.getValue("addThirdParty.contactSection")));
    private final By emailAddressField = cssSelector("[name*=email]");
    private final By saveContactSectionButton =
            xpath(format(sectionSaveButton, translator.getValue("addThirdParty.contactSection")));
    private final String inputContactSectionFieldErrorMessage =
            format(section, translator.getValue("addThirdParty.contactSection")) + inputFieldErrorMessage;
    private final String contactFieldDeleteButton =
            format(section, translator.getValue("addThirdParty.contactSection")) +
                    "//span[contains(text(), '%s')]/ancestor::fieldset/preceding-sibling::*/button";
    private final String contactPhoneNumberViewField =
            format(section, "Contact") +
                    "//span[text()='Phone Number']/ancestor::div[contains(@class, 'MuiFormControl')]//input[@value='%s']";

    /**
     * =================================================================================================================
     * Contact's profile Contact section
     */
    private final String contactInputFieldAddButton =
            "//span[text()='%s']/ancestor::*[contains(@class, 'MuiGrid')][2]//span[contains(text(), 'Add %<s')]/parent::button";
    private final String contactInputField =
            format(section, translator.getValue("addThirdParty.contactSection")) + inputField;
    private final String contactViewField =
            format(section, translator.getValue("addThirdParty.contactSection")) + viewField;

    /**
     * =================================================================================================================
     * Contact's profile Screening Criteria section
     * =================================================================================================================
     * <p>
     */

    private final String checkType =
            "//div[text()='Check Type']/..//p[text()='%s']/parent::span/preceding-sibling::span";
    private final String ongoingScreening =
            "//div[text()='Ongoing Screening']/parent::div[contains(@class, 'MuiGrid')][1]//p[text()='%s']/parent::span/preceding-sibling::span";
    private final String recipientsUser =
            "//*[text()='Notification Recipients']/following-sibling::*//p[text()='%s']/parent::span/preceding-sibling::span";
    private final String inputScreeningCriteriaSectionField = format(section, "Screening Criteria") + inputField;
    private final String inputScreeningCriteriaSectionFieldErrorMessage =
            format(section, "Screening Criteria") + inputFieldErrorMessage;
    private final String searchTermInput = "//input[@name='searchTerm' and @value='%s']";
    private final By screeningCitizenship = id("country-list-citizenship");
    private final By screeningCountryOfLocation = id("country-list-countryOfLocation");
    private final By screeningPlaceOfBirth = id("country-list-placeOfBirth");
    private final By screeningNotificationRecipients = id("notification-recipients-searchTextField");
    private final By groupsInput = xpath("//*[@id='Contacts-ScreeningCriteriaAdd-GroupSelectInput-groups']");
    protected final By dropDownOptions = cssSelector("li[role=option]");
    private final By selectedGroups = xpath("//*[text()='Groups']/../..//div/input");

    /**
     * =================================================================================================================
     * Contact's profile Description section
     * =================================================================================================================
     * <p>
     */

    private final By editDescriptionButton = xpath(format(sectionEditButton, "Description"));
    private final By saveDescriptionButton = xpath(format(sectionSaveButton, "Description"));
    private final By cancelDescriptionButton = xpath(format(sectionCancelButton, "Description"));
    private final By descriptionInput = id("description");

}
