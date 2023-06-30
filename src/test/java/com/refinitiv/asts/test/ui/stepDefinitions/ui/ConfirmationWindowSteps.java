package com.refinitiv.asts.test.ui.stepDefinitions.ui;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.ConfirmationWindowPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.COMMENT_DATE;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.ACTIVITY_COMMENT_DATE_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getCurrentCommentDateTime;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertTrue;
import static org.testng.AssertJUnit.assertFalse;

public class ConfirmationWindowSteps extends BaseSteps {

    private final ConfirmationWindowPage confirmationPage;

    public ConfirmationWindowSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.confirmationPage = new ConfirmationWindowPage(this.driver, translator);
    }

    @When("^User clicks (Ok|Yes|No|Delete|Offboard|Cancel|Reject|Close|Proceed|Reset) button on confirmation window$")
    public void clickOnConfirmationWindow(String button) {
        switch (button) {
            case PROCEED:
                if (confirmationPage.isConfirmButtonDisplayed()) {
                    confirmationPage.clickConfirmModalButton();
                }
                break;
            case DELETE:
            case REJECT:
            case YES:
                confirmationPage.clickConfirmModalButton();
                break;
            case CANCEL:
            case NO:
                confirmationPage.clickCancelModalButton();
                break;
            case RESET:
            case OK:
                confirmationPage.clickOkModalButton();
                break;
            case CLOSE:
                confirmationPage.closeModal();
                break;
            case OFFBOARD_BUTTON:
                confirmationPage.clickOffboardModalButton();
                break;
            default:
                throw new IllegalArgumentException(button + " button element couldn't be found on modal window");
        }
    }

    @When("User clicks {string} Alert dialog button")
    public void clickAlertDialogButton(String buttonName) {
        confirmationPage.clickAlertDialogButton(confirmationPage.getFromDictionaryIfExists(buttonName));
        if (buttonName.equals(translator.getValue("ddoActivity.proceedCapitalizeButton"))) {
            context.getScenarioContext()
                    .setContext(COMMENT_DATE, getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT));
        }
    }

    @Then("Confirmation window is disappeared")
    public void confirmationWindowIsDisappeared() {
        assertTrue("Confirmation window is not disappeared", confirmationPage.isConfirmationModalDisappeared());
    }

    @Then("Message is displayed on confirmation window")
    public void confirmationModalIsDisplayedWithText(DataTable dataTable) {
        SoftAssertions soft = new SoftAssertions();
        soft.assertThat(confirmationPage.isConfirmationModalDisplayed())
                .as("Confirmation modal is not displayed")
                .isTrue();
        String actualConfirmationMessage = confirmationPage.getConfirmationModalText();
        List<String> expectedConfirmationMessage = dataTable.asList();
        expectedConfirmationMessage.forEach(text ->
                                                    soft.assertThat(actualConfirmationMessage.contains(text)).as
                                                                    ("Actual confirmation message " +
                                                                             actualConfirmationMessage +
                                                                             " doesn't contain expected text '" + text + "'")
                                                            .isTrue());
        soft.assertAll();
    }

    @Then("^Confirmation window should be (Displayed|Disappeared)$")
    public void confirmationModalWithText(String modalState) {
        if (modalState.equals(DISPLAYED)) {
            assertTrue("Confirmation modal is not displayed", confirmationPage.isConfirmationModalDisplayed());
        } else {
            assertFalse("Confirmation modal is displayed", confirmationPage.isConfirmationModalDisplayed());
        }
    }

    @Then("^Confirmation button (Ok|Yes|No|Close|Delete|Cancel|Offboard|Reject|Proceed) should be displayed$")
    public void verifyConfirmationButtonIsShown(String button) {
        assertThat(confirmationPage.verifyConfirmationButtonIsShown(button)).as(
                "Confirmation button %s isn't displayed", button).isTrue();
    }

    @Then("^Confirmation button with name (Ok|Yes|No|Close|Delete|Cancel|Offboard|Reject|Proceed) should be displayed$")
    public void verifyConfirmationButtonWithNameIsShown(String button) {
        assertThat(confirmationPage.getConfirmationButtonName(button)).as(
                "Confirmation button name %s isn't displayed", button).isEqualTo(button.toUpperCase());
    }

    @Then("Confirmation window button with text {string} is displayed")
    public void confirmationWindowButtonWithTextIsDisplayed(String buttonText) {
        assertThat(confirmationPage.isButtonWithTextDisplayed(buttonText)).as(
                "Confirmation window button with text %s is not displayed", buttonText).isTrue();
    }

    @Then("Alert Dialog with text is displayed")
    public void alertDialogWithTextIsDisplayed(List<String> expectedText) {
        String actualText = confirmationPage.getAlertModalText();
        expectedText.forEach(text -> assertThat(actualText).as("Alert Dialog doesn't contain text").contains(text));
    }

    @Then("Alert Dialog {string} button displayed")
    public void alertDialogButtonDisplayed(String buttonName) {
        assertThat(confirmationPage.isAlertDialogButtonDisplayed(buttonName)).as(
                "Alert Dialog button %s is not displayed", buttonName).isTrue();
    }

    @Then("Alert Dialog with text is displayed with following activity list")
    public void modalIsDisplayedWithTextAndFollowingActivityList(List<String> expectedList) {
        assertThat(confirmationPage.getAlertModalActivityList())
                .as("Unexpected activity list")
                .usingRecursiveComparison().ignoringCollectionOrder().isEqualTo(expectedList);
    }

    @Then("Confirmation window Cross icon should be displayed")
    public void isCrossIconDisplayed() {
        assertThat(confirmationPage.isCrossIconDisplayed()).as("Confirmation window cross icon is not displayed")
                .isTrue();
    }

}
