package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class DueDiligenceOrderPO extends BasePO {

    public DueDiligenceOrderPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    //Common
    private final String fieldWithName = "//*[contains(text(), '%s')]";
    private final String fieldValue = "//*[contains(text(), '%s')]/following-sibling::*/input";
    private final By scopeName = xpath("(//*[contains(text(), 'Due Diligence Scope')]/../..//h6)[2]");
    private final String buttonWithText = "//*[contains(text(), \"%s\")]/ancestor::button";
    private final By backButton = xpath("//nav//button");
    private final By linkButton = xpath("//nav//p");
    private final String modalWindowWithText = "//*[@role='dialog']//*[contains(text(),'%s')]";
    private final By modalWindow = xpath("//*[@role='dialog']");
    private final String scopeOption = "//*[@id='scope']//span[contains(., '%s')]";
    private final By notCheckedScopeOptions =
            xpath("//input[@id='scope']/../../../span[not(contains(@class, 'checked')) and contains(@class, 'Radio')]");
    private final By allScopesOptionNames = xpath("//*[@id='scope']//div[@role='button']//span/h6");
    private final By closeAlertButton = xpath("//div[@role='alert']//button");
    private final By cancelButton = id("AlertDialog-cancel");
    private final By proceedButton = id("AlertDialog-ok");
    private final By riskRatingHelpIcon =
            xpath("//*[text()='Risk Rating']/ancestor-or-self::span/following-sibling::*[contains(@class, 'MuiSvgIcon-colorPrimary')]");
    private final By riskRatingHelpPopUp = xpath("//div[@role='tooltip']");
    private final By dueDiligenceFormTitle = xpath("//*[@class='title page-title'] | //li/h6");
    private final By saveAsDraftButton = id("saveDraft");
    private final By placeOrderButton = id("order");
    private final By manageKeyPrincipleButton = id("manageKeyPrincipalButton");

    //Order Header
    private final By billingEntityName = id("billingEntityName");
    private final By poNoField = id("poNo");
    private final By requester = id("requestor");
    private final By requesterEmail = id("requestorEmail");
    private final By orderType = id("orderType");
    private final By requestOnBehalf = id("requestorBehalfOf");
    private final By approver = id("approver");
    private final String approverDropDownItem = "//*[@id='approver-popup']//*[text()='%s']";

    //Subject Details
    private final By subjectNameOnOtherLanguages = xpath("//*[@name='iwOtherNames']");
    private final By supplierName = id("supplierName");
    private final By title = id("title");
    private final By subjectFullName = id("fullName");
    private final By subjectEmail = xpath("//*[@name='individualEmail']");
    private final By subjectDetailsCaption = xpath("//*[@id='subjectDetails']//span[contains(@class, 'caption')]");
    private final By individualSubjectDetailsCaption =
            xpath("//*[@id='individualDetails']//span[contains(@class, 'caption')]");
    private final By individualSubjectDetailsAssociatedCompany = xpath("//*[@name='associatedCompany']");

    //Address
    private final By zipCode = id("zipCodePostal");
    private final By city = id("city");
    private final By state = id("stateProvince");
    private final By addressCountry = id("country");
    private final By addressLine = xpath("//input[@id='address']");

    //Attachment
    private final By uploadFile = xpath("(//*[@data-cid='FileUpload-root']//input)[2]");
    private final By uploadFileInput = xpath("(//*[@data-cid='FileUpload-root']//input)[1]");
    private final By uploadFileCrossButton = xpath("//*[@data-qid='FileUpload-button-cancel']");
    private final By attachmentDescription = xpath("//label[text()='Description']/following-sibling::div/textarea");
    private final By attachmentModalUploadButton = id("due-diligence-attachments-add");
    private final By attachmentTableRows = xpath("//*[@data-cid='due-diligence-attachments']//tbody/tr");
    private final String tableRowValue = "td[%s]";
    private final String questionnaireNameRow = "td[2]/span";
    private final By attachmentTableColumnNameList = xpath("//*[@data-cid='due-diligence-attachments']//thead/tr/th");
    private final By attachmentDelete = xpath("//*[@data-cid='due-diligence-attachments']//thead/tr/th");

    //Comment
    private final By commentBlock = xpath("//label[@id = 'comment-label']/..");

    //Manage Key Principal
    private final By keyPrincipleValue =
            xpath("//*[@id='keyPrincipalTable' or @id='contactManagementTable']");
    private final By keyPrincipleTableColumns = xpath("//*[@id='keyPrincipalTable']//thead//th");
    private final By keyPrincipleTableRows = xpath("//*[@id='keyPrincipalTable']//tbody/tr");

    //Due Diligence Scope
    private final By addOns = xpath("//*[@id='addOns']//*[contains(@class,'MuiFormGroup-root')]/div");
    private final String addOnsCheckbox = "//*[@id='addOns']//input[%s]/../..";

    //Questionnaire
    private final String questionnaireCheckbox =
            "//*[@id='ddo-questionnaire-table']//span[text()[contains(., '%s')]]/ancestor::tr//input";
    private final String questionnaireViewButton =
            "//*[@id='ddo-questionnaire-table']//span[text()[contains(., '%s')]]/ancestor::tr/td/*[contains(@class, 'Svg')]";
    private final By questionnaireTableColumns = xpath("//*[@id='ddo-questionnaire-table']//thead//th");
    private final By selectedQuestionnaireTableRows =
            xpath("//h6[text()='List of selected questionnaire']/following-sibling::div//tbody/tr");
    private final By availableQuestionnaireTableRows =
            xpath("//h6[text()='Select Questionnaire Here']/following-sibling::div//tbody/tr | //*[@id='ddo-questionnaire-table']//tbody/tr");

}
