package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.dueDiligenceOrderManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.setUp.dueDilligenceOrderManagement.CustomRequiredFieldsPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.api.model.CustomFieldIntegraCheckResponse;
import io.cucumber.java.ParameterType;
import io.cucumber.java.en.When;

import static com.refinitiv.asts.test.ui.api.ConnectApi.getIntegraCheckCustomFields;
import static com.refinitiv.asts.test.ui.api.ConnectApi.setCustomFields;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.UNCHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;

public class CustomRequiredFieldsSteps extends BaseSteps {

    private static final String BILLING_ENTITY = "Billing Entity";
    private static final String PURCHASE_ORDER_NUMBER = "Purchase Order Number";
    CustomRequiredFieldsPage customRequiredFields;

    public CustomRequiredFieldsSteps(ScenarioCtxtWrapper context) {
        super(context);
        customRequiredFields = new CustomRequiredFieldsPage(this.driver, this.context, translator);
    }

    @ParameterType("required|not required")
    public boolean isRequired(String option) {
        return option.equals("required");
    }

    @When("User opens Due Diligence Custom Required Fields page")
    public void openDueDiligenceCustomRequiredFields() {
        customRequiredFields.navigateToCustomRequiredFieldsPage();
    }

    @When("User makes sure that Custom field {string} is set as {isRequired} via API")
    public void checkThatCustomFieldIsRequired(String fieldName, Boolean value) {
        CustomFieldIntegraCheckResponse defaultSetUp = getIntegraCheckCustomFields();
        switch (fieldName) {
            case BILLING_ENTITY:
                if (!defaultSetUp.getBillToEntity() == value) {
                    defaultSetUp.setBillToEntity(value);
                    setCustomFields(defaultSetUp);
                }
                break;
            case PURCHASE_ORDER_NUMBER:
                if (!defaultSetUp.getPurchaseOrderNumber().equals(value)) {
                    defaultSetUp.setPurchaseOrderNumber(value);
                    setCustomFields(defaultSetUp);
                }
                break;
            default:
                throw new IllegalArgumentException("Custom Field with name: " + fieldName + " does not exist!");
        }
    }

    @When("I make sure that {string} Required checkbox is {string}")
    public void iMakeSureThatRequiredCheckboxIsChecked(String fieldName, String checkboxStatus) {
        fieldName = customRequiredFields.getFromDictionaryIfExists(fieldName);
        if ((checkboxStatus.equalsIgnoreCase(CHECKED) && !customRequiredFields.isRequiredCheckboxChecked(fieldName))
                || (checkboxStatus.equalsIgnoreCase(UNCHECKED) &&
                customRequiredFields.isRequiredCheckboxChecked(fieldName))) {
            customRequiredFields.tickCustomRequiredFieldCheckbox(fieldName);
            customRequiredFields.clickSaveButton();
        }
    }

    @When("User clicks Save button for custom required fields")
    public void clickSaveBtnForCustomRequiredFields() {
        customRequiredFields.clickSaveButton();
    }

    @When("User checks {string} field's checkbox")
    public void tickCustomRequiredField(String fieldName) {
        customRequiredFields.tickCustomRequiredFieldCheckbox(fieldName);
    }

}
