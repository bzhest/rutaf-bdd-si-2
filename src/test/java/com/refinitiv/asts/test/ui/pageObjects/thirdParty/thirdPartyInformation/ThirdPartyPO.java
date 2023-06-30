package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;
import static org.openqa.selenium.By.xpath;

@Getter
public class ThirdPartyPO extends BasePO {

    public ThirdPartyPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    /**
     * =================================================================================================================
     * Third-party page's tabs and common buttons
     * =================================================================================================================
     */
    private final By thirdPartyQuestionnaireTab = xpath("//span[text()='QUESTIONNAIRE']/parent::button[@role='tab']");
    private final By thirdPartyRiskManagementTab =
            xpath("//span[text()='RISK MANAGEMENT']/parent::button[@role='tab']");
    private final By dataProvidersTab =
            xpath("//span[text()='DATA PROVIDERS']/parent::button[@role='tab']");
    private final By thirdPartyInformationTab =
            xpath("//span[text()='THIRD-PARTY INFORMATION']/parent::button[@role='tab']");
    private final String collapseElapseButton = "//*[text()='%s']/preceding-sibling::*";
    private final String sectionHidden = "//p[text()='%s']/ancestor::div[@aria-expanded='false']";
    private final By associatedPartiesTab =
            xpath("//span[text()='" + translator.getValue("associatedParties") + "']/parent::button[@role='tab']");
    private final By contactsTabPage =
            xpath("//*[text()='CONTACTS']/parent::button[@aria-selected='true']/ancestor::div//h6[text()='CONTACTS OVERVIEW']");
    private final By thirdPartyOverviewButton = xpath("//*[text()='Third-party overview']/preceding-sibling::button");
    private final By advancedSearchBackButton = xpath("//*[text()='Advanced search']/preceding-sibling::button");
    private final By thirdPartyButton = xpath("//span[text()='Third-party']/../..");
    private final By thirdPartySectionsList = xpath(" //*[contains(@class, 'MuiAccordionSummary-content')]//p");
    private final By saveThirdPartyButton = id("save-new-third-party");
    private final By saveAndNewButton = id("save-and-new-third-party");
    private final String sectionText = "//div[@role='button']//p[contains(text(),'%s')]";
    private final By duplicateCheckPopupTitle =
            xpath("//*[@id='ThirdPartyDuplicateModal-DialogContent-ListContainer']/preceding-sibling::div");
    private final By confirmDuplicateCheckButton = id("ThirdPartyDuplicateModal-ConfirmBtn");
    private final By addThirdPartyWindow =
            xpath("//*[text()='Add Third-party']/ancestor::*[contains(@class, 'MuiPaper')]");
    private final String addThirdPartyButton =
            "//*[text()='Add Third-party']/ancestor::*[contains(@class, 'MuiPaper')]//button/span[text()='%s']";
    private final By sectionsList =
            xpath("//div[contains(@class, 'MuiPaper-elevation1')]//div[contains(@class, 'MuiAccordionSummary')]//p");
    private final String section = "//p[text()='%s']//ancestor::div[contains(@class, 'MuiPaper-elevation1')][1]";
    private final By sections = xpath("//p/ancestor::div[contains(@class, 'MuiPaper-elevation1')]");
    private final String dropdownField =
            "//*[text()=\"%s\"]/ancestor::div[contains(@class, 'MuiGrid') or contains(@class, 'MuiBox')][1]";
    private final String dropdownInput = dropdownField + "//input";
    private final String parent = "/..";
    private final By child = xpath("*[1]");
    private final String dropDownOption = " //li[@role='option']//*[text()='%s']";
    private final String inputField = "//span[text()='%s']/ancestor::fieldset/preceding-sibling::input";
    private final String inputFieldErrorMessage =
            "//span[text()='%s']/ancestor::fieldset/parent::div/following-sibling::p";
    private final String saveBtn = "//*[@id='save-new-third-party']";
    private final String cancelBtn = "//*[@id='cancel-add-new-third-party']";
    private final String dropDownOpenButton = dropdownField + "//button[@title='Open']";
    private final By backButton = xpath("//nav//button");
    private final By screeningCriteriaAccordion =
            xpath("//p[text()='Screening Criteria']/parent::div/parent::div/parent::div");
    private final String requiredFieldAsteriskCharacter = "//span[text()='%s']/../following-sibling::span";
    private final By screeningTab =
            xpath("//span[text()='SCREENING']/parent::button[@role='tab']");

    /**
     * =================================================================================================================
     * Third-party's profile Onboarding section
     * =================================================================================================================
     */
    private final By actionButton = xpath("//nav/../../div/following-sibling::div/button");
    private final By startOnboardingButton = xpath("//span[.='Start Onboarding']/parent::button");
    private final By offboardButton = xpath("//span[text()='Offboard']/parent::button");
    private final By renewButton = xpath("//span[text()='Renew']/parent::button");
    private final By declineRenewalButton = xpath("//span[text()='Decline Renewal']/parent::button");
    private final By stopRenewalButton = xpath("//span[text()='Stop Renewal']/parent::button");
    private final By assessmentDetailsSection = xpath("//*[text()='Assessment Details']" +
                                                              "/ancestor::*[contains(@class, 'MuiAccordion-root')]");
    private final By assessmentDetailsEditButton = xpath("//*[text()='Assessment Details']/ancestor::div/button");
    private final By assessmentDetailsNextRenewalDate =
            xpath("//*[text()='Next Renewal Date']/ancestor::fieldset/preceding-sibling::input");
    private final By assessmentDetailsRenewalCycle = name("renewalCycle");
    private final By assessmentDetailsSaveButton = id("assessmentDetailsSaveButton");
    private final By assessmentDetailsCancelButton = id("assessmentDetailsCancelButton");
    private final By descriptionValue = xpath("//p[contains(@class, 'Typography') and text()='Description']" +
                                                      "/ancestor::div[contains(@class, 'Base')]/following-sibling::*" +
                                                      "//div[contains(@class, 'Details')]");
    private final String assessmentDetailsFields =
            "//p[text()='Assessment Details']/ancestor::div[contains(@class, 'MuiPaper')]//label//span[text()='%s']";
    private final String generalInformationFields =
            "//p[text()='General Information']/ancestor::div[contains(@class, 'MuiPaper')]//*[text()='%s']";
    private final String thirdPartySegmentationFields =
            "//p[text()='Third-party Segmentation']/ancestor::div[contains(@class, 'MuiPaper')]//div//*[text()='%s']";
    private final String otherInformationFields =
            format(section, translator.getValue("thirdPartyInformation.otherInformation")) +
                    "//label//span[text()[contains(., \"%s\")]] | " +
                    format(section, translator.getValue("thirdPartyInformation.otherInformation")) +
                    "//p[contains(., \"%<s\")]";
    private final String otherInformationFieldValue =
            format(section, translator.getValue("thirdPartyInformation.otherInformation"))+ "//span[@name='%s']";
    private final String bankDetailsFields =
            "//p[text()=\"" + translator.getValue("thirdPartyInformation.bankDetails") +
                    "\"]/ancestor::div[contains(@class, 'MuiPaper')]//label//*[text()=\"%s\"] | " +
                    "//p[text()=\"" + translator.getValue("thirdPartyInformation.bankDetails") +
                    "\"]/ancestor::div[contains(@class, 'MuiPaper')]//input[contains(@id,\"%<s\")] | " +
                    "//p[text()=\"" + translator.getValue("thirdPartyInformation.bankDetails") +
                    "\"]/ancestor::div[contains(@class, 'MuiPaper')]//div/p/span[text()='%<s']";
    private final String contactFields =
            format(section, translator.getValue("addThirdParty.contactSection")) + "//label//span[text()='%s']";
    private final By thirdPartyStatus =
            xpath("//*[@alt='third-party-information-logo']/parent::div//p[text()='Status']/following-sibling::*/span");
    private final By thirdPartyStatusField =
            xpath("//*[@alt='third-party-information-logo']/parent::div//p[text()='Status']");
    private final By thirdPartyName = xpath("//*[@alt='third-party-information-logo']/parent::div//h5");
    private final By declineOnboardingButton = xpath("//span[text()='Decline Onboarding']/parent::button");
    private final By stopOnboardingButton = xpath("//span[text()='Stop Onboarding']/parent::button");
    private final String onboardingDate = "//*[text()='%s']/ancestor::fieldset/preceding-sibling::span";
    private final String onboardingDateField = "//label//span[text()='%s']";
    private final By relatedWorkflowName = xpath("//hr[contains(@class, 'MuiDivider')]/following-sibling::div//h6");
    private final By relatedWorkflowDescription =
            xpath("//hr[contains(@class, 'MuiDivider')]/following-sibling::div//h6/parent::*//span/span[1]/span");
    private final String componentTab =
            "//*[text()=\"" + translator.getValue("thirdPartyInformation.thirdPartyOverview") +
                    "\"]/ancestor::*[contains(@class,'MuiPaper')]//span[text()='%s' or text()='%s']/parent::button";
    private final String componentTabText =
            "//*[text()=\"" + translator.getValue("thirdPartyInformation.thirdPartyOverview") +
                    "\"]/ancestor::*[contains(@class,'MuiPaper')]//span[text()='%s']";
    private final By componentOverview = cssSelector("[role=tabpanel]");
    private final By tableActivitiesRows = cssSelector("[role=tabpanel] tbody tr");
    private final String tableActivityEditButton = "//td//*[text()='%s']/ancestor::tr//td[6]/*";
    private final String tableActivitiesRowName = "//tbody//td//span[text()[contains(.,'%s')]]/..";
    private final String tableActivitiesRowNames =
            "//*[@role='tabpanel']//*[@aria-label='simple-table-body-row']/td[1]";
    private final String tableActivitiesRow = tableActivitiesRowName + "/ancestor::tr";
    private final String tableActivitiesRowValue = "[role=tabpanel] tbody tr:nth-child(%s)>td:nth-child(%s)";
    private final By tableActivitiesColumns = cssSelector("[role=tabpanel] thead>tr>th>span");
    private final By closeActivityOverviewButton = id("collapse-activities-table");
    private final By onboardingSection =
            xpath("//*[text()='Third-party overview']/ancestor::*[contains(@class, 'MuiPaper')]//*[contains(@class, 'MuiTabs-flexContainer')]");
    private final String buttonWithName = ("//span[starts-with(text(), '%s')]/parent::button");
    private final By assigneeInput = xpath("//*[@object-list='assigneeList']//input");
    private final By assigneeDropDownItems = xpath("//*[@object-list='assigneeList']//*[@id='item']");
    private final By renewalCycleInput = id("renewal");
    private final String assessmentViewField = format(section, "Assessment Details") +
            "//span[text()='%s']/ancestor::fieldset/preceding-sibling::span";
    private final String assessmentInputField = format(section, "Assessment Details") +
            "//span[text()='%s']/ancestor::fieldset/preceding-sibling::input";
    private final By riskModelValue = xpath("//*[contains(@class,'MuiBox')]//*[contains(text(), 'IntegraRating')]");
    private final By finalAssessment =
            xpath("//*[@alt='third-party-information-logo']/parent::div//p[text()='Final Assessment']");

    /**
     * =================================================================================================================
     * Third-party's profile General Information section
     * =================================================================================================================
     * <p>
     * Overview General Information section
     */
    private final By generalInfoSection = xpath(format(section,
                                                       translator.getValue(
                                                               "thirdPartyInformation.generalInformation")));
    private final By editGeneralAndOtherInfoButton =
            xpath("//*[text()='General and Other Information']/parent::div/following-sibling::button[@title='Edit']");
    private final String generalInformationFieldValue =
            format(section, translator.getValue("thirdPartyInformation.generalInformation")) +
                    "//*[text()=\"%s\"]/../../following-sibling::div/span";
    private final String generalInformationDropdownFieldValue =
            format(section, translator.getValue("thirdPartyInformation.generalInformation")) +
                    "//*[text()=\"%s\"]/../following-sibling::div/p";
    private final By generalInformationDivisionValue =
            xpath(format(section, translator.getValue("thirdPartyInformation.generalInformation")) +
                          "//span[text()=\"" +
                          translator.getValue("thirdPartyInformation.generalInformation.division") +
                          "\"]/ancestor::div[contains(@class, 'MuiBox')][1]/div[contains(@class, 'MuiBox')]");
    private final By generalAndOtherInformationInnerSections =
            xpath("//*[text()='General and Other Information']/ancestor::div[@aria-expanded=\"true\"]/following-sibling::div");
    /**
     * Create/Edit General Information section
     */
    private final By referenceNoInput = name("referenceNo");
    private final By nameThirdPartyField = name("name");
    private final String nameThirdPartyInput = "input[name=name][value='%s']";
    private final By companyTypeInput =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.companyType")));
    private final By organisationSizeInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.generalInformation.organizationSize")));
    private final By dateOfIncorporationInput = id("incorporationDate");
    private final By dateOfIncorporationButton = xpath("//*[@id='incorporationDate']/..//button");
    private final By responsiblePartyInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.generalInformation.responsibleParty")));
    private final By divisionInput =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.division")));
    private final By divisionDeleteButtonList =
            xpath(format(dropdownField, translator.getValue("thirdPartyInformation.generalInformation.division")) +
                          "//*[contains(@class, 'deleteIcon')]");
    private final By firstDivisionDeleteButton =
            xpath(format(dropdownField, translator.getValue("thirdPartyInformation.generalInformation.division")) +
                          "//*[contains(@class, 'deleteIcon')][1]");
    private final String divisionDeleteButton = "//span[text()='%s']/ancestor::div[@role='button']" +
            "//*[name()='svg' and contains(@class, 'deleteIcon')]";
    private final By selectedDivisions = cssSelector("[role=combobox] span[data-cid^=TextEllipsis]");
    private final By workflowGroup =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.workflowGroup")));
    private final By currencyInput =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.currency")));
    private final By industryTypeInput =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.industryType")));
    private final By businessCategoryInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.generalInformation.businessCategory")));
    private final By revenueInput =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.revenue")));
    private final By liquidationDateInput = id("liquidationDate");
    private final By affiliationInput =
            xpath(format(dropdownInput, translator.getValue("thirdPartyInformation.generalInformation.affiliation")));
    private final By liquidationDateButton = xpath("//*[@id='liquidationDate']/..//button");
    private final By saveGeneralAndOtherInfoButton = xpath("//*[@id='generalAndOtherInfoSaveButton']");
    private final By cancelGeneralAndOtherInfoButton = xpath("//*[@id='generalAndOtherInfoCancelButton']");
    private final String generalInformationViewField =
            format(section, translator.getValue("thirdPartyInformation.generalInformation")) +
                    "//*[text()='%s']";
    private final String generalInformationInputField =
            format(section, translator.getValue("thirdPartyInformation.generalInformation")) + inputField;
    /**
     * =================================================================================================================
     * Third-party Segmentation section
     * =================================================================================================================
     * <p>
     * Overview Third-party Segmentation section
     */
    private final String thirdPartySegmentationFieldValue =
            format("(" + section, translator.getValue("thirdPartyInformation.thirdPartySegmentation")) +
                    "//*[text()[contains(., \"%s\")]]/ancestor::div)[last()]/div//*[text()]";
    private final By thirdPartySegmentationSectionStatus =
            xpath(format(section, translator.getValue("thirdPartyInformation.thirdPartySegmentation")) +
                          "/div");
    /**
     * Create/Edit Third-party Segmentation section
     */
    private final By spendCategoryInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.spendCategory")));
    private final By designAgreementInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.designAgreement")));
    private final By relationshipVisibilityInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.relationshipVisibility")));
    private final By commodityTypeInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.commodityType")));
    private final By sourcingMethodInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.sourcingMethod")));
    private final By sourcingTypeInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.sourcingType")));
    private final By productImpactInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.productImpact")));
    private final String thirdPartySegmentationViewField =
            format(section, translator.getValue("thirdPartyInformation.thirdPartySegmentation")) +
                    "//*[text()='%s']";
    private final String thirdPartySegmentationInputField =
            format(section, translator.getValue("thirdPartyInformation.thirdPartySegmentation")) + inputField;
    private final By designAgreementOpenButton = xpath(format(dropDownOpenButton, translator.getValue(
            "thirdPartyInformation.thirdPartySegmentation.designAgreement")));

