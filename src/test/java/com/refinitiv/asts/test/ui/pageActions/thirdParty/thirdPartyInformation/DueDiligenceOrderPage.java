package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.contacts.ContactsPage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.DueDiligenceOrderPO;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.KeyPrincipleData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ConnectApi.getLastPsaOrderId;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ActivityAttachmentFields.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiConstants.DELIMITER;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.substringBefore;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class DueDiligenceOrderPage extends BasePage<ContactsPage> {

    public static final String QUESTION = "?";
    public static final String ORDER_ID_PREFIX = "SI";
    public static final String MANAGE_KAY_PRINCIPAL = "Manage Key Principal";
    public static final String KEY_PRINCIPAL_NAME = "Key Principal Name";
    public static final String EMAIL = "Email";
    public static final String ADDRESS = "Address";
    public static final String QUESTIONNAIRE_NAME = "Questionnaire Name";
    public static final String QUESTIONNAIRE_TYPE = "Questionnaire Type";
    public static final String ASSIGNEE = "Assignee";
    public static final String DATE_COMPLETED = "Date Completed";
    public static final String OVERALL_SCORE = "Overall Score";
    private final DueDiligenceOrderPO dueDiligenceOrderPO;

    public DueDiligenceOrderPage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        dueDiligenceOrderPO = new DueDiligenceOrderPO(driver, translator);
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
        waitWhilePreloadProgressbarIsDisappeared();
        boolean isLoaded =
                waitLong.until(presenceOfElementLocated(dueDiligenceOrderPO.getDueDiligenceFormTitle())).getText()
                        .equalsIgnoreCase(translator.getValue("ddoActivity.ddo"));
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String orderId = getLastPsaOrderId(thirdPartyId);
        context.getScenarioContext().setContext(PSA_ORDER_ID, orderId);
        return isLoaded;
    }

    @Override
    public void load() {

    }

    public void clickCancelButton() {
        clickOn(dueDiligenceOrderPO.getCancelButton(), waitLong);
    }

    public void clickProceedButton() {
        clickOn(dueDiligenceOrderPO.getProceedButton(), waitLong);
    }

    public void clickOnButtonWithText(String buttonText) {
        clickWithJS(waitLong.until(
                visibilityOfElementLocated(xpath(format(dueDiligenceOrderPO.getButtonWithText(), buttonText)))));
    }

    public void clickBackButton() {
        clickOn(getElement(dueDiligenceOrderPO.getBackButton()));
    }

    public void clickBackLinkButton() {
        clickOn(getElement(dueDiligenceOrderPO.getLinkButton()));
    }

    public String getRequester() {
        return getElement(dueDiligenceOrderPO.getRequester()).getAttribute(VALUE);
    }

    public String getRequesterEmail() {
        return getElement(dueDiligenceOrderPO.getRequesterEmail()).getAttribute(VALUE);
    }

    public String getBillingEntity() {
        return getElement(dueDiligenceOrderPO.getBillingEntityName()).getAttribute(VALUE);
    }

    public String getOrderType() {
        return getAttributeValue(waitLong.until(visibilityOfElementLocated(dueDiligenceOrderPO.getOrderType())), VALUE);
    }

    public String getSubjectName() {
        return getElement(dueDiligenceOrderPO.getSupplierName()).getAttribute(VALUE);
    }

    public String getSubjectTitle() {
        return getElement(dueDiligenceOrderPO.getTitle()).getAttribute(VALUE);
    }

    public String getSubjectFullName() {
        return waitLong.until(visibilityOfElementLocated(dueDiligenceOrderPO.getSubjectFullName())).getAttribute(VALUE);
    }

    public String getSubjectEmail() {
        return getElement(dueDiligenceOrderPO.getSubjectEmail()).getAttribute(VALUE);
    }

    public String getSubjectNameInLocalLanguage() {
        return getElement(dueDiligenceOrderPO.getSubjectNameOnOtherLanguages()).getAttribute(VALUE);
    }

    public String getCountry() {
        return getElement(dueDiligenceOrderPO.getAddressCountry()).getAttribute(VALUE);
    }

    public String getAddressLine() {
        String attributeValue = getElement(dueDiligenceOrderPO.getAddressLine()).getAttribute(VALUE);
        return attributeValue.isEmpty() ? null : attributeValue;
    }

    public String getCity() {
        waitLong.until(elementToBeClickable(dueDiligenceOrderPO.getCity()));
        String attributeValue = getElement(dueDiligenceOrderPO.getCity()).getAttribute(VALUE);
        return attributeValue.isEmpty() ? null : attributeValue;
    }

    public String getStateProvince() {
        String attributeValue = getElement(dueDiligenceOrderPO.getState()).getAttribute(VALUE);
        return attributeValue.isEmpty() ? null : attributeValue;
    }

    public String getZipCode() {
        String attributeValue = getElement(dueDiligenceOrderPO.getZipCode()).getAttribute(VALUE);
        return attributeValue.isEmpty() ? null : attributeValue;
    }

    public List<String> getAddOnsList() {
        List<String> addOns = new ArrayList<>();
        for (WebElement el : getElements(dueDiligenceOrderPO.getAddOns())) {
            addOns.add(el.getText());
        }
        return addOns;
    }

    public String getSubjectDetailsCaptionText() {
        return getElement(dueDiligenceOrderPO.getSubjectDetailsCaption()).getText();
    }

    public String getIndividualSubjectDetailsCaptionText() {
        return getElement(dueDiligenceOrderPO.getIndividualSubjectDetailsCaption()).getText();
    }

    public String getIndividualSubjectDetailsAssociatedCompanyText() {
        return getElement(dueDiligenceOrderPO.getIndividualSubjectDetailsAssociatedCompany())
                .getAttribute(VALUE);
    }

    public String getKeyPrincipleValueText() {
        return waitShort.until(visibilityOfElementLocated(dueDiligenceOrderPO.getKeyPrincipleValue())).getText();
    }

    public boolean isButtonWithNameDisplayed(String buttonText) {
        return isElementDisplayed(waitShort, xpath(format(dueDiligenceOrderPO.getButtonWithText(), buttonText)));
    }

    public Boolean isFieldPoNoRequired() {
        return Objects.nonNull(getElement(dueDiligenceOrderPO.getPoNoField()).getAttribute(REQUIRED));
    }

    public Boolean isSubjectNameRequired() {
        return Objects.nonNull(getElement(dueDiligenceOrderPO.getSupplierName()).getAttribute(REQUIRED));
    }

    public boolean isBillingEntityFieldDisplayed() {
        return isElementDisplayed(dueDiligenceOrderPO.getBillingEntityName());
    }

    public Boolean isFieldRequesterOnBehalfEnabledByDefault() {
        return isElementEnabled(dueDiligenceOrderPO.getRequestOnBehalf());
    }

    public Boolean isFieldSubjectNameInLocalLanguageEnabledByDefault() {
        return isElementEnabled(dueDiligenceOrderPO.getSubjectNameOnOtherLanguages());
    }

    public boolean isAttachmentUploadAppears() {
        return isElementDisplayed(dueDiligenceOrderPO.getUploadFile());
    }

    public Boolean isFieldCommentAppears() {
        return isElementDisplayed(waitMoment, dueDiligenceOrderPO.getCommentBlock());
    }

    public void checkOrderTypeScopeIsSwitched(String orderType) {
        waitLong.until(attributeToBe(dueDiligenceOrderPO.getOrderType(), VALUE, orderType));
    }

    public void clickViewQuestionnaireWithName(String questionnaireName) {
        clickOn(xpath(format(dueDiligenceOrderPO.getQuestionnaireViewButton(),
                             questionnaireName.substring(0, Math.min(questionnaireName.length(), 20)))), waitLong);
    }

    public void clickQuestionnaireCheckboxWithName(String questionnaireName) {
        waitShort.until(visibilityOfElementLocated(dueDiligenceOrderPO.getQuestionnaireTableColumns()));
        clickWithJS(driver.findElement(xpath(format(dueDiligenceOrderPO.getQuestionnaireCheckbox(),
                                                    questionnaireName.substring(0, Math.min(questionnaireName.length(),
                                                                                            20))))));
    }

    public boolean isModalWindowWithTextAppears(String text) {
        return isElementDisplayed(waitShort, xpath(format(dueDiligenceOrderPO.getModalWindowWithText(), text)));
    }

    public boolean isModalWindowDisappeared() {
        try {
            waitShort.until(invisibilityOfElementLocated(dueDiligenceOrderPO.getModalWindow()));
            return true;
        } catch (TimeoutException ex) {
            return false;
        }
    }

    public boolean isButtonWithTextEnabled(String buttonName) {
        return isElementEnabled(xpath(format(dueDiligenceOrderPO.getButtonWithText(), buttonName)));
    }

    public void selectScopeOption(String optionName) {
        clickOn(xpath(format(dueDiligenceOrderPO.getScopeOption(), optionName)), waitShort);
    }

    public List<String> getAllScopesList() {
        return getElementsText(getElements(dueDiligenceOrderPO.getAllScopesOptionNames()));
    }

    public List<String> getOrderKeyPrincipalTableColumns() {
        scrollIntoView(dueDiligenceOrderPO.getKeyPrincipleTableColumns());
        return getElementsText(waitMoment, driver.findElements(dueDiligenceOrderPO.getKeyPrincipleTableColumns()));
    }

    private List<String> getQuestionnaireTableColumns() {
        scrollIntoView(dueDiligenceOrderPO.getQuestionnaireTableColumns());
        return driver.findElements(dueDiligenceOrderPO.getQuestionnaireTableColumns()).stream().map(WebElement::getText)
                .collect(Collectors.toList());
    }

    public void clickUncheckedScope() {
        waitWhilePreloadProgressbarIsDisappeared();
        clickOn(dueDiligenceOrderPO.getNotCheckedScopeOptions());
    }

    public void fillInCityFieldWithValue(String city) {
        waitLong.until(elementToBeClickable(dueDiligenceOrderPO.getCity()));
        fillInText(dueDiligenceOrderPO.getCity(), city, waitLong);
    }

    public void closeAlert() {
        waitWhilePreloadProgressbarIsDisappeared();
        if (isElementDisplayed(waitMoment, dueDiligenceOrderPO.getCloseAlertButton())) {
            clickOn(dueDiligenceOrderPO.getCloseAlertButton());
            waitMoment.until(invisibilityOfElementLocated(dueDiligenceOrderPO.getCloseAlertButton()));
        }
    }

    public void extractOrderId() {
        String currentUrl = driver.getCurrentUrl();
        String separator = currentUrl.contains(QUESTION) ? QUESTION : DELIMITER;
        String orderId = substringBefore(currentUrl.substring(currentUrl.indexOf(ORDER_ID_PREFIX)), separator);
        this.context.getScenarioContext().setContext(ORDER_ID, orderId);
    }

    public void fillInPoNo(String orderPoNo) {
        clearInputAndEnterField(dueDiligenceOrderPO.getPoNoField(), orderPoNo);
    }

    public void fillInRequesterOnBehalf(String value) {
        clearInputAndEnterField(dueDiligenceOrderPO.getRequestOnBehalf(), value);
    }

    public void selectOrderType(String orderType) {
        waitLong.until(visibilityOfElementLocated(dueDiligenceOrderPO.getOrderType()));
        fillInDropDownWithRetry(dueDiligenceOrderPO.getOrderType(), orderType, dueDiligenceOrderPO.getDropDownOption());
    }

    public void fillInSubjectNameInLocalLanguage(String otherName) {
        clearInputAndEnterField(dueDiligenceOrderPO.getSubjectNameOnOtherLanguages(), otherName);
    }

    public void fillInAddressSection(ThirdPartyData addressDetails) {
        fillInAddressLine(addressDetails.getAddressLine());
        fillInZipCode(addressDetails.getZipCode());
        fillInCity(addressDetails.getCity());
        fillInState(addressDetails.getStateProvince());
        fillInCountry(addressDetails.getCountry());
    }

    public boolean isModalCancelButtonDisplayed() {
        return isElementDisplayed(dueDiligenceOrderPO.getCancelButton());
    }

    public boolean isModalProceedButtonDisplayed() {
        return isElementDisplayed(dueDiligenceOrderPO.getProceedButton());
    }

    public void selectAddOns(int addOnsPosition) {
        clickOn(xpath(format(dueDiligenceOrderPO.getAddOnsCheckbox(), addOnsPosition)));
    }

    public void fillInFullName(String subjectName) {
        clearAndFillInValueAndSelectFromDropDown(subjectName, dueDiligenceOrderPO.getSubjectFullName(),
                                                 dueDiligenceOrderPO.getDropDownOption());
    }

    public void selectApprover(String approver) {
        clearAndFillInValueAndSelectFromDropDown(approver, dueDiligenceOrderPO.getApprover(),
                                                 format(dueDiligenceOrderPO.getApproverDropDownItem(), approver));
    }

    public void uploadFile(String fileName) {
        String path = getFilePath(fileName);
        driver.findElement(dueDiligenceOrderPO.getUploadFileInput()).sendKeys(path);
        waitShort.until(visibilityOfElementLocated(dueDiligenceOrderPO.getUploadFileCrossButton()));
    }

    public void addDescription(String description) {
        clearAndInputField(dueDiligenceOrderPO.getAttachmentDescription(), description);
    }

    public void clickUploadButton() {
        clickOn(dueDiligenceOrderPO.getAttachmentModalUploadButton());
    }

    public boolean isFieldWithNamePresent(String fieldName) {
        return isElementDisplayed(xpath(format(dueDiligenceOrderPO.getFieldWithName(), fieldName)));
    }

    public String getFieldValue(String fieldName) {
        return getAttributeValue(xpath(format(dueDiligenceOrderPO.getFieldValue(), fieldName)), VALUE);
    }

    public String getDueDiligenceScopeName() {
        return getElementText(dueDiligenceOrderPO.getScopeName());
    }

    public void hoverOverRiskRatingHelpIcon() {
        scrollIntoView(dueDiligenceOrderPO.getRiskRatingHelpIcon());
        hoverOverElement(dueDiligenceOrderPO.getRiskRatingHelpIcon());
    }

    public String getRiskRatingHelpText() {
        return getElementText(dueDiligenceOrderPO.getRiskRatingHelpPopUp());
    }

    public List<Attachment> getAttachmentAllFieldsValues() {
        waitLong.until(visibilityOfElementLocated(dueDiligenceOrderPO.getAttachmentDelete()));
        List<String> columnNames = getElementsText(getElements(dueDiligenceOrderPO.getAttachmentTableColumnNameList()));
        return waitLong.until(numberOfElementsToBeMoreThan(dueDiligenceOrderPO.getAttachmentTableRows(), 0)).stream()
                .map(row -> Attachment.builder()
                        .filename(getColumnValue(row, columnNames, FILE_NAME.getName().toUpperCase()))
                        .description(getColumnValue(row, columnNames, DESCRIPTION.getName().toUpperCase()))
                        .uploadedBy(getColumnValue(row, columnNames, UPLOAD_BY.getName().toUpperCase()))
                        .dateUploaded(getColumnValue(row, columnNames, UPLOAD_DATE.getName().toUpperCase())).build())
                .collect(Collectors.toList());
    }

    public List<KeyPrincipleData> getOrderKeyPrincipalTableValues() {
        List<String> columnNames = getOrderKeyPrincipalTableColumns();
        return driver.findElements(dueDiligenceOrderPO.getKeyPrincipleTableRows()).stream()
                .map(row -> KeyPrincipleData.builder()
                        .fullName(getColumnValue(row, columnNames, KEY_PRINCIPAL_NAME.toUpperCase()))
                        .addressLine(getColumnValue(row, columnNames, ADDRESS.toUpperCase()))
                        .email(getColumnValue(row, columnNames, EMAIL.toUpperCase())).build())
                .collect(Collectors.toList());
    }

    public List<QuestionnaireData> getAvailableQuestionnaires() {
        return getQuestionnaires(dueDiligenceOrderPO.getAvailableQuestionnaireTableRows());
    }

    public List<QuestionnaireData> getSelectedQuestionnaires() {
        moveToElement(getElement(dueDiligenceOrderPO.getSelectedQuestionnaireTableRows()));
        return getQuestionnaires(dueDiligenceOrderPO.getSelectedQuestionnaireTableRows());
    }

    public List<QuestionnaireData> getQuestionnaires(By tableRowsLocator) {
        List<String> columnNames = getQuestionnaireTableColumns();
        return driver.findElements(tableRowsLocator).stream()
                .map(row -> QuestionnaireData.builder()
                        .questionnaireName(
                                getAttributeOrText(row, xpath(dueDiligenceOrderPO.getQuestionnaireNameRow()),
                                                   TITLE_ATR))
                        .questionType(getColumnValue(row, columnNames, QUESTIONNAIRE_TYPE.toUpperCase()))
                        .assignee(getColumnValue(row, columnNames, ASSIGNEE.toUpperCase()))
                        .dateCompleted(getColumnValue(row, columnNames, DATE_COMPLETED.toUpperCase()))
                        .overallScore(getColumnValue(row, columnNames, OVERALL_SCORE.toUpperCase())).build())
                .collect(Collectors.toList());
    }

    public List<String> getListValuesForColumn(String columnName) {
        int columnIndex = getQuestionnaireTableColumns().indexOf(columnName) + 1;
        return driver.findElements(dueDiligenceOrderPO.getAvailableQuestionnaireTableRows()).stream()
                .map(row -> getElementText(
                        row.findElement(xpath(format(dueDiligenceOrderPO.getTableRowValue(), columnIndex)))))
                .collect(Collectors.toList());
    }

    private String getColumnValue(WebElement row, List<String> columnNames, String columnName) {
        int columnNameIndex = columnNames.indexOf(columnName.toUpperCase()) + 1;
        if (columnNameIndex == 0) {
            return null;
        } else {
            By childLocator = xpath(format(dueDiligenceOrderPO.getTableRowValue(), columnNameIndex));
            waitShort.until(driver -> Objects.isNull(getRowChildElementText(row, childLocator)) ||
                    !getRowChildElementText(row, childLocator).equals(PENDING));
            return getRowChildElementText(row, childLocator);
        }
    }

    private void fillInCountry(String country) {
        clearAndFillInValueAndSelectFromDropDown(country, dueDiligenceOrderPO.getAddressCountry(),
                                                 dueDiligenceOrderPO.getDropDownOption());
    }

    private void fillInState(String stateProvince) {
        clearInputAndEnterField(dueDiligenceOrderPO.getState(), stateProvince);
    }

    private void fillInCity(String city) {
        clearInputAndEnterField(dueDiligenceOrderPO.getCity(), city);
    }

    private void fillInZipCode(String zipCode) {
        clearInputAndEnterField(dueDiligenceOrderPO.getZipCode(), zipCode);
    }

    private void fillInAddressLine(String addressLine) {
        clearInputAndEnterField(dueDiligenceOrderPO.getAddressLine(), addressLine);
    }

}
