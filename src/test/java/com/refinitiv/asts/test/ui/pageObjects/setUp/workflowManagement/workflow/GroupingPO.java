package com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class GroupingPO extends BasePO {

    private final By groupingPage = xpath("//h6/span");
    private final By groupsSection = xpath("//p[text()='GROUPS']");
    private final By activitiesSection = xpath("//p[text()='ACTIVITIES']");
    private final By addGroupButton = xpath("//*[text()='Add Group']/ancestor::button");
    private final By applyButton = xpath("//*[text()='APPLY']/ancestor::button");
    private final By transferToDropDown = xpath("//label[text()='Transfer to']/following-sibling::div/div");
    private final By activityNames = xpath("//p[text()='ACTIVITIES']/../div/div/div");
    private final By activityGroups = xpath("//p[text()='ACTIVITIES']/../div/div/div/div");
    private final String activityCheckboxLabel = "(//*[@name='checked'])[%s]";
    private final String group = "//p[text()='GROUPS']/../div/div[text()='%s']";
    private final String deleteGroupButton = "//p[text()='GROUPS']/../div/div[text()='%s']/button";

    public GroupingPO(WebDriver driver) {
        super(driver);
    }

}
