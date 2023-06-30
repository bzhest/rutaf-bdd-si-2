package com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ApproverProcessRules;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.Approvers;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.UserItem;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.UsersList;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.workflowManagement.workflow.ApproverTabPO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowReviewerApproverData;
import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.ApprovalProcessSteps.*;
import static java.lang.String.format;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.*;

public class ApproverPage extends BasePage<ApproverPage> {

    private final ApproverTabPO approverTabPO;
    private static final String ADD_RULES_FOR = "Add Rules For";
    private static final String APPROVER = "Approver";

    public ApproverPage(WebDriver driver, ScenarioCtxtWrapper context) {
        super(driver, context);
        approverTabPO = new ApproverTabPO(driver);
    }

    @Override
    protected ExpectedCondition<ApproverPage> getPageLoadCondition() {
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

    private boolean isOptionFromDropdownSelected(WebElement element) {
        return nonNull(element) && element.getAttribute(CLASS).contains(NG_VALID_PARSE_CLASS);
    }

    public boolean isDefaultApproverSelected() {
        return isOptionFromDropdownSelected(getElement(approverTabPO.getDefaultApproverInput()));
    }

    public boolean isAddRulesForSelected() {
        return isOptionFromDropdownSelected(getElement(approverTabPO.getAddRulesForInput()));
    }

    public boolean isAddApproverButtonDisabled() {
        return isElementAttributeContains(approverTabPO.getButtonAddApprover(), CLASS, DISABLED);
    }

    public boolean isRuleSectionNumberDisplayed(int sectionPosition) {
        return isElementDisplayed(xpath(format(approverTabPO.getApproveRule(), sectionPosition)));
    }

    public boolean areActivityOwnersSelected() {
        return getElements(approverTabPO.getActivityOwnerValue()).size() > 1;
    }

    public boolean areApproversSelected() {
        return getElements(approverTabPO.getApproverValue()).size() > 1;
    }

    public boolean isRemoveRuleButtonDisplayed(int sectionIndex) {
        return isElementPresent(xpath(format(approverTabPO.getButtonRemoveRule(), sectionIndex)));
    }

    public void clickRemoveRuleButton(int sectionIndex) {
        clickOn(xpath(format(approverTabPO.getButtonRemoveRule(), sectionIndex)));
    }

    public void clickAddExistingApprovalProcess() {
        clickOn(approverTabPO.getAddExistingApprovalProcessButton());
        waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    public void clickAddApproverButton() {
        clickOn(approverTabPO.getButtonAddApprover());
    }

    public void fillInDefaultApproverField(String value) {
        clearAndFillInValueAndSelectFromDropDown(value, approverTabPO.getDefaultApproverInput(),
                                                 approverTabPO.getDropDownOption());
    }

    public void fillInApproverDetails(WorkflowReviewerApproverData approverData, int sectionPosition) {
        waitWhilePreloadProgressbarIsDisappeared();
        fillInAddRuleFor(approverData, sectionPosition);
        waitWhilePreloadProgressbarIsDisappeared();
        fillInRuleFor(approverData, sectionPosition);
        fillInApprover(approverData, sectionPosition);
        selectApproverMethod(approverData.getReviewerMethod(), sectionPosition);
    }

    private void fillInAddRuleFor(WorkflowReviewerApproverData approverData, int sectionPosition) {
        clearAndFillInValueAndSelectFromDropDown(approverData.getAddRulesFor(),
                                                 xpath(format(approverTabPO.getApproverRuleInput(),
                                                              sectionPosition,
                                                              ADD_RULES_FOR)),
                                                 format(approverTabPO.getDropDownOption(),
                                                        approverData.getAddRulesFor()));
    }

    private void fillInRuleFor(WorkflowReviewerApproverData approverData, int sectionPosition) {
        waitMoment.until(elementToBeClickable(
                xpath(format(approverTabPO.getApproverRuleInput(), sectionPosition,
                             approverData.getAddRulesFor()))));
        clearAndFillInValueAndSelectFromDropDown(approverData.getActivityOwner(),
                                                 xpath(format(approverTabPO.getApproverRuleInput(),
                                                              sectionPosition,
                                                              approverData.getAddRulesFor())),
                                                 format(approverTabPO.getDropDownOption(),
                                                        approverData.getActivityOwner()));
    }

    private void fillInApprover(WorkflowReviewerApproverData approverData, int sectionPosition) {
        String[] approvers = approverData.getReviewer().split(COMMA);
        if (context.getScenarioContext().isContains(approvers[0])) {
            clearAndFillInValueAndSelectFromDropDown(
                    ((UserData) context.getScenarioContext().getContext(approvers[0])).getFirstName(),
                    xpath(format(approverTabPO.getApproverRuleInput(), sectionPosition, APPROVER)),
                    format(approverTabPO.getDropDownOption(),
                           ((UserData) context.getScenarioContext().getContext(approvers[0])).getFirstName()));
        } else {
            clearAndFillInValueAndSelectFromDropDown(
                    approvers[0], xpath(format(approverTabPO.getApproverRuleInput(), sectionPosition, APPROVER)),
                    format(approverTabPO.getDropDownOption(), approvers[0]));
        }
        IntStream.rangeClosed(1, approvers.length - 1).forEach(
                i -> {
                    String approver = approvers[i];
                    if (context.getScenarioContext().isContains(approver)) {
                        approver = ((UserData) context.getScenarioContext().getContext(approver)).getFirstName();
                    }
                    fillInValueAndSelectFromDropDown(approver,
                                                     xpath(format(approverTabPO.getApproverRuleInput(), sectionPosition,
                                                                  APPROVER)),
                                                     xpath(format(approverTabPO.getDropDownOption(), approver)));
                });
    }

    private void selectApproverMethod(String approverMethod, int sectionPosition) {
        clickOn(xpath(format(approverTabPO.getApproverRuleMethodRadio(), approverMethod.toUpperCase()
                                     .replace(StringUtils.SPACE, EMPTY),
                             sectionPosition)));
    }

    public String getActivityOwner() {
        return getElementTextWithWait(waitMoment, approverTabPO.getActivityOwnerValue());
    }

    public String getApprover() {
        return getElementTextWithWait(waitMoment, approverTabPO.getApproverValue());
    }

    public String getActivityDefaultApprover() {
        return getAttributeOrText(approverTabPO.getDefaultApproverInput(), VALUE);
    }

    public String getAddRulesFor() {
        return getAttributeOrText(approverTabPO.getAddRulesForInput(), VALUE);
    }

    public String getEditActivityOwner() {
        return getElementTextWithWait(waitMoment, approverTabPO.getActivityOwnerValue());
    }

    public String getEditApprover() {
        return getElementTextWithWait(waitMoment, approverTabPO.getApproverValue());
    }

    private String getEditField(int sectionPosition) {
        WebElement editField = getElement(xpath(format(approverTabPO.getApproverRuleInput(), sectionPosition,
                                                       ADD_RULES_FOR)));
        return nonNull(editField) ? editField.getAttribute(VALUE) : null;
    }

    private String getEditMultiplyField(String field, int sectionPosition) {
        return nonNull(field) ? getElementText(
                xpath(format(approverTabPO.getApproverRuleInputMultiValues(), sectionPosition, field))) : null;
    }

    private String getApproverMethod(int sectionPosition) {
        return getElementText(xpath(format(approverTabPO.getRuleOverviewSelectedMethod(), sectionPosition)));
    }

    public String getApproverMethod() {
        return getElementText(xpath(format(approverTabPO.getRuleOverviewSelectedMethod(), 1)));
    }

    public String getRuleSectionNumber(String sectionPosition) {
        return getElementText(xpath(format(approverTabPO.getApproveRule(), sectionPosition)));
    }

    public List<WorkflowReviewerApproverData> getApproverDetails() {
        return IntStream.rangeClosed(1, driver.findElements(approverTabPO.getApproveRules()).size())
                .mapToObj(i -> {
                    String resultsFor = getEditField(i);
                    return new WorkflowReviewerApproverData()
                            .setAddRulesFor(resultsFor)
                            .setActivityOwner(getEditMultiplyField(resultsFor, i))
                            .setReviewer(getEditMultiplyField(APPROVER, i))
                            .setReviewerMethod(getApproverMethod(i));
                }).collect(Collectors.toList());
    }

    public ApprovalProcessData getApprovalProcessRuleValues() {
        Map<String, String> approvalRuleData = Map.of(
                APPROVER, getEditApprover(),
                DEFAULT_APPROVER, getActivityDefaultApprover(),
                ADD_RULES_FOR, getAddRulesFor(),
                APPROVAL_METHOD, getApproverMethod(),
                ACTIVITY_OWNER, getEditActivityOwner());
        return getApprovalProcessRuleValues(approvalRuleData);
    }

    public ApprovalProcessData getApprovalProcessRuleValues(Map<String, String> approvalRuleData) {
        UserItem[] userItemsList = new UserItem[]{new UserItem().setName(approvalRuleData.get(APPROVER))};
        UsersList[] usersLists = new UsersList[]{new UsersList().setUsers(userItemsList)};
        Approvers approvers = new Approvers().setName(approvalRuleData.get(DEFAULT_APPROVER));
        String[] activityOwner = new String[]{approvalRuleData.get(ACTIVITY_OWNER)};
        return new ApprovalProcessData()
                .setApprovers(approvers)
                .setApproverProcessRules(
                        new ApproverProcessRules()
                                .setRule(approvalRuleData.get(ADD_RULES_FOR))
                                .setApprovers(usersLists)
                                .setCoverage(activityOwner)
                                .setMethod(approvalRuleData.get(APPROVAL_METHOD)));
    }

}