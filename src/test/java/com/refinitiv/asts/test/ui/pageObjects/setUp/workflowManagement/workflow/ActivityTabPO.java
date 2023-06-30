package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow;

import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;
import static org.openqa.selenium.By.cssSelector;

@Getter
public class ActivityTabPO extends WorkflowPO {

    private final By activityTypeInput = xpath(format(inputWithLabel, "Activity Type"));
    private final By riskAreaInput = xpath(format(inputWithLabel, "Risk Area"));
    private final By assigneesInput = xpath(format(inputWithLabel, "Assignee(s)"));
    private final By assessmentValuesInput = xpath("//*[text()='Assessment']/../following-sibling::div//input");
    private final By scopeTypeInput = xpath(format(inputWithLabel, "Scope Type"));
    private final By statusInput = xpath(format(inputWithLabel, "Status"));
    private final String dropDownArrow =
            "//*[text()='%s']/../../following-sibling::div//*[@title='Open' or @title='Close']";
    private final By radioUserAssignee = cssSelector("[value ='user']");
    private final By radioGroupAssignee = cssSelector("[value ='userGroup']");
    private final By responsiblePartyAssignee = xpath("//*[@value ='responsibleParty']/../..");
    private final By dueInInput = cssSelector("[name ='dueIn']");
    private final By buttonDone = id("workflow-management-activity-form-done");
    private final String tabName = "//h4[text()='%s']/ancestor::button[@role='tab']";
    private final By activityPendingCheckbox = cssSelector("[type='checkbox']");
    private final By attachmentInput = cssSelector("[type='file']");
    private final String scopeValueButton = "//button//div[text()='%s']";
    private final By attachmentDeleteIcon = cssSelector("[data-qid='FileUpload-button-cancel']");
    private final By scopeInputs = xpath("//*[contains(text(), 'recommended scope')]/following-sibling::div/button");
    private final By editButton = cssSelector("[title='Edit']");
    private final By relevantQuestionnairesInput = xpath(format(inputWithLabel, "Relevant Questionnaires"));
    private final By internalRelevantQuestionnaireDropdownButton = id("activityQuestionnaireType-Internal-label");
    private final By externalRelevantQuestionnaireDropdownButton = id("activityQuestionnaireType-External-label");
    private final String questionnaireTypeRadioButton = "[value ='%s']";
    private final By relevantQuestionnaireDropdownValue =
            xpath("//*[@id='simple-tabpanel-0']/div/div/div[4]/div[2]/div/div/div");
    private final By activityAutoDDOCheckbox = cssSelector("[type='checkbox']");
    private final By activityRetrieveReviewerQuestionnaireCheckbox =
            xpath("//*[@id=\"simple-tabpanel-0\"]/div/div/div[6]/label/span[1]/span[1]/input");
    private final String fieldErrorClassInRecommendedScope = "//*[text()='(Please select the recommended scope.)']/following-sibling::span";
    public ActivityTabPO(WebDriver driver) {
        super(driver);
    }

}