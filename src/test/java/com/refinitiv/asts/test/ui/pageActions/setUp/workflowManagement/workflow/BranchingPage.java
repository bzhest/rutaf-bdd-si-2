package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow;

import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow.BranchingPO;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.TestConstants.COMMA;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE;
import static org.openqa.selenium.By.xpath;
import static java.lang.String.format;

public class BranchingPage extends BasePage<BranchingPage> {

    private final BranchingPO branchingPO;

    public BranchingPage(WebDriver driver) {
        super(driver);
        branchingPO = new BranchingPO(driver);
    }

    @Override
    protected ExpectedCondition<BranchingPage> getPageLoadCondition() {
        return null;
    }

    @Override
    public String getPageTitle() {
        return getElementText(branchingPO.getTitle());
    }

    public String getFirstGroupName() {
        return driver.findElement(branchingPO.getFirstGroup()).getText();
    }

    public String getActivityNameValue() {
        return getAttributeValue(branchingPO.getActivityNameInput(), VALUE);
    }

    public String getDropDownValue(String assessmentLabel) {
        int dropDownIndex = getDialogLabels().indexOf(assessmentLabel) + 1;
        return getAttributeValue(xpath(format(branchingPO.getDropDownInput(), dropDownIndex)), VALUE);
    }

    private List<String> getDialogLabels() {
        return getElementsText(branchingPO.getDropDownLabels());
    }

    public List<String> getDropDownList() {
        return getDropDownOptions(branchingPO.getDropDownOptions());
    }

    public List<String> getGroupActivitiesList(String groupName) {
        return IntStream.rangeClosed(1, getElements(xpath(format(branchingPO.getActivityList(), groupName))).size())
                .mapToObj(i -> getElementText(xpath(format(branchingPO.getActivityName(), groupName, i))) +
                        COMMA + getElementText(xpath(format(branchingPO.getActivityComponent(), groupName, i))))
                .collect(Collectors.toList());
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    public boolean isApplyBranchingModalDisplayed() {
        return isElementDisplayed(branchingPO.getApplyBranchingModal());
    }

    public boolean isApplyBranchingModalDisappeared() {
        return isElementDisappeared(waitMoment, branchingPO.getApplyBranchingModal());
    }

    @Override
    public void load() {

    }

    public void clickActivity(String activityName) {
        clickOn(xpath(format(branchingPO.getActivity(), activityName)));
    }

    public void clickCloseModalButton() {
        clickOn(branchingPO.getBranchingModalCloseButton());
    }

    public void selectDropDownValue(String value, String dropDownLabel) {
        int dropDownIndex = getDialogLabels().indexOf(dropDownLabel) + 1;
        clearAndFillInValueAndSelectFromDropDown(value, xpath(format(branchingPO.getDropDownInput(), dropDownIndex)),
                                                 xpath(format(branchingPO.getDropDownOption(), value)));
    }

    public void clearDropDownValue(String dropDownLabel) {
        int dropDownIndex = getDialogLabels().indexOf(dropDownLabel) + 1;
        clearText(driver.findElement(xpath(format(branchingPO.getDropDownInput(), dropDownIndex))));
    }

    public void clickDropDown(String assessmentLabel) {
        int dropDownIndex = getDialogLabels().indexOf(assessmentLabel) + 1;
        clickOn(xpath(format(branchingPO.getDropDownInput(), dropDownIndex)));
    }

    public void clickActivityName() {
        moveToElementAndClick(driver.findElement(branchingPO.getActivityNameInput()));
    }

}
