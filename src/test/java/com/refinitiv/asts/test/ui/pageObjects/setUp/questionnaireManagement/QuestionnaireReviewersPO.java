package com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class QuestionnaireReviewersPO extends BasePO {

    /**
     * Rules
     */
    private final String expandedSection =
            "//*[contains(@aria-labelledby, 'reviewers')]//div[contains(@class, 'expanded')]";
    private final String clearButton = "/following-sibling::div//button[@aria-label='Clear']";
    private final String mainReviewerInput =
            "//h6[text()='Main Reviewer']/../..//input[@aria-autocomplete='list']";
    private final String mainReviewerInputValue =
            mainReviewerInput + " | //h6[text()='Main Reviewer']/../..//div/p";
    private final String openCloseButton = "/..//button[@title='Open' or @title='Close']";
    private final By mainReviewerLabel = xpath(mainReviewerInput + "/../../label");
    private final By mainReviewerInputButton = xpath(mainReviewerInput + openCloseButton);
    private final By mainReviewerInputHelpText = xpath(mainReviewerInput + "/../..//p");
    private final String ruleInputHelpText = "//span[text()='%s']/ancestor::label/../..//p";
    private final By mainReviewerRadioButtons =
            xpath("//h6[text()='Main Reviewer']/../..//*[@role='radiogroup']/label");
    private final By expendedRuleReviewerRadioButtons =
            xpath(expandedSection + "//*[@role='radiogroup']/label");
    private final String mainReviewerRadioButton = "//input[@value='%s']";
    private final String reviewerRadioButton = "(" + expandedSection + "//input[@value='%s'])[last()]";
    private final String reviewerRadioButtonSpan = "(" + reviewerRadioButton + "/../..)[last()]";
    private final String rulesDropDownButton = "(//input[contains(@id, 'reviewerProcessRules-rule-')])[%s]";
    private final String ruleTypeDropDownButton =
            "(" + expandedSection + "//input[contains(@id, 'reviewerProcessRules-ruleValues-')])[%s]";
    private final String ruleTypeDropDownArrowIcon =
            "(" + expandedSection + "//input[contains(@id, 'reviewerProcessRules-ruleValues-')])[%s]" +
                    openCloseButton;
    private final By addRuleField = xpath("//input[contains(@id, 'reviewerProcessRules-rule-')]/..");
    private final By ruleTypeField = xpath("//input[contains(@id, 'reviewerProcessRules-ruleValues')]/..");
    private final By ruleTypeSelectedItems =
            xpath("//label[contains(@id, 'reviewerProcessRules-ruleValues')]/following-sibling::div//*[@role='button']/span");
    private final String reviewerRuleOption =
            "//*[text()='%s']/../preceding-sibling::span//*[@name='reviewerProcessRules']/..";
    private final String reviewerRuleOptionLabel =
            "//*[text()='%s']/../preceding-sibling::span//*[@name='reviewerProcessRules']/../..";
    private final By dropDownRuleTypeName = xpath("//label[contains(@id, 'reviewerProcessRules-ruleValues')]");
    private final By reviewerRuleReviewerInput =
            xpath("(" + expandedSection +
                          "//label//*[text()='Reviewer']/ancestor::label/following-sibling::div//input)[last()]" +
                          " | (" + expandedSection +
                          "//span//*[text()='Reviewer']/ancestor::span/following-sibling::div//p)[last()]");
    private final By reviewerRuleReviewerInputLabel =
            xpath("(" + expandedSection +
                          "//label//*[text()='Reviewer']/ancestor::label/following-sibling::div//input)[last()]/../../label");
    private final String lastInput = "(//*[text()='%s']/ancestor::label/following-sibling::div//input)[last()]";
    private final By reviewerRuleReviewerInputDelete =
            xpath("(" + expandedSection +
                          "//label//*[text()='Reviewer']/ancestor::label/following-sibling::div//input" +
                          clearButton + ")[last()]");
    private final By buttonAddRules = xpath(expandedSection + "//*[@id='addRuleButton']");
    private final String ruleIndexes = "(//button[@id='addRuleButton']/preceding-sibling::*/div/div/div[1])[%s]";
    private final String deleteRuleIcons = "//*[contains(@aria-label,'Delete Rule')]";
    private final String deleteRuleIcon = expandedSection + "//*[contains(@aria-label,'Delete Rule #%s')]";
    private final By deleteMainReviewerButton = xpath("//h6[contains(text(), 'Main Reviewer')]" + deleteRuleIcons);
    private final String ruleIndex = "//button[@id='addRuleButton']/preceding-sibling::div//div[text()='%s']";
    private final String rulesDropDownForLevel =
            "(" + expandedSection + "//input[contains(@id, 'reviewerProcessRules-rule-')])[%s]" +
                    " | (" + expandedSection + "//span[text()='Rule']/../..//p)[%<s]";
    private final String rulesDropDownForLevelDeleteButton =
            "(" + expandedSection + "//input[contains(@id, 'reviewerProcessRules-rule-')])[%s]" + clearButton;
    private final String ruleTypeDropDownForLevel =
            "((//button[@id='addRuleButton'])[%s]/preceding-sibling::*//input[contains(@id, 'reviewerProcessRules-ruleValues-')])[%s]";
    private final String ruleTypeDropDownForLevelDeleteButton = ruleTypeDropDownForLevel + clearButton;
    private final String ruleTypeInput =
            "(" + expandedSection + "//input[contains(@id, 'reviewerProcessRules-ruleValues')])[last()]";
    private final By ruleTypeInputButton = xpath(ruleTypeInput + openCloseButton);
    private final String addRulesButtonForLevel = "(//button[@id='addRuleButton'])[%s]";
    private final String ruleTypeDropDownValueForLevel =
            "((//button[@id='addRuleButton'])[%s]/preceding-sibling::*//input[contains(@id, 'reviewerProcessRules-ruleValues-')])[%s]/.." +
                    "|(//div[contains(@class, 'expanded')]//span[text()='Rule']/../../../following-sibling::div//span[contains(@class, 'MuiChip-label')])[%2$s]";
    private final String reviewerLevelSection = "//*[contains(text(), '%s')]";
    private final String reviewerLevelSectionButton = reviewerLevelSection + "/ancestor::div[@role='button']";
    private final By reviewerLevelSections =
            xpath("//*[contains(@class, 'MuiTabPanel')]//*[contains(@class, 'MuiAccordionSummary') and @role='button']");
    private final String ruleTarget = "(" + expandedSection + "//*[@data-rbd-draggable-context-id])[%s]";
    private final String ruleSection = "//h6[text()='%s']/../..";
    private final String ruleNumber = expandedSection + "//div[text()='%s']";
    private final By ruleNumbers =
            xpath("//p[contains(text(), 'Level')]/../../../following-sibling::div//*[contains(@class, 'MuiAccordionDetails')]/div[1]/div/div/div/div/div[contains(@class, 'Box')]");
    private final By ruleMessage =
            xpath(expandedSection + "//p[contains(text(), 'Level')]/../../../following-sibling::div//p");

    /**
     * Settings
     */
    private final String reviewerTabButton = "//*[text()='%s']/ancestor::button";
    private final By toggleAllowTotalScore = name("allowTotalScoreAdjustment");
    private final By toggleHideTotalScore = name("hideTotalScoresFromReviewers");
    private final By toggleRequireMandatoryComment = name("requireMandatoryComment");
    private final By toggleHideQuestionScore = name("hideQuestionScoreFromReviewers");
    private final By numberOfReviewerLevels = id("mui-component-select-reviewerLevels");
    private final String settingsDropDown = "//*[@name='%s']/ancestor::label/following-sibling::div//input";
    private final String settingsDropDownLabel = "//*[@name='%s']/ancestor::label/following-sibling::div";
    private final String settingsDropDownSelectedValues =
            "//*[@name='%s']/ancestor::label/following-sibling::div//div/span/span[@data-cid='TextEllipsis-root']";
    private final String settingsSelectedValueClearIcon =
            "//*[@name='%s']/ancestor::label/following-sibling::div//*[text()='%s']/../../following-sibling::*[name()='svg']";

    /**
     * Process flow
     */
    private final By processFlowRows = xpath("//tbody//tr");
    private final By processFlowHeaders = xpath("//thead//th");
    private final By tableLevel = xpath("td[1]");
    private final By tableDescription = cssSelector("[name='levelDescription']");
    private final String approveNextLevel =
            "//tr[%s]//span[contains(., 'Approve')]/following-sibling::div//p | //tr[%<s]//input[contains(@id,'approveNextLevel')]";
    private final String declineNextLevel =
            "//tr[%s]//span[contains(., 'Decline')]/following-sibling::div//p | //tr[%<s]//input[contains(@id,'declineNextLevel')]";
    private final String description = "(//*[@name='levelDescription'])[%s]";
    private final By processFlowCheckbox =
            xpath("//span[text()='The reviewer can continue the review process']/..//input");
    private final String processFlowInputLabel = "(//tbody//span[contains(., '%s')]/ancestor::label)[%s]";
    private final String processFlowInputError = processFlowInputLabel + "/following-sibling::p";

    public QuestionnaireReviewersPO(WebDriver driver) {
        super(driver);
    }

}
