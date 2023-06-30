package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.dueDiligenceOrder;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.model.WorkflowResponse;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.OrderConfirmationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.OtherName;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Objects;

import static com.refinitiv.asts.test.ui.api.ConnectApi.getIntegraCheckCustomFields;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.DueDiligenceConfirmationOrderConst.ORDER_ID;
import static com.refinitiv.asts.test.ui.constants.DueDiligenceConfirmationOrderConst.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.Assert.assertTrue;

public class OrderConfirmationSteps extends BaseSteps {

    private static final String LINE_BREAK = "<br>";
    private static final String THIS_INCLUDES = "This Includes:";

    private final OrderConfirmationPage orderConfirmationPage;

    public OrderConfirmationSteps(ScenarioCtxtWrapper context) {
        super(context);
        orderConfirmationPage = new OrderConfirmationPage(this.driver, this.context, translator);
    }

    private String updateDate(String date) {
        return getTodayDate(date);
    }

    @When("User on confirmation block clicks {string}")
    public void clickButtonOnConfirmationBlock(String button) {
        orderConfirmationPage.waitWhilePreloadProgressbarIsDisappeared();
        orderConfirmationPage.clickConfirmationBlockButton(orderConfirmationPage.getFromDictionaryIfExists(button));
    }

    @Then("Confirmation block should be displayed")
    public void isConfirmationBlockDisplayed() {
        assertTrue(orderConfirmationPage.isConfirmationBlockDisplayed(), "Confirmation block is not displayed");
    }

    @Then("{string} message for Due Diligence Order is displayed")
    public void isMessageDisplayed(String expected) {
        expected = orderConfirmationPage.getFromDictionaryIfExists(expected).toUpperCase();
        int count = 1;
        int maxTries = 20;
        orderConfirmationPage.waitWhilePreloadProgressbarIsDisappeared();
        orderConfirmationPage.waitWhileLoadingImageIsDisappeared();
        if (!orderConfirmationPage.getConfirmationMessage().equals(expected)) {
            while ((orderConfirmationPage.getConfirmationMessage()
                    .equals(translator.getValue("ddoActivity.orderIsBeenProcessed")) ||
                    orderConfirmationPage.isConfirmationBlockRetryButtonDisplayed()) &&
                    count++ <= maxTries) {
                orderConfirmationPage.clickConfirmationBlockRetryButton();
                orderConfirmationPage.waitWhilePreloadProgressbarIsDisappeared();
                orderConfirmationPage.waitWhileLoadingImageIsDisappeared();
            }
        }
        assertThat(orderConfirmationPage.getConfirmationMessage())
                .as("Due Diligence Order confirmation message is unexpected")
                .isEqualTo(expected);
    }

    @Then("^Order Confirmation 'Order Details' section should be shown with default values for \"(Individual|Organisation)\" order type$")
    public void validateOrderConfirmationOrderDetails(String orderType) {
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        String requester = userTestData.getFirstName() + SPACE + userTestData.getLastName();
        String requesterEmail = userTestData.getUsername();
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String orderId = getLastSavedAsActivityByName(thirdPartyId);
        String expectedPoNo = context.getScenarioContext().isContains(ORDER_PO_NO) ?
                (String) context.getScenarioContext().getContext(ORDER_PO_NO) : StringUtils.EMPTY;
        String expectedBillingEntity = getIntegraCheckCustomFields().getBillToEntity()
                ? AppApi.getDefaultBillingEntityName(userTestData.getUsername())
                : StringUtils.EMPTY;
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(ORDER_TYPE), orderType,
                                orderType + " Order Type is not displayed!");
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(REQUESTER), requester,
                                requester + " Requester is not displayed!");
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(REQUESTER_EMAIL),
                                requesterEmail,
                                requesterEmail + " Requester Email is not displayed!");
        softAssert.assertTrue(orderConfirmationPage.isOrderOrSubjectDetailsFieldDisplayed(REQUESTER_ON_BEHALF_OF),
                              "Requester on behalf of is not displayed!");
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(APPROVER), requester,
                                requester + " Approver is not displayed!");
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(ORDER_ID), orderId,
                                orderId + " Order Id is not displayed!");
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(ORDER_DATE),
                                getTodayDate(REACT_FORMAT),
                                "Order Date is not displayed!");

        if (!expectedBillingEntity.equals(StringUtils.EMPTY)) {
            softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(BILLING_ENTITY),
                                    expectedBillingEntity, expectedBillingEntity + " Billing Entity is not displayed!");
        } else {
            softAssert.assertFalse(orderConfirmationPage.isOrderOrSubjectDetailsFieldDisplayed(BILLING_ENTITY),
                                   "Billing Entity is displayed!");
        }

        if (expectedPoNo.equals(StringUtils.EMPTY)) {
            softAssert.assertTrue(orderConfirmationPage.isOrderOrSubjectDetailsFieldDisplayed(PO_NUMBER),
                                  "Po No. is not displayed!");
        } else {
            softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(PO_NUMBER), expectedPoNo,
                                    expectedPoNo + " Po No. is not displayed!");
        }
        softAssert.assertAll();
    }

    @Then("Order Confirmation 'Organisation Subject Details' section should be shown with default values")
    @SuppressWarnings("unchecked")
    public void validateOrderConfirmationOrganisationSubjectDetails() {
        ThirdPartyData thirdPartyTestData = (ThirdPartyData) context.getScenarioContext().getContext(
                THIRD_PARTY_DATA_CONTEXT);
        orderConfirmationPage.waitWhilePreloadProgressbarIsDisappeared();
        String expectedLocalName = context.getScenarioContext().isContains(OTHER_NAME_DATA)
                ? ((GenericTestData<OtherName>) context.getScenarioContext().getContext(OTHER_NAME_DATA))
                .getDataToEnter()
                .getName()
                : StringUtils.EMPTY;
        String subjectName = thirdPartyTestData.getName();
        String country = thirdPartyTestData.getCountry();

        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(SUBJECT_NAME), subjectName,
                                subjectName + " Subject Name is not displayed!");
        softAssert.assertTrue(orderConfirmationPage.isOrderOrSubjectDetailsFieldDisplayed(ADDRESS),
                              "Address is not displayed!");
        softAssert.assertEquals(orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(COUNTRY), country,
                                country + " Country is not displayed!");

        if (expectedLocalName.equals(StringUtils.EMPTY)) {
            softAssert.assertTrue(
                    orderConfirmationPage.isOrderOrSubjectDetailsFieldDisplayed(SUBJECT_NAME_IN_LOCAL_LANGUAGE),
                    "Subject in Local Language is not displayed!");
        } else {
            softAssert.assertEquals(
                    orderConfirmationPage.getOrderOrSubjectDetailsFieldValue(SUBJECT_NAME_IN_LOCAL_LANGUAGE),
                    expectedLocalName,
                    expectedLocalName + " Subject in Local Language is not displayed!");
        }
        softAssert.assertAll();
    }

    @Then("Order Confirmation 'Default Due Diligence Scope' section for Organisation type should be shown with default values")
    public void validateOrderConfirmationDefaultDueDiligenceScope() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        WorkflowResponse activityResponse = getLastSavedAsActivity(thirdPartyId);
        SoftAssert softAssert = new SoftAssert();
        String scopeName = activityResponse.getLineItem().getName();
        String description;
        if (nonNull(activityResponse.getRecommendedProduct())) {
            description = activityResponse.getRecommendedProduct().getDescription();
        } else {
            description = getWorkflowResponse(getLastSavedAsActivityByName(thirdPartyId))
                    .getAvailableProducts().stream()
                    .filter(product -> product.getName().contains(scopeName))
                    .findFirst().orElseThrow(() -> new RuntimeException("Available Products not found"))
                    .getDescription();
        }
        softAssert.assertEquals(orderConfirmationPage.getScopeName(), scopeName, "Scope Name is unexpected");
        softAssert.assertEquals(orderConfirmationPage.getScopeDescription(), getExpectedDescription(description),
                                "Scope Description is unexpected");
        softAssert.assertAll();
    }

    private String getExpectedDescription(String description) {
        return Objects.nonNull(description) ? THIS_INCLUDES.toUpperCase() + LF + description
                .replaceAll(LINE_BREAK, LF).replaceAll(DOUBLE_SPACE, SPACE)
                .replace(LF + THIS_INCLUDES, StringUtils.EMPTY) : null;
    }

    @Then("Order Confirmation 'Additional Add Ons' section should be hidden")
    public void validateOrderConfirmationAdditionalAddOns() {
        assertThat(orderConfirmationPage.isAdditionalAddOnsSectionDisplayed()).as(
                "Additional Add-Ons section is displayed").isFalse();
    }

    @Then("Order Confirmation 'List Of Key Principals' section for Organisation type should be hidden")
    public void validateOrderConfirmationOrganisationListOfKeyPrincipals() {
        assertThat(orderConfirmationPage.isListOfKeyPrincipalsSectionDisplayed())
                .as("List Of Key Principals section is displayed").isFalse();

    }

    @Then("Order Confirmation 'Attachment' section should be shown with default values")
    public void validateOrderConfirmationAttachment() {
        assertThat(orderConfirmationPage.isAttachmentSectionDisplayed()).as(
                "Attachment section is not displayed").isTrue();
    }

    @Then("Order Confirmation 'Comment' section should be shown with default values")
    public void validateOrderConfirmationComment() {
        assertThat(orderConfirmationPage.isCommentSectionDisplayed()).as(
                "Comment section is not displayed").isTrue();
    }

    @Then("Confirmation Order Selected Questionnaire table contains records")
    public void confirmationOrderSelectedQuestionnaireTableContainsRecords(List<QuestionnaireData> expectedResult) {
        expectedResult.forEach(record -> record.setQuestionnaireName(record.getQuestionnaireName())
                .setDateCompleted(updateDate(record.getDateCompleted())));
        assertThat(orderConfirmationPage.getSelectedQuestionnaires())
                .as("Confirmation Order Selected Questionnaire table doesn't contains contains records")
                .isEqualTo(expectedResult);
    }

}
