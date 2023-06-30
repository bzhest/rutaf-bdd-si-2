package com.refinitiv.asts.test.ui.pageObjects.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class RiskAnalyzerPO extends BasePO {

    public RiskAnalyzerPO(WebDriver driver) {
        super(driver);
    }

    private final By riskAnalyzerSection =
            xpath("//*[contains(@class,'MuiAccordionSummary')]//*[contains(text(), 'Risk Analyzer')]");
    private final By riskAreaGroups =
            xpath("//*[contains(text(), 'Risk Analyzer')]/ancestor::div[contains(@class, 'MuiAccordionSummary')]/following-sibling::div//h6");
    private final String riskAnalyzerArea = "//canvas[contains(@id, '%s')]";
    private final By updatedRiskAreaTooltip = xpath("//*[@class='d3-tip n'][2]");
    private final By riskTooltipIcon =
            xpath("(//*[contains(text(), 'Risk Analyzer')]/../*[contains(@class, 'MuiSvgIcon')])[2]");
    private final By riskTooltip = xpath("//*[@role='tooltip']/div");
    private final By riskAnalyzerConfigureButton = id("configureOverallRiskButton");
    private final By riskConfigureModal =
            xpath("//*[@role='dialog']//h2[contains(text(), 'Configure overall risk score')]");
    private final By riskConfigureModalSaveButton = id("simpleModalSuccessButton");
    private final By riskConfigureModalCancelButton = id("simpleModalCancelButton");
    private final By riskConfigureModalDropDown =
            xpath("//*[text()='Risk Areas']/ancestor::label//following-sibling::div");
    private final By riskConfigureModalDropDownInput =
            xpath("//*[text()='Risk Areas']/ancestor::label//following-sibling::div//input");
    private final String riskConfigureModalRadioButton = "//*[text()='%s']/ancestor::label//input/../..";
    private final String dropDownValue = "//*[@role='listbox']//li//span[text()='%s']";
    private final By riskTierTooltipIcon =
            xpath("//*[text()='Risk Tier']/../*[contains(@class, 'MuiSvgIcon')]");
    private final By overallRiskScore = cssSelector("#riskMeter text");
    private final By riskTier = cssSelector("[title^='Risk Tier']~div>span");
    private final By riskScoreMeter = id("riskMeter");
    private final By riskMeterScoreValue = xpath("//*[@id=\"riskMeter\"]//*[@class=\"text-group\"]");
    private final By averagingAllRiskAreaInput = xpath("//*[text()='Averaging All Risk Area']/preceding-sibling::p");
    private final By averagingSelectedRiskAreaInput =
            xpath("//*[text()='Averaging Selected Risk Area']/preceding-sibling::p");
    private final By previewTextField = cssSelector("#riskMeter text");
    private final By multiselectDropdownSelections = cssSelector("[role=combobox] [role=button]>span");

}
