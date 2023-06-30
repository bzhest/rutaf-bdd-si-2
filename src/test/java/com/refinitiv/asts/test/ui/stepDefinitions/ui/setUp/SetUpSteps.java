package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.pageActions.setUp.SetUpPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_BLUE;
import static org.assertj.core.api.Assertions.assertThat;

public class SetUpSteps extends BaseSteps {

    private final SetUpPage setUpPage;

    public SetUpSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.setUpPage = new SetUpPage(this.driver);
    }

    @When("User clicks Setup navigation option {string}")
    public void clickSetupNavigationOption(String option) {
        setUpPage.clickOption(option);
    }

    @Then("Setup navigation should consist of the following menu")
    public void setupNavigationShouldConsistOfTheFollowingMenu(List<String> expectedResult) {
        assertThat(setUpPage.getNavigationMenuOptions())
                .as("Navigation options are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Setup navigation options should be expanded")
    public void setupNavigationOptionsShouldBeExpanded(List<String> optionsSections) {
        SoftAssertions softAssert = new SoftAssertions();
        optionsSections.forEach(section -> softAssert.assertThat(setUpPage.isNavigationSectionButtonExpanded(section))
                .as("Section %s is not expanded")
                .isTrue()
        );
        softAssert.assertAll();
    }

    @Then("Finger pointer and blue highlight is displayed when hovering over the navigation bar options")
    public void fingerPointerAndBlueHighlightIsDisplayedWhenHoveringOverTheNavigationBarOptions(List<String> options) {
        SoftAssertions softAssert = new SoftAssertions();
        options.forEach(option -> {
            setUpPage.hoverNavigationOptionButton(option);
            softAssert.assertThat(setUpPage.getNavigationOptionCssValue(option, COLOR))
                    .as("Option %s color is unexpected")
                    .isEqualTo(REACT_BLUE.getColorRgba());
            softAssert.assertThat(setUpPage.getNavigationOptionCssValue(option, CURSOR))
                    .as("Mouse for option %s is not finger pointed")
                    .isEqualTo(POINTER);
        });
        softAssert.assertAll();
    }

    @Then("Setup navigation options could be collapsed and expanded")
    public void setupNavigationOptionsCouldBeCollapsedAndExpanded(List<String> optionsSections) {
        SoftAssertions softAssert = new SoftAssertions();
        optionsSections.forEach(section -> {
            setUpPage.clickNavigationSectionButton(section);
            softAssert.assertThat(setUpPage.isNavigationSectionButtonExpanded(section))
                    .as("Section %s is not collapsed")
                    .isFalse();
            setUpPage.clickNavigationSectionButton(section);
            softAssert.assertThat(setUpPage.isNavigationSectionButtonExpanded(section))
                    .as("Section %s is not expanded")
                    .isTrue();
        });
        softAssert.assertAll();
    }

    @Then("^Setup navigation option \"(.*)\" (is|is not) displayed$")
    public void setupNavigationOptionIsDisplayed(String option, String optionStatus) {
        boolean isDisplayed = optionStatus.equals(IS);
        assertThat(setUpPage.isNavigationOptionDisplayed(option))
                .as("Setup navigation option %s is not in expected '%s displayed' state", option, optionStatus)
                .isEqualTo(isDisplayed);
    }

    @Then("^Setup navigation section \"(.*)\" option \"(.*)\" (is|is not) displayed$")
    public void setupSectionOptionIsDisplayed(String section, String option, String optionStatus) {
        boolean isDisplayed = optionStatus.equals(IS);
        assertThat(setUpPage.isSectionOptionDisplayed(section, option))
                .as("Setup navigation option %s is not in expected '%s displayed' state", option, optionStatus)
                .isEqualTo(isDisplayed);
    }

}