    /**
     * Edit third-party's profile Other Information section
     */
    private final String otherInformationViewField =
            format(section, translator.getValue("thirdPartyInformation.otherInformation")) +
                    "//*[text()='%s']";
    private final String otherInformationInputField =
            format(section, translator.getValue("thirdPartyInformation.otherInformation")) + inputField;

    /**
     * =================================================================================================================
     * Third-party's profile Bank Details section
     * =================================================================================================================
     * <p>
     * Overview third-party's Bank Details section
     */
    private final By thirdPartyBankDetailsSection =
            xpath(format(section, translator.getValue("thirdPartyInformation.bankDetails")));
    private final String bankDetailsFieldValue =
            format(section, translator.getValue("thirdPartyInformation.bankDetails")) +
                    "//span[text()=\"%s\"]/ancestor::fieldset/preceding-sibling::*";
    private final By bankDetailsCountryValue =
            xpath(format(section, translator.getValue("thirdPartyInformation.bankDetails")) +
                          "//*[contains(., '" + translator.getValue("thirdPartyInformation.bankDetails.country") +
                          "')]/parent::div/descendant-or-self::*[text()][last()]");

    /**
     * Create/Edit third-party Bank Details section
     */
    private final String fieldOnBankDetails =
            format(section, translator.getValue("thirdPartyInformation.bankDetails")) + "//*[@name='%s']";
    private final String dropDownOnBankDetails =
            format(section, translator.getValue("thirdPartyInformation.bankDetails")) + dropdownInput;
    private final By bankNameInput =
            xpath("//*[contains(., '" + translator.getValue("thirdPartyInformation.bankDetails.bankName") +
                          "')]/ancestor::label/following-sibling::div/*[@name='name']");
    private final By accountNoInput = name("accountNo");
    private final By branchNameInput = name("branchName");
    private final By bankAddressLineInput = xpath(format(fieldOnBankDetails, "addressLine"));
    private final By bankCityInput = xpath(format(fieldOnBankDetails, "city"));
    private final By bankCountryInput =
            xpath(format(dropDownOnBankDetails, translator.getValue("thirdPartyInformation.bankDetails.country")));
    private final By profileEditBankCountryInput =
            xpath(format(section, translator.getValue("thirdPartyInformation.bankDetails")) +
                          "//input[contains(@id,'Country')]");
    private final String bankDetailsViewField =
            format(section, translator.getValue("thirdPartyInformation.bankDetails")) + "//*[text()='%s']";
    private final String bankDetailsInputField =
            format(section, translator.getValue("thirdPartyInformation.bankDetails")) + inputField;
    private final By addBankDetailsButton =
            xpath("//button/span[text()='" +
                          translator.getValue("thirdPartyInformation.bankDetails.addBankDetailsButton") + "']/ancestor::button");
    private final String removeBankDetailsButton =
            "(//*[text()='" + translator.getValue("thirdPartyInformation.bankDetails") +
                    "']//ancestor::div[contains(@class, 'MuiPaper-elevation1')]" +
                    "//div[contains(@class, 'MuiBox')]/following-sibling::*[@type='button'])[%s]";

