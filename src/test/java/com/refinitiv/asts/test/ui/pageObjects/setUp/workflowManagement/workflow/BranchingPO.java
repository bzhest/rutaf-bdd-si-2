package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class BranchingPO extends BasePO {

    private final By title = xpath("//li[contains(@class, 'MuiBreadcrumbs')]//h6");
    private final By firstGroup = xpath("//p[text()='Group 0']");
    private final String activity = "//*[text()='%s']";
    private final String activityList = "//*[text()='%s']";
    private final String activityName = "//*[text()='%s']/../..//div//div[contains(@style, 'column')]/p[2]";
    private final String activityComponent = "//*[text()='%s']/../..//div//div[contains(@style, 'column')]/p[1]";
    private final By applyBranchingModal = xpath("//*[@role='dialog']//h2[text()='Apply Branching']");
    private final By branchingModalCloseButton = id("back-from-branching-button");
    private final By activityNameInput = cssSelector("[name='branching-activity-name']");
    private final By dropDownLabels = xpath("//*[@role='dialog']//input/../../label");
    private final String dropDownInput = "(//*[@role='dialog']//input)[%s]";

    public BranchingPO(WebDriver driver) {
        super(driver);
    }

}
