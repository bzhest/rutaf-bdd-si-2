package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow.GroupingPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.xpath;

public class GroupingPage extends BasePage<GroupingPage> {

    private final GroupingPO groupingPO;

    public GroupingPage(WebDriver driver) {
        super(driver);
        groupingPO = new GroupingPO(driver);
    }

    @Override
    protected ExpectedCondition<GroupingPage> getPageLoadCondition() {
        return null;
    }

    @Override
    public String getPageTitle() {
        return getElementText(groupingPO.getGroupingPage());
    }

    public List<String> getActivitiesList() {
        return getElementsText(groupingPO.getActivityNames()).stream()
                .map(text -> text.replaceAll("[\\d\\n\\r\\t]+", EMPTY))
                .collect(Collectors.toList());
    }

    public List<String> getAssignedGroupsList() {
        return getElementsText(driver.findElements(groupingPO.getActivityGroups()));
    }

    public List<String> getTransferToDropDownValues() {
        return getDropDownOptions(groupingPO.getDropDownOptions());
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    public boolean isGroupsSectionDisplayed() {
        return isElementDisplayed(groupingPO.getGroupsSection());
    }

    public boolean isActivitiesSectionDisplayed() {
        return isElementDisplayed(groupingPO.getActivitiesSection());
    }

    public boolean isGroupWithNameDisplayed(String groupName) {
        return isElementDisplayed(xpath(format(groupingPO.getGroup(), groupName)));
    }

    public boolean isTransferButtonEnabled() {
        return !isElementAttributeContains(groupingPO.getTransferToDropDown(), CLASS, DISABLED);
    }

    public boolean isApplyButtonEnabled() {
        return !isElementAttributeContains(groupingPO.getApplyButton(), CLASS, DISABLED);
    }

    public boolean isAddButtonEnabled() {
        return !isElementAttributeContains(groupingPO.getAddGroupButton(), CLASS, DISABLED);
    }

    public boolean haveActivitiesCheckboxes() {
        return IntStream.rangeClosed(1, getActivitiesList().size())
                .allMatch(i -> isElementPresent(xpath(format(groupingPO.getActivityCheckboxLabel(), i))));
    }

    public boolean isDeleteGroupButtonDisplayed(String groupName) {
        return isElementDisplayed(xpath(format(groupingPO.getDeleteGroupButton(), groupName)));
    }

    @Override
    public void load() {

    }

    public void clickAddButton() {
        clickOn(groupingPO.getAddGroupButton());
    }

    public void clickApplyButton() {
        clickOn(groupingPO.getApplyButton());
    }

    public void clickTransferToDropDown() {
        clickOn(groupingPO.getTransferToDropDown());
    }

    public void tickActivityCheckbox(int activityPosition) {
        clickOn(xpath(format(groupingPO.getActivityCheckboxLabel(), activityPosition + 1)));
    }

    public void selectGroupOption(String groupName) {
        clickOn(xpath(format(groupingPO.getDropDownOption(), groupName)));
    }

    public void clickDeleteButton(String groupName) {
        clickOn(xpath(format(groupingPO.getDeleteGroupButton(), groupName)));
    }

}
