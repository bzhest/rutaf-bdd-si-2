package com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation.RiskAnalyzerPO;
import com.refinitiv.asts.test.ui.utils.ImageUtil;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.PageElementNames.DISPLAYED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.textToBe;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class RiskAnalyzerSectionPage extends BasePage<RiskAnalyzerSectionPage> {

    public static final Dimension DIMENSION_WITH_PIXEL_RATIO_1_25 = new Dimension(1920, 1080);
    private final RiskAnalyzerPO riskAnalyzerPO = new RiskAnalyzerPO(driver);

    public RiskAnalyzerSectionPage(WebDriver driver) {
        super(driver);
        this.get();
    }

    @Override
    protected ExpectedCondition<RiskAnalyzerSectionPage> getPageLoadCondition() {
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

    public List<String> getRiskAnalyzerGroupNames() {
        return getElementsText(driver.findElements(riskAnalyzerPO.getRiskAreaGroups()));
    }

    public String getRiskTooltipText() {
        return getElementText(waitMoment, riskAnalyzerPO.getRiskTooltip());
    }

    public String getOverallRiskScore() {
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
        return getElementText(waitShort, riskAnalyzerPO.getOverallRiskScore());
    }

    public String getRiskTier() {
        return getElementText(waitShort.until(visibilityOfElementLocated(riskAnalyzerPO.getRiskTier())));
    }

    public String getRiskTierCssValue(String attribute) {
        return waitShort.until(visibilityOfElementLocated(riskAnalyzerPO.getRiskTier())).getCssValue(attribute);
    }

    public boolean isRiskAnalyzerImageCorrect(String area, String fileName, String filePath) {
        driver.manage().window().setPosition(new Point(0, 0));
        driver.manage().window().setSize(DIMENSION_WITH_PIXEL_RATIO_1_25);
        WebElement areaImage = getElement(xpath(format(riskAnalyzerPO.getRiskAnalyzerArea(), area)));
        scrollIntoView(areaImage);
        return ImageUtil.isImageCorrect(filePath, fileName, areaImage);
    }

    public String getRiskMeterScore() {
        scrollIntoView(riskAnalyzerPO.getRiskMeterScoreValue());
        return getElementText(riskAnalyzerPO.getRiskMeterScoreValue());
    }

    public boolean isRiskAnalyzerSectionDisplayed() {
        return isElementDisplayed(waitShort, riskAnalyzerPO.getRiskAnalyzerSection());
    }

    public boolean isRiskConfigureModalStateExpected(String state) {
        if (state.equals(DISPLAYED.toLowerCase())) {
            return isElementDisplayed(waitShort, riskAnalyzerPO.getRiskConfigureModal());
        } else {
            return isElementInvisible(waitShort, riskAnalyzerPO.getRiskConfigureModal());
        }
    }

    public boolean isOverallRiskScoreInRange(double minValue, double maxValue) {
        double overallRiskScore =
                Double.parseDouble(getElementText(riskAnalyzerPO.getOverallRiskScore()));
        return overallRiskScore >= minValue && overallRiskScore <= maxValue;
    }

    public boolean isOverallRiskScoreMeterDisplayed() {
        return isElementDisplayed(waitLong, riskAnalyzerPO.getRiskScoreMeter());
    }

    public void hoverRiskAnalyzerTooltipIcon() {
        scrollIntoView(riskAnalyzerPO.getRiskTooltipIcon());
        hoverOverElement(riskAnalyzerPO.getRiskTooltipIcon());
    }

    public void clickRiskAnalyzerConfigureButton() {
        clickOn(riskAnalyzerPO.getRiskAnalyzerConfigureButton(), waitShort);
    }

    public void clickRiskAnalyzerModalSaveButton() {
        clickOn(riskAnalyzerPO.getRiskConfigureModalSaveButton());
    }

    public void clickRiskAnalyzerModalRadioButton(String radioButtonLabel) {
        clickOn(xpath(format(riskAnalyzerPO.getRiskConfigureModalRadioButton(), radioButtonLabel)));
    }

    public boolean isRiskAnalyzerModalRadioButtonDisplayed(String radioButtonLabel) {
        return isElementDisplayed(xpath(format(riskAnalyzerPO.getRiskConfigureModalRadioButton(), radioButtonLabel)));
    }

    public boolean isCheckBoxSelected(String checkboxName) {
        return isElementAttributeContains(
                xpath(format(riskAnalyzerPO.getRiskConfigureModalRadioButton(), checkboxName)),
                CLASS, CHECKED);
    }

    public boolean isAveragingAllRiskAreaValueDisplayed() {
        return isElementDisplayed(riskAnalyzerPO.getAveragingAllRiskAreaInput());
    }

    public boolean isAveragingSelectedRiskAreaInputDisplayed() {
        return isElementDisplayed(riskAnalyzerPO.getAveragingSelectedRiskAreaInput());
    }

    public void selectRiskArea(String riskName) {
        waitShort.until(visibilityOfElementLocated(riskAnalyzerPO.getRiskConfigureModalDropDown()));
        fillInValueAndSelectFromDropDown(riskName, riskAnalyzerPO.getRiskConfigureModalDropDownInput(),
                                         xpath(format(riskAnalyzerPO.getDropDownValue(), riskName)));
    }

    public void hoversOverRiskTier() {
        scrollToTop();
        hoverOverElement(riskAnalyzerPO.getRiskTierTooltipIcon());
    }

    public boolean isConfigureButtonEnabled() {
        try {
            return isNull(getAttributeValue(riskAnalyzerPO.getRiskAnalyzerConfigureButton(), DISABLED));
        } catch (NoSuchElementException ex) {
            return false;
        }
    }

    public boolean isConfigureButtonDisplayed() {
        return isElementDisplayed(getElement(riskAnalyzerPO.getRiskAnalyzerConfigureButton()));
    }

    public String getAveragingAllRiskAreaInputValue() {
        waitForAngularPageIsLoaded();
        return getElementText(riskAnalyzerPO.getAveragingAllRiskAreaInput());
    }

    public boolean isConfigureOverallRiskScoreSaveButtonDisplayed() {
        return isElementDisplayed(riskAnalyzerPO.getRiskConfigureModalSaveButton());
    }

    public boolean isConfigureOverallRiskScoreCancelButtonDisplayed() {
        return isElementDisplayed(riskAnalyzerPO.getRiskConfigureModalCancelButton());
    }

    public void clickConfigureOverallRiskScoreCancelButton() {
        clickOn(riskAnalyzerPO.getRiskConfigureModalCancelButton());
    }

    public List<String> getAllRiskAreasFromDropdown() {
        waitShort.until(visibilityOfElementLocated(riskAnalyzerPO.getRiskConfigureModalDropDown()));
        clickOn(riskAnalyzerPO.getRiskConfigureModalDropDownInput());
        return getElementsText(getElements(riskAnalyzerPO.getDropDownOptions()));
    }

    public int getMultiSelectDropdownSelections() {
        return getElements(riskAnalyzerPO.getMultiselectDropdownSelections()).size();
    }

    public Boolean isPreviewScoreGradeDisplayed(String expectedGrade) {
        return waitMoment.until(textToBe(riskAnalyzerPO.getPreviewTextField(), expectedGrade));
    }

}
