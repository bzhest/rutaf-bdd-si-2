package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.thirdParty.RiskArea;
import com.refinitiv.asts.test.ui.api.model.thirdParty.RiskProperty;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.RiskAnalyzerSectionPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ConnectApi.getRiskProperties;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getThirdPartyRiskAreasScore;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COLOR;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static java.lang.Double.parseDouble;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertFalse;
import static org.testng.AssertJUnit.assertTrue;

public class ThirdPartyRiskAnalyzerSectionSteps extends BaseSteps {

    private final String ANTI_TRUST_CORRUPTION = "ANTI TRUST & CORRUPTION";
    private final String EMPLOYMENT_SAFETY_REPUTATION = "EMPLOYMENT, SAFETY & REPUTATION";
    private final String CYBER_SECURITY_BUSINESS_STABILITY = "CYBER SECURITY & BUSINESS STABILITY";
    private final String ENVIRONMENTAL_GOVERNANCE = "ENVIRONMENTAL & GOVERNANCE";
    String[] riskAnalyzerAreas =
            {ANTI_TRUST_CORRUPTION, EMPLOYMENT_SAFETY_REPUTATION, CYBER_SECURITY_BUSINESS_STABILITY, ENVIRONMENTAL_GOVERNANCE};
    private final RiskAnalyzerSectionPage riskAnalyzerSectionPage;

    public ThirdPartyRiskAnalyzerSectionSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.riskAnalyzerSectionPage = new RiskAnalyzerSectionPage(this.driver);
    }

    private String getRiskLevel(List<RiskProperty> riskProperties, double riskScore) {
        return riskProperties.stream()
                .filter(risk -> riskScore >= risk.getMin() && riskScore <= risk.getMax()).findFirst()
                .orElseThrow(() -> new RuntimeException("Risk Score was not found"))
                .getLevel();
    }

    @When("User hovers over Risk Analyzer tooltip icon")
    public void hoverRiskAnalyzerTooltipIcon() {
        riskAnalyzerSectionPage.hoverRiskAnalyzerTooltipIcon();
    }

    @When("User clicks Configure Risk Analyzer button")
    public void clickConfigureRiskAnalyzerButton() {
        riskAnalyzerSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        riskAnalyzerSectionPage.clickRiskAnalyzerConfigureButton();
    }

    @When("User selects {string} Overall Risk Score modal's radio button")
    public void selectOverallRiskScoreModalSRadioButton(String radioButtonLabel) {
        riskAnalyzerSectionPage.clickRiskAnalyzerModalRadioButton(radioButtonLabel);
    }

    @When("User clicks Save Overall Risk Score modal's button")
    public void clickSaveOverallRiskScoreModalSButton() {
        riskAnalyzerSectionPage.clickRiskAnalyzerModalSaveButton();
    }

    @When("User selects {string} Risk Area")
    public void selectsRiskArea(String riskAreaName) {
        riskAnalyzerSectionPage.selectRiskArea(riskAreaName);
    }

    @When("User hovers Risk Tier tooltip icon")
    public void hoverRiskTierTooltipIcon() {
        riskAnalyzerSectionPage.hoversOverRiskTier();
    }

    @When("User clicks Configure Overall Risk Score Cancel button")
    public void clickConfigureOverallRiskScoreCancelButton() {
        riskAnalyzerSectionPage.clickConfigureOverallRiskScoreCancelButton();
    }

    @Then("Risk Analyzer section is displayed")
    public void riskAnalyzerSectionIsDisplayed() {
        assertThat(riskAnalyzerSectionPage.isRiskAnalyzerSectionDisplayed())
                .as("Risk Analyzer section is not displayed").isTrue();
    }

    @Then("Risk Analyzer section contains risk sections")
    public void riskAnalyzerSectionContainsRiskSections(DataTable dataTable) {
        assertThat(riskAnalyzerSectionPage.getRiskAnalyzerGroupNames())
                .as("Risk Analyzer section doesn't contain Risk Areas").isEqualTo(dataTable.asList());
    }

    @Then("{string} Tooltip text is displayed {string}")
    public void tooltipTextIsDisplayed(String tooltipRelation, String expectedText) {
        assertThat(riskAnalyzerSectionPage.getRiskTooltipText())
                .as(tooltipRelation + " Tooltip text is not displayed")
                .isEqualTo(expectedText);
    }

    @Then("^Configure Overall Risk Score modal is (displayed|not displayed)$")
    public void configureOverallRiskScoreModalIsDisplayed(String state) {
        boolean isModalStateExpected = riskAnalyzerSectionPage.isRiskConfigureModalStateExpected(state);
        assertThat(isModalStateExpected).as("Configure Overall Risk Score modal is not in expected %s state", state)
                .isTrue();
    }

    @Then("Risk section bars {string} contains expected image")
    public void onlySelectedRiskAreasAreHighlighted(String barState) {
        riskAnalyzerSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        SoftAssertions softAssert = new SoftAssertions();
        for (String area : riskAnalyzerAreas) {
            String riskAreasPath = "/ui/thirdParty/img/%s.png";
            softAssert.assertThat(
                    riskAnalyzerSectionPage.isRiskAnalyzerImageCorrect(area, area + barState, riskAreasPath)).as(
                    "The Risk Analyzer image is unexpected for '%s' area", area).isTrue();
        }
        softAssert.assertAll();
    }

    @Then("^Configure Risk Analyzer button is (disabled|enabled)$")
    public void isRiskAnalyzerConfigureButtonDisabled(String state) {
        boolean isButtonEnabled = riskAnalyzerSectionPage.isConfigureButtonEnabled();
        if (state.equals("enabled")) {
            assertTrue("Add reviewer button is not enabled", isButtonEnabled);
        } else {
            assertFalse("Add reviewer button is not disabled", isButtonEnabled);
        }
    }

    @Then("Third-party's Overall Risk Score should be generated - {string}")
    public void overallRiskScoreShouldBeGenerated(String expectedResult) {
        riskAnalyzerSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(riskAnalyzerSectionPage.getOverallRiskScore())
                .as("Overall Risk Score is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Overall Risk Score contains average score of all risks")
    public void overallRiskScoreContainsAverageScoreOfAllRisks() {
        riskAnalyzerSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        List<RiskArea> riskAreas = getThirdPartyRiskAreasScore(thirdPartyId);
        double expectedRiskScore = Double.parseDouble(new DecimalFormat("#.#").format(
                riskAreas.stream().mapToDouble(RiskArea::getScore).sum() / riskAreas.size()));
        assertThat(parseDouble(riskAnalyzerSectionPage.getOverallRiskScore()))
                .as("Overall Risk Score is unexpected")
                .isEqualTo(expectedRiskScore);
    }

    @Then("Third-party's Risk Tier should be shown - {string}")
    public void thirdPartySRiskTierShouldBeShown(String expectedResult) {
        assertThat(riskAnalyzerSectionPage.getRiskTier())
                .as("Risk Tier is incorrect")
                .isEqualTo(expectedResult);
    }

    @Then("Third-party's Risk Tier should be shown with expected risk score and expected color")
    public void thirdPartyRiskTierShouldBeShownWithExpectedRiskScoreAndExpectedColor() {
        riskAnalyzerSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        riskAnalyzerSectionPage.closeAlertIconIfDisplayed();
        List<RiskProperty> riskProperties = getRiskProperties();
        Map<String, String> riskTierColors = getRiskColors();
        String expectedRiskLevel =
                getRiskLevel(riskProperties, parseDouble(riskAnalyzerSectionPage.getOverallRiskScore()));
        assertThat(riskAnalyzerSectionPage.getRiskTier())
                .as("Risk Tier value is incorrect")
                .isEqualTo(expectedRiskLevel.toUpperCase());
        assertThat(riskAnalyzerSectionPage.getRiskTierCssValue(COLOR))
                .as("Risk Tier color is incorrect")
                .isEqualTo(getColorRgbaFromHex(riskTierColors.get(expectedRiskLevel)));
    }

    @Then("Overall Risk Score is in range of Workflow Risk Score values - {double} to {double}")
    public void verifyOverallRiskScoreIsInRange(double minValue, double maxValue) {
        riskAnalyzerSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(riskAnalyzerSectionPage.isOverallRiskScoreInRange(minValue, maxValue))
                .as("Overall risk score is out of range")
                .isTrue();
    }

    @Then("Overall Risk Score meter is displayed")
    public void overallRiskScoreMeterIsDisplayed() {
        riskAnalyzerSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(riskAnalyzerSectionPage.isOverallRiskScoreMeterDisplayed())
                .as("Overall Risk Score meter is not displayed")
                .isTrue();
    }

    @Then("The Overall Risk Score meter is expected for risk score - {string}")
    public void theOverallRiskScoreMeterContainsExpectedColorBars(String riskScore) {
        assertThat(riskAnalyzerSectionPage.getRiskMeterScore())
                .as("The Overall Risk Score meter is unexpected")
                .isEqualTo(riskScore);
    }

    @Then("Configure Risk Analyzer button is displayed")
    public void checkConfigureButtonIsDisplayed() {
        assertThat(riskAnalyzerSectionPage.isConfigureButtonDisplayed())
                .as("'Configure' button is not displayed")
                .isTrue();
    }

    @Then("Averaging All Risk Area input value - {string}")
    public void checkConfigureButtonIsDisplayed(String expectedValue) {
        assertThat(riskAnalyzerSectionPage.getAveragingAllRiskAreaInputValue())
                .as("Averaging All Risk Area input value is incorrect")
                .isEqualTo(expectedValue);
    }

    @Then("Configure Overall Risk Score default modal elements should be displayed")
    public void checkConfigureOverallRiskScoreElementsAreDisplayed() {
        SoftAssertions soft = new SoftAssertions();
        String allRiskArea = "Averaging All Risk Area";
        String selectedRiskArea = "Averaging Selected Risk Area";
        soft.assertThat(riskAnalyzerSectionPage.isRiskAnalyzerModalRadioButtonDisplayed(allRiskArea))
                .as("Averaging All Risk Area label is not displayed")
                .isTrue();
        soft.assertThat(riskAnalyzerSectionPage.isRiskAnalyzerModalRadioButtonDisplayed(selectedRiskArea))
                .as("Averaging Selected Risk Area label is not displayed")
                .isTrue();
        soft.assertThat(riskAnalyzerSectionPage.isCheckBoxSelected(selectedRiskArea))
                .as("Averaging All Risk Area radio button is not selected by default")
                .isFalse();
        soft.assertThat(riskAnalyzerSectionPage.isCheckBoxSelected(allRiskArea))
                .as("Averaging Selected Risk Area radio button is selected by default")
                .isTrue();
        soft.assertThat(riskAnalyzerSectionPage.isAveragingAllRiskAreaValueDisplayed())
                .as("Averaging All Risk Area value is not displayed")
                .isTrue();
        soft.assertThat(riskAnalyzerSectionPage.isAveragingSelectedRiskAreaInputDisplayed())
                .as("Averaging Selected Risk Area input is disabled")
                .isFalse();
        soft.assertThat(riskAnalyzerSectionPage.isConfigureOverallRiskScoreSaveButtonDisplayed())
                .as("Configure Overall Risk Score 'Save' button is not disabled")
                .isTrue();
        soft.assertThat(riskAnalyzerSectionPage.isConfigureOverallRiskScoreCancelButtonDisplayed())
                .as("Configure Overall Risk Score 'Cancel' button is not disabled")
                .isTrue();
        soft.assertAll();
    }

    @Then("Multi-select dropdown field is displayed containing all risk areas")
    public void multiselectDropdownContainsAllRiskAreas() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        List<RiskArea> riskAreas = getThirdPartyRiskAreasScore(thirdPartyId);
        List<String> riskAreasDescriptions = riskAreas.stream()
                .map(RiskArea::getDescription)
                .collect(Collectors.toList());
        assertThat(riskAnalyzerSectionPage.getAllRiskAreasFromDropdown())
                .as("List of Risk areas in dropdown is incorrect")
                .hasSameElementsAs(riskAreasDescriptions);
    }

    @Then("Multi-select dropdown field is empty")
    public void checkIfMultiselectDropdownFieldIsEmpty() {
        assertThat(riskAnalyzerSectionPage.getMultiSelectDropdownSelections())
                .as("Multiselect fields contains preselected areas")
                .isEqualTo(0);
    }

    @Then("The Overall Risk Score meter should be - {string}")
    public void checkOverallRiskScore(String expectedGrade) {
        assertThat(riskAnalyzerSectionPage.isPreviewScoreGradeDisplayed(expectedGrade))
                .as("Overall Risk Score grade is incorrect")
                .isTrue();
    }

}