    /**
     * Create/Edit/Overview third-party Bank Details section icons
     */
    private final By bankDetailsIconInformational =
            xpath("(//p[text()='" + translator.getValue("thirdPartyInformation.bankDetails") +
                          "']/..//*[contains(@class, 'MuiSvgIcon')])[2]");
    private final String thirdPartySectionIcon =
            "//p[text()='%s']/..//following-sibling::div//*[contains(@class, 'MuiSvgIcon')]";
    private final By bankDetailsIconWarning =
            xpath("(//p[text()='" + translator.getValue("thirdPartyInformation.bankDetails") +
                          "']/..//*[contains(@class, 'MuiSvgIcon')])[4]");

    /**
     * =================================================================================================================
     * Third-party's profile Address section
     * =================================================================================================================
     * <p>
     * Overview third-party's Address section
     */
    private final String addressDetailsFieldValue =
            format(section, translator.getValue("thirdPartyInformation.address")) +
                    "//span[text()=\"%s\"]/ancestor::fieldset/preceding-sibling::*";
    private final String addressDetailsAlternativeFieldValue =
            format(section, translator.getValue("thirdPartyInformation.address")) +
                    "//*[contains(., \"%s\")]/parent::div/descendant-or-self::*[text()][last()]";
    private final By addressInfoIcons = xpath(
            format("//*[text()=\"%s\"]/following-sibling::div//*[name()='svg']", translator.getValue(
                    "thirdPartyInformation.address")));
    private final By addressAlertMessages = cssSelector("[class*=MuiAlert-message]");
    private final String addressIcon =
            "//*[@id='contactProfileAddressAccordion']//img[contains(@data-ng-click, \"%s\")]";

    /**
     * Create/Edit third-party Address section
     */
    private final By addressSection =
            xpath(format(section, translator.getValue("thirdPartyInformation.address")));
    private final String fieldOnAddressDetails = format(section, translator.getValue(
            "thirdPartyInformation.address")) + "//*[@name='%s']";
    private final String addressDropdown =
            format(section, translator.getValue("thirdPartyInformation.address")) + dropdownInput;
    private final String inputAddressSectionField = format(section, translator.getValue(
            "thirdPartyInformation.address")) + inputField;
    private final String inputAddressSectionFieldErrorMessage =
            format(section, translator.getValue("thirdPartyInformation.address")) + inputFieldErrorMessage;
    private final By addressLine = xpath(format(fieldOnAddressDetails, "addressLine"));

    private final By city = xpath(format(fieldOnAddressDetails, "city"));
    private final By zipCode = name("postalCode");
    private final By stateProvince = name("province");
    private final By regionInput = xpath(format(dropdownInput, translator.getValue(
            "thirdPartyInformation.address.region")));
    private final By addressCountryInput = xpath(format(addressDropdown, translator.getValue(
            "thirdPartyInformation.address.country")));
    private final String addressViewField =
            format(section, translator.getValue("thirdPartyInformation.address")) +
                    "//*[text()='%s']/ancestor::label | " +
                    format(section, translator.getValue("thirdPartyInformation.address")) + "//*[text()='%<s']";
    private final String addressViewRegionCountryField =
            format(section, translator.getValue("thirdPartyInformation.address")) + "//*[text()='%s']";
    private final String addressInputField = format(section, translator.getValue(
            "thirdPartyInformation.address")) + inputField;

    /**
     * =================================================================================================================
     * Third-party's profile Contact section
     * =================================================================================================================
     * <p>
     * Overview third-party's Contact section
     */
    private final String contactFieldValue =
            format(section, translator.getValue("addThirdParty.contactSection")) +
                    "//span[text()='%s']/ancestor::fieldset/preceding-sibling::*";
    /**
     * Create/Edit third-party Contact section
     */
    private final By phoneNumberInput = name("phoneNumber");
    private final By faxInput = name("fax");
    private final By websiteInput = name("website");
    private final By emailInput = name("email");
    private final String contactViewField =
            format(section, "Contact") +
                    "//span[text()='%s']/ancestor::div[contains(@class, 'MuiFormControl')]";
    private final String contactPhoneNumberViewField =
            format(section, "Contact") +
                    "//span[text()='Phone Number']/ancestor::div[contains(@class, 'MuiFormControl')]//span[@value='%s']";
    private final String contactInputField =
            format(section, translator.getValue("addThirdParty.contactSection")) + inputField;
    private final String contactAddFieldButton = "//*[text()='%s']/ancestor::button";

    /**
     * Third-party Screening Criteria section
     */

    private final String ongoingScreening =
            "//p[text()='" + translator.getValue("thirdPartyInformation.screening.ongoingScreening") +
                    "']/ancestor::div[contains(@class, 'MuiGrid')][1]//p[text()='%s']/parent::span/preceding-sibling::span";
    private final String recipientsType =
            "//*[@aria-label='notificationRecipientsRadio']//p[text()='%s']/ancestor::span/preceding-sibling::span";
    private final By recipientsName =
            xpath("//*[text()='" + translator.getValue("thirdPartyInformation.screening.notificationRecipients") +
                          "']/ancestor::div/input");
    private final By sameAsAddressCountryCheckbox = id("same-as-address-country-checkbox");
    private final By addPhoneNumber = xpath("//span[text()='Add Phone Number']");
    private final String searchTermInput = "//*[@name='searchTerm' and @value='%s']";
    private final String countryOfRegistrationValue =
            "//*[@id='same-as-address-country-checkbox']/preceding-sibling::div//label[text()='%s']";
    private final By countryOfRegistrationInput =
            xpath(format(section, translator.getValue("thirdPartyInformation.screening")) +
                          format(dropdownInput, "Country of Registration"));
    private final String phoneNumberInputByRow =
            "//*[@name='phoneNumber']//parent::div//parent::div//parent::div/parent::div/div[%s]//input[@name='phoneNumber']";
    private final String inputScreeningCriteriaSectionField =
            format(section, translator.getValue("thirdPartyInformation.screening")) + inputField;
    private final String inputScreeningCriteriaSectionFieldErrorMessage =
            format(section, translator.getValue("thirdPartyInformation.screening")) + inputFieldErrorMessage;
    private final String screeningCriteriaFieldValue =
            "//p[text()='" + translator.getValue("thirdPartyInformation.screening") +
                    "']/../../../..//div[2]//p[text()='%s']";
    private final By notificationRecipients =
            xpath(format(section, translator.getValue("thirdPartyInformation.screening")) +
                          format(dropdownInput,
                                 translator.getValue("thirdPartyInformation.screening.notificationRecipients")));
    private final By groupsName = xpath("//*[text()='Groups']/../..//div/input");
    private final By groupsInput = xpath("//input[@id='groups-GroupSelectInput']");
    protected final By dropDownOptions = cssSelector("li[role=option]");

    /**
     * =================================================================================================================
     * Third-party's profile Description section
     * =================================================================================================================
     * <p>
     * Overview/Create/Edit third-party's Description section
     */
    private final By descriptionSection =
            xpath(format(section, translator.getValue("thirdPartyInformation.relatedFiles.description")));
    private final By descriptionInput =
            xpath("//span[text()=\"" + translator.getValue("thirdPartyInformation.relatedFiles.description") +
                          "\"]/ancestor::fieldset/preceding-sibling::textarea");

    /**
     * =================================================================================================================
     * Third-party's profile Due Diligence Orders section
     * =================================================================================================================
     */

    private final By createOrderButton = cssSelector("#create-order-button>span");
    private final By riskRatingHelpIcon =
            xpath("//*[text()='Risk Rating']/ancestor::th//*[contains(@class, 'MuiSvgIcon')][1]");
    private final String ddOrderSection =
            "//p[text()='Due Diligence Orders']/ancestor::div[contains(@class, 'Mui-expanded')]";
    private final By ddOrdersTableHeader = xpath(ddOrderSection + "//thead/tr/th");
    private final By ddOrdersTableRow = xpath(ddOrderSection + "//tbody/tr");
    private final String ordersTableRowWithStatus = ddOrderSection + "//td//span[text()='%s']/ancestor::tr/td[1]";
    private final By ddOrdersTableCell = cssSelector("td");
    private final String sortIcon =
            "//*[text()='%s']/ancestor::th//span[@data-cid='TextEllipsis-root']/following-sibling::*";

    /**
     * =================================================================================================================
     * Third-party's profile Related Files section
     * =================================================================================================================
     */
    private final String relatedFiles =
            format(section, translator.getValue("thirdPartyInformation.relatedFiles.relatedFiles"));
    private final By relatedFilesSection = xpath(relatedFiles);
    private final By browseButton = cssSelector("label[for=related-file-upload]");
    private final By uploadFileButton = xpath(relatedFiles + format("//button/span[text()='%s']", translator.getValue(
            "thirdPartyInformation.relatedFiles.uploadButton")));
    private final By cancelFileButton = xpath(relatedFiles + format("//button/span[text()='%s']", translator.getValue(
            "thirdPartyInformation.relatedFiles.cancelButton")));
    private final By fileDescription = xpath(relatedFiles + "//input[@name='description']");
    private final By fileTableColumnNames = xpath(relatedFiles + "//table//th/span");
    private final By fileTableRowValues = xpath(relatedFiles + "//tbody/tr/td/span");
    private final By fileTableRows = xpath(relatedFiles + "//tbody/tr");
    private final By fileName = xpath("td[1]");
    private final By description = xpath("td[2]");
    private final By uploadedDate = xpath("td[3]");
    private final String downloadIconForFile = relatedFiles +
            "//span[text()='%s']/ancestor::tr//*[name()='svg' and @title='"
            + translator.getValue("thirdPartyInformation.relatedFiles.downloadIcon") + "']";
    private final String deleteIconForFile = relatedFiles +
            "//span[text()='%s']/ancestor::tr//*[name()='svg' and @title='"
            + translator.getValue("thirdPartyInformation.relatedFiles.deleteIcon") + "']";
    private final By uploadFileInput = id("related-file-upload");
    private final By attachmentDescription = id("description");

}