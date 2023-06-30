package com.refinitiv.asts.test.ui.stepDefinitions;

import com.fasterxml.jackson.databind.JsonNode;
import com.refinitiv.asts.core.framework.basesteps.BaseStepConfig;
import com.refinitiv.asts.core.framework.basesteps.ConfigureDriver;
import com.refinitiv.asts.core.framework.constants.GlobalConst;
import com.refinitiv.asts.core.framework.cucumber.ScenarioContext;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.core.framework.drivers.CreateDriver;
import com.refinitiv.asts.core.framework.drivers.DriverFactory;
import com.refinitiv.asts.core.framework.enums.EnvironmentType;
import com.refinitiv.asts.core.framework.utils.ApiUtils;
import com.refinitiv.asts.core.framework.utils.JsonUtils;
import com.refinitiv.asts.core.managers.FileReaderManager;
import com.refinitiv.asts.core.managers.GridManager;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.*;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ObjectsItem;
import com.refinitiv.asts.test.ui.api.model.emailManagement.EmailTemplatesResponse;
import com.refinitiv.asts.test.ui.api.model.organisation.clientOrganisation.ClientOrganisationResponse;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnaireRequest;
import com.refinitiv.asts.test.ui.api.model.questionnaires.QuestionnairesResponseData;
import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.ApproverProcessRulesItem;
import com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse.WorkFlowItem;
import com.refinitiv.asts.test.ui.dataproviders.DataProvider;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.Languages;
import com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.renewalSettings.WorkflowManagementRenewalPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.CommonSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.CountryChecklistSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.util.ScenarioExecutionHandler;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessDataAPI;
import com.refinitiv.asts.test.ui.utils.email.EmailUtil;
import com.refinitiv.asts.test.ui.utils.email.gmail.GmailUtil;
import com.refinitiv.asts.test.ui.utils.testRail.TestRailApi;
import com.refinitiv.asts.test.ui.utils.testRail.TestRailConfig;
import com.refinitiv.asts.test.utils.FileUtil;
import io.cucumber.java.After;
import io.cucumber.java.AfterStep;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.plugin.event.Result;
import lombok.SneakyThrows;
import org.apache.commons.lang3.ClassUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.util.Strings;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;

import javax.mail.Message;
import java.io.File;
import java.lang.invoke.MethodHandles;
import java.lang.reflect.Field;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildInactivateQuestionnaireRequest;
import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildReviewProcessRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.USERS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.api.AppApi.ZERO;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.deleteGroup;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getGroupIdByName;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.STOP_ONBOARDING;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.SYSTEM_ADMINISTRATOR;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.constants.UserRoleConst.ADMIN;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.APPROVAL;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.REVIEW;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.ENORMOUS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getCurrentMillis;
import static com.refinitiv.asts.test.ui.utils.email.gmail.EmailConfig.isGmailEmailUtil;
import static com.refinitiv.asts.test.ui.utils.testRail.TestRailApi.DEFECT_PATTERN;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static java.nio.file.Files.readAllLines;
import static java.util.Arrays.asList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.isNotEmpty;
import static org.testng.util.Strings.isNullOrEmpty;

public class BaseStepDef {

    private static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private static final Path scenariosFilePath =
            Paths.get(System.getProperty("user.dir"), "src", "test", "resources", "scenarios",
                      "scenariosIds.txt");
    public static final String RFG = "RFG";
    public static final TestRailConfig testRailConfig = TestRailConfig.getInstance();
    private final Pattern caseIdPattern = Pattern.compile("C(\\d{2,})");
    private ConfigureDriver configDriver;
    private Scenario scenario;
    public ScenarioCtxtWrapper context;

    public BaseStepDef(ScenarioCtxtWrapper context) {
        this.context = context;
    }

    /**
     * OnPrepareHook is the cucumber before Hook which does setup & configuration of driver, scenarioContext & config related
     */
    @Before(order = 1)
    public void onPrepare(Scenario scenario) throws Exception {
        BaseStepConfig baseStepConfig = new BaseStepConfig();
        baseStepConfig.onPrepare();
        logger.info("On Prepare Hook for both UI & API Started");
        this.scenario = scenario;
        context.setScenarioContext(new ScenarioContext(scenario));
        context.getScenarioContext().setContext(START_TIME, getCurrentMillis());
        new ApiClient().setUp();
        logger.debug("On Prepare Hook Finished");
    }

    @Before(value = "@ui", order = 2)
    public synchronized void launchBrowser() throws Exception {
        logger.info("Launch Browser for UI started");
        configDriver = ConfigureDriver.getInstance();
        //Set the configProperties
        System.setProperty("elementExistsTimeOut", BaseStepDef.getConfigProp().getProperty("elementExistsTimeOut"));
        if (FileReaderManager.getInstance().getConfigReader().getEnvironment().equals(EnvironmentType.REMOTE)) {
            //Fetch the Hub URL and check if the HUB is running.. For Ex: //http://localhost:4444/grid/console
            final JsonNode jsonContent = JsonUtils.getJSONDocument(GlobalConst.PROPERTIES_PATH + "/hubConfig.json");
            String hubUrl = "http://" + jsonContent.get("host").asText() + ":" + jsonContent.get("port").asText() +
                    "/grid/console";
            if (ApiUtils.getHttpResponseCode(hubUrl) != 200) {
                GridManager.createInstance().startHub();
            }
        }
        if (null != configDriver) {
            logger.warn("Config Driver was null, hence setting up the driver again");
            configDriver.setUpDriver();
        }
        logger.info("Launch Browser for UI finished");
        logger.info("Start Scenario execution: \n" + this.scenario.getName());
        logger.info("Current Java version is: " + System.getProperty("java.version"));
    }

    @Before(value = "@api", order = 1)
    public synchronized void setUpKarateConfig() {
        logger.info("Cukes Setup Hook for API started");
        if (configDriver == null) {
            logger.warn("Config Driver was null, hence setting up the driver again");
            configDriver = ConfigureDriver.getInstance();
        }
        BaseStepConfig.setUpAPI();
        logger.info("Cukes Setup Hook for API Finished");
    }

    @Before(value = "@desktop", order = 2)
    public void launchDesktop() throws Exception {
        CreateDriver.getInstance().startWinAppDriver(); //Starts with root capabilities
        logger.info("WinAppDriver Started ");
    }

    @After(order = 1)
    public synchronized void logTestResults() {
        logTestRailResults();
        ScenarioExecutionHandler.saveFailedScenarioFilter(this.scenario);
    }

    @SneakyThrows
    @After(value = "@ui", order = 0)
    public void postCondition() {
        logger.info("Start test data clean up: ");
        cleanUpThirdParty();
        cleanUpGroupName();
        cleanUpCustomFields();
        cleanUpCustomField();
        cleanUpEmail();
        cleanUpCountryChecklist();
        inactivateWorkflow();
        cleanUpWorkflowGroup();
        setDefaultActivityApproversForWorkflow();
        cleanKeyPrincipleDataContext();
        inactivateUser();
        cleanUpRenewalSettingsAssigneeRule();
        deleteReviewProcess();
        deleteApprovalProcess();
        rollbackEmailTemplate();
        inactivateQuestionnaire();
        setUpInitialUserSetting();
        revertOrganisationDefaultName();
        deleteDownloadedFile();
        deleteContactCreatedByExternalUser();
        cleanUpRoles();
        deleteValues();
        setUpDefaultFieldValues();
        setUpDefaultLanguage();
        createDeletedProcess();
        configDriver.quitTheDriver();
    }

    @After(value = "@desktop")
    public void stopDesktopDriver() throws Exception {
        CreateDriver.getInstance().stopWinAppDriver();
        logger.info("WinAppDriver Stopped ");
    }

    @AfterStep(value = "@ui")
    public void cleanUpStep(Scenario scenario) {
        captureScreenshot(scenario);
    }

    public static Properties getConfigProp() {
        return BaseStepConfig.getConfigProp();
    }

    public static List<String> getFilteredTags(Scenario scenario, Pattern pattern, int group) {
        return scenario.getSourceTagNames().stream().map(tag -> {
            Matcher matcher = pattern.matcher(tag);
            if (matcher.find()) {
                return matcher.group(group);
            }
            return null;
        }).filter(Objects::nonNull).collect(Collectors.toList());
    }

    private String takeSnapshot() {
        if (null == CreateDriver.getInstance().getDriver()) {
            return "";
        }
        WebDriver driver = CreateDriver.getInstance().getDriver();
        String screenshotName = "ScreenShot_" + new Random().nextInt(1000);
        try {
            byte[] screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
            this.scenario.attach(screenshot, "image/png", screenshotName);
        } catch (TimeoutException e) {
            logger.info("Error during screenshot capture");
        }
        return screenshotName;
    }

    private void captureScreenshot(Scenario scenario) {
        //Capture Screenshot for every step.
        if (FileReaderManager.getInstance().getConfigReader().isCaptureScreenshotForEveryStep()) {
            //Capture screenshot only for UI test
            takeSnapshot();
        }
        if (scenario.isFailed()) {
            logger.error("The test has failed... screen shot to be taken! " + takeSnapshot());
        }
    }

    private void cleanUpThirdParty() {
        if (this.context.getScenarioContext().isContains(THIRD_PARTY_ID)) {
            String thirdPartyID = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_ID);
            if (this.context.getScenarioContext().isContains(IS_ONBOARDING_STARTED)) {
                patchWorkflowAction(thirdPartyID, STOP_ONBOARDING);
            }
            if (nonNull(thirdPartyID)) {
                SIPublicApi.deleteThirdParty(thirdPartyID);
                logger.info("Third-party with ID " + thirdPartyID + " is deleted!");
            }
        }
    }

    private void cleanKeyPrincipleDataContext() {
        this.context.getScenarioContext().setContext(KEY_PRINCIPLE_DATA, null);
    }

    private void cleanUpGroupName() {
        int groupIndex = 0;
        while (this.context.getScenarioContext().isContains(USER_GROUP_NAME_CONTEXT + groupIndex)) {
            String groupName =
                    (String) this.context.getScenarioContext().getContext(USER_GROUP_NAME_CONTEXT + groupIndex);
            deleteGroup(getGroupIdByName(groupName));
            logger.info("Group with name " + groupName + " is deleted!");
            groupIndex++;
        }
    }

    private void cleanUpCustomField() {
        String fieldId = Strings.EMPTY;
        if (this.context.getScenarioContext().isContains(CUSTOM_FIELD_ID_CONTEXT)) {
            fieldId = (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_ID_CONTEXT);
        } else if (this.context.getScenarioContext().isContains(CUSTOM_FIELD_NAME_CONTEXT)) {
            String fieldName =
                    (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_CONTEXT);
            fieldId = ConnectApi.getCustomFieldId(fieldName);
        }
        deleteCustomField(fieldId);
    }

    private void cleanUpCustomFields() {
        String fieldId;
        if (this.context.getScenarioContext().isContains(CUSTOM_FIELD_INDEX_CONTEXT)) {
            int numberOfAddedCustomFields =
                    (int) this.context.getScenarioContext().getContext(CUSTOM_FIELD_INDEX_CONTEXT);
            for (int i = 1; i <= numberOfAddedCustomFields; i++) {
                String fieldName =
                        (String) this.context.getScenarioContext().getContext(CUSTOM_FIELD_NAME_NUMBER_CONTEXT + i);
                fieldId = ConnectApi.getCustomFieldId(fieldName);
                deleteCustomField(fieldId);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void cleanUpEmail() {
        if (this.context.getScenarioContext().isContains(DELETE_EMAIL_FLAG_CONTEXT) && isGmailEmailUtil()) {
            EmailUtil emailUtil = (EmailUtil) context.getScenarioContext().getContext(EMAIL_UTIL);
            if (nonNull(emailUtil) && emailUtil instanceof GmailUtil) {
                List<Message> messages = (List<Message>) context.getScenarioContext().getContext(EMAILS_TO_DELETE);
                ((GmailUtil) emailUtil).deleteAllMessages(messages);
            }
        }
    }

    private void cleanUpCountryChecklist() {
        if (this.context.getScenarioContext().isContains(COUNTRY_CHECKLIST_NAME_CONTEXT)) {
            String fieldName = (String) this.context.getScenarioContext()
                    .getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
            String listId = ConnectApi.getCountryChecklistId(fieldName);
            if (nonNull(listId)) {
                ConnectApi.deleteCountryChecklist(listId);
                logger.info("Country checklist with ID " + listId + " is deleted!");
            }
        }
        if (this.context.getScenarioContext().isContains(COUNTRY_CHECKLIST_CONTEXT_NUMBER)) {
            int contextNumber = (int) this.context.getScenarioContext().getContext(COUNTRY_CHECKLIST_CONTEXT_NUMBER);
            for (int i = 0; i < contextNumber; i++) {
                CountryChecklistSteps.countryChecklistNameContextWithNumber =
                        COUNTRY_CHECKLIST_NAME_CONTEXT_WITHOUT_NUMBER + (i + 1);
                String fieldName = (String) this.context.getScenarioContext()
                        .getContext(CountryChecklistSteps.countryChecklistNameContextWithNumber);
                String listId = ConnectApi.getCountryChecklistId(fieldName);
                if (nonNull(listId)) {
                    ConnectApi.deleteCountryChecklist(listId);
                    logger.info("Country checklist with ID " + listId + " is deleted!");
                }
            }
        }
    }

    private void cleanUpWorkflowGroup() {
        if (this.context.getScenarioContext().isContains(WORKFLOW_GROUP_NAME_CONTEXT)) {
            String groupName = (String) this.context.getScenarioContext()
                    .getContext(WORKFLOW_GROUP_NAME_CONTEXT);
            String groupId = WorkflowApi.getWorkflowGroupIdByName(groupName);
            if (nonNull(groupId)) {
                WorkflowApi.deleteWorkflowGroup(groupId);
            }
        }
    }

    private void inactivateWorkflow() {
        if (this.context.getScenarioContext().isContains(WORKFLOW_INACTIVATE_FLAG_CONTEXT)) {
            String workflowName =
                    (String) this.context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
            WorkFlowItem workflow = WorkflowApi.getWorkflowByName(workflowName);
            if (nonNull(workflow)) {
                workflow.setStatus("Inactive");
                WorkflowApi.updateWorkflow(workflow, workflow.getId());
            }
        }
    }

    private void setDefaultActivityApproversForWorkflow() {
        if (this.context.getScenarioContext().isContains(WORKFLOW_NAME_CONTEXT)) {
            String workflowName =
                    (String) this.context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
            WorkFlowItem workflow = null;
            try {
                workflow = getWorkflows(ENORMOUS_ITEMS_PER_PAGE, _ID, ASC)
                        .getObjects()
                        .stream()
                        .filter(o -> o.getName().equals(workflowName))
                        .findFirst()
                        .orElse(null);
            } catch (NullPointerException | NoSuchElementException | IllegalArgumentException ex) {
                logger.error("Workflow with name '" + workflowName + "' doesn't exist");
            }
            if (nonNull(workflow) && !workflow.getWorkflowComponents().isEmpty()) {
                try {
                    ApproverProcessRulesItem rule =
                            workflow.getWorkflowComponents().get(0).getActivities().get(0).getApproverProcessRules()
                                    .get(0);
                    rule.setApprovers(Collections.emptyList());
                    rule.setCoverage(Collections.emptyList());
                    rule.setRule(null);
                    WorkflowApi.updateWorkflow(workflow, workflow.getId());
                } catch (IndexOutOfBoundsException e) {
                    logger.error("Workflow's approver with name " + workflowName + " is not updated!");
                }

            }
        }
    }

    private void inactivateUser() {
        if (context.getScenarioContext().isContains(USER_FIRST_NAME)) {
            String userFirstName = (String) context.getScenarioContext().getContext(USER_FIRST_NAME);
            List<UserData> userList = getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload()
                    .getData().stream()
                    .filter(user -> user.getStatus().equals(ACTIVE.getStatus()) &&
                            userFirstName.equals(user.getFirstName()))
                    .collect(Collectors.toList());
            if (!userList.isEmpty()) {
                UserAppApiPayload.UserPayload userPayload = getUserDataById(userList.get(0).getId()).getPayload();
                userPayload.setActive(false);
                updateUser(userPayload);
                logger.info("User with first name " + userFirstName + " is inactivated!");
            }

        }
    }

    private void setUpInitialUserSetting() {
        if (context.getScenarioContext().isContains(USER_PAYLOAD)) {
            UserAppApiPayload.UserPayload payload =
                    (UserAppApiPayload.UserPayload) context.getScenarioContext().getContext(USER_PAYLOAD);
            updateUser(payload);
            logger.info("User's setting were restored to initial");
        }
    }

    private void cleanUpRenewalSettingsAssigneeRule() {
        WebDriver driver = DriverFactory.getDriver();
        WorkflowManagementRenewalPage renewalSettingsPage = new WorkflowManagementRenewalPage(driver);
        if (this.context.getScenarioContext().isContains(RENEWAL_SETTINGS_LAST_ADDED_RULE)) {
            String ruleNumber =
                    (String) this.context.getScenarioContext().getContext(RENEWAL_SETTINGS_LAST_ADDED_RULE);
            renewalSettingsPage.navigateToWorkflowRenewalSettings();
            renewalSettingsPage.waitWhilePreloadProgressbarIsDisappeared();
            renewalSettingsPage.clickRemoveRuleIconForRuleWithIndex(ruleNumber);
            renewalSettingsPage.deleteRedundantRuleValues("1");
            renewalSettingsPage.clickSaveButton();
            renewalSettingsPage.waitWhilePreloadProgressbarIsDisappeared();
            int ruleNumberOnUI = Integer.parseInt(ruleNumber);
            logger.info(
                    "Renewal Settings Last added Assignee Rule with number " + ruleNumberOnUI + " is deleted!");
        }
        if (this.context.getScenarioContext().isContains(RENEWAL_SETTINGS_RULES_COUNTER)) {
            int ruleCounter = (Integer) this.context.getScenarioContext().getContext(RENEWAL_SETTINGS_RULES_COUNTER);
            renewalSettingsPage.navigateToWorkflowRenewalSettings();
            renewalSettingsPage.waitWhilePreloadProgressbarIsDisappeared();
            for (int i = ruleCounter; i > 0; i--) {
                String ruleNumber =
                        (String) this.context.getScenarioContext().getContext(RENEWAL_SETTINGS_ADDED_RULE_NUMBER + i);
                renewalSettingsPage.clickRemoveRuleIconForRuleWithIndex(ruleNumber);
                int ruleNumberOnUI = Integer.parseInt(ruleNumber);
                logger.info(
                        "Renewal Settings Last added Assignee Rule with number " + ruleNumberOnUI + " is deleted!");
            }
            renewalSettingsPage.deleteRedundantRuleValues("1");
            renewalSettingsPage.clickSaveButton();
            renewalSettingsPage.waitWhilePreloadProgressbarIsDisappeared();
        }
    }

    private void deleteReviewProcess() {
        if (context.getScenarioContext().isContains(REVIEW_PROCESSES_NAMES_LIST)) {
            List<String> reviewProcessNames =
                    (List<String>) this.context.getScenarioContext().getContext(REVIEW_PROCESSES_NAMES_LIST);
            for (String reviewProcessName : reviewProcessNames) {
                if (nonNull(reviewProcessName)) {
                    ObjectsItem reviewItem = getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW).getObjects()
                            .stream()
                            .filter(review -> review.getName().equals(reviewProcessName)).findFirst().orElse(null);
                    if (nonNull(reviewItem)) {
                        deleteProcessRule(reviewItem.getId());
                    }
                }
            }

        }
    }

    private void deleteApprovalProcess() {
        if (context.getScenarioContext().isContains(APPROVAL_PROCESS_NAME_CONTEXT)) {
            String processName =
                    (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
            String processID = WorkflowApi.getProcessRules(1000, 0, APPROVAL).getObjects().stream()
                    .filter(process -> process.getName().equals(processName)).map(ObjectsItem::getId)
                    .findFirst()
                    .orElse(null);
            if (nonNull(processID)) {
                WorkflowApi.deleteProcessRule(processID);
            }
        }
    }

    private void rollbackEmailTemplate() {
        if (context.getScenarioContext().isContains(INITIAL_EMAIL_TEMPLATE)) {
            EmailTemplatesResponse.EmailTemplate initialEmailTemplate =
                    (EmailTemplatesResponse.EmailTemplate) context.getScenarioContext()
                            .getContext(INITIAL_EMAIL_TEMPLATE);
            postEmailTemplates(initialEmailTemplate);
            logger.info("Email Template " + initialEmailTemplate.getName() + " was updated!");
        }
    }

    private void logTestRailResults() {
        if (isNotEmpty(TestRailApi.testRunId)) {
            logger.info(format("Log scenario result to TestRail: '%s'", this.scenario.getName()));
            List<Integer> allScenarioIds = getSavedScenarioIds();
            List<Integer> currentScenarioIds = getFilteredTags(this.scenario, caseIdPattern, 1)
                    .stream().map(Integer::parseInt)
                    .collect(Collectors.toList());
            allScenarioIds.addAll(currentScenarioIds);
            saveScenarioIdsToFile(allScenarioIds);
            boolean isNewTestExecution = parseBoolean(
                    System.getProperty("isNewTestExecution", testRailConfig.value("is.new.test.execution")));
            boolean isTestPlanCreated =
                    parseBoolean(System.getProperty("isTestPlanCreated", testRailConfig.value("is.test.plan.created")));

            if (isNewTestExecution) {
                if (isTestPlanCreated) {
                    addScenariosToTestRailPlanEntry(allScenarioIds);
                } else {
                    addScenariosToTestRailRun(allScenarioIds);
                }
            }

            sendScenarioResultsToTestRail(currentScenarioIds);
            logger.info(format("Scenario '%s' result was sent to TestRail run", this.scenario.getName()));
        }
    }

    private void addScenariosToTestRailRun(List<Integer> allScenarioIds) {
        Integer[] allScenarioIdsArray = allScenarioIds.toArray(new Integer[0]);
        TestRailApi.updateTestRun(allScenarioIdsArray);
        logger.info("Scenarios list was sent to TestRail Run: " + TestRailApi.testRunId);
    }

    private void addScenariosToTestRailPlanEntry(List<Integer> allScenarioIds) {
        Integer[] allScenarioIdsArray = allScenarioIds.toArray(new Integer[0]);
        TestRailApi.updatePlanEntry(allScenarioIdsArray);
        logger.info(
                format("Scenarios list was sent to TestRail Plan: '%s' and its Entry: '%s' ", TestRailApi.testPlanId,
                       TestRailApi.testPlanEntryId));
    }

    private void sendScenarioResultsToTestRail(List<Integer> currentScenarioIds) {
        int scenarioStatus;
        String comment =
                format("%s\nAuto Scenario Name: %s", this.scenario.getStatus().name(), this.scenario.getName());
        String version = context.getScenarioContext().isContains(VERSION) ?
                (String) context.getScenarioContext().getContext(VERSION) : Strings.EMPTY;
        if (!this.scenario.isFailed() && this.scenario.getStatus().name().equals("PASSED")) {
            scenarioStatus = Integer.parseInt(testRailConfig.value("passed.status"));
        } else {
            Throwable error = getScenarioError(this.scenario);
            if (nonNull(error.getMessage()) && error.getMessage().contains(BLOCKED_DUE_TO_THE_ISSUE)) {
                scenarioStatus = Integer.parseInt(testRailConfig.value("blocked.status"));
                comment = format("%s\nAuto Scenario Blocker: %s", comment, error.getMessage());
            } else if (nonNull(error.getMessage()) && error.getMessage().contains(NOT_APPLICABLE_STATUS)) {
                scenarioStatus = Integer.parseInt(testRailConfig.value("not.applicable.status"));
                comment = format("%s\nAuto Scenario Not Applicable Reason: %s", comment, error.getMessage());
            } else {
                scenarioStatus = Integer.parseInt(testRailConfig.value("failed.status"));
                comment = format("%s\nAuto Scenario Exception: %s", comment, error.getMessage());
                StackTraceElement[] stackTrace = error.getStackTrace();
                if (stackTrace.length != 0) {
                    comment = format("%s\nAuto Scenario Stack Trace: %s", comment, Arrays.toString(stackTrace));
                }
            }
        }
        TestRailApi.addResultForCases(currentScenarioIds, scenarioStatus, comment,
                                      getFilteredTags(scenario, DEFECT_PATTERN, 0), version);
    }

    @SuppressWarnings("unchecked")
    public static Throwable getScenarioError(Scenario scenario) {
        try {
            Class<?> clasz = ClassUtils.getClass("io.cucumber.java.Scenario");
            Field fieldScenario = FieldUtils.getField(clasz, "delegate", true);
            if (fieldScenario != null) {

                fieldScenario.setAccessible(true);
                Object objectScenario = fieldScenario.get(scenario);

                Field fieldStepResults = objectScenario.getClass().getDeclaredField("stepResults");
                fieldStepResults.setAccessible(true);

                ArrayList<Result> results = (ArrayList<Result>) fieldStepResults.get(objectScenario);
                for (Result result : results) {
                    if (result.getError() != null) {
                        return result.getError();
                    }
                }
            }
            return new Throwable();

        } catch (IllegalAccessException | NoSuchFieldException | ClassNotFoundException e) {
            return new Throwable();
        }
    }

    @SuppressWarnings("unchecked")
    private void inactivateQuestionnaire() {
        if (context.getScenarioContext().isContains(QUESTIONNAIRE_TEST_DATA)) {
            GenericTestData<QuestionnaireData> questionnaireTestData =
                    (GenericTestData<QuestionnaireData>) this.context.getScenarioContext()
                            .getContext(QUESTIONNAIRE_TEST_DATA);
            String questionnaireName = questionnaireTestData.getDataToEnter().getQuestionnaireName();
            inactivateQuestionnaire(questionnaireName);
        }
        if (context.getScenarioContext().isContains(CLONED_QUESTIONNAIRE_NAME)) {
            String clonedQuestionnaire =
                    (String) this.context.getScenarioContext().getContext(CLONED_QUESTIONNAIRE_NAME);
            inactivateQuestionnaire(clonedQuestionnaire);
        }
    }

    private void inactivateQuestionnaire(String questionnaireName) {
        QuestionnairesResponseData questionnaireData = WorkflowApi.getActiveQuestionnaires().stream()
                .filter(questionnaire -> questionnaire.getName().equals(questionnaireName)).findFirst().orElse(null);
        if (nonNull(questionnaireData)) {
            QuestionnaireRequest questionnaireToInactivate = buildInactivateQuestionnaireRequest(questionnaireData);
            WorkflowApi.inactivateQuestionnaire(questionnaireData.getId(), questionnaireToInactivate);
        }
    }

    private void revertOrganisationDefaultName() {
        if (context.getScenarioContext().isContains(MY_ORGANISATION_SHOULD_REVERT_FLAG)) {
            ClientOrganisationResponse organizationResponse = retrieveClientOrganization();
            organizationResponse.getPayload().setName(RFG);
            updateClientOrganization(organizationResponse.getPayload());
        }
    }

    private void deleteDownloadedFile() {
        if (this.context.getScenarioContext().isContains(DOWNLOADED_FILE_NAME)) {
            String fileName = (String) this.context.getScenarioContext().getContext(DOWNLOADED_FILE_NAME);
            FileUtil.deleteDownloadedFile(fileName);
        }
    }

    private void deleteContactCreatedByExternalUser() {
        if (context.getScenarioContext().isContains(EXTERNAL_USER_FIRST_NAME) &&
                context.getScenarioContext().isContains(CONTACT_ID)) {
            String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
            String contactId = (String) context.getScenarioContext().getContext(CONTACT_ID);
            String loggedInUser = (String) context.getScenarioContext().getContext(USER_REFERENCE);
            if (!loggedInUser.equalsIgnoreCase(ADMIN)) {
                new CommonSteps(this.context).logInAs(ADMIN);
            }
            if (nonNull(contactId) && nonNull(thirdPartyId)) {
                SIPublicApi.deleteContact(contactId, thirdPartyId);
            }
        }
    }

    private void cleanUpRoles() {
        int roleIndex = 1;
        if (context.getScenarioContext().isContains(USER_ROLE_TITLE)) {
            String roleName = (String) context.getScenarioContext().getContext(USER_ROLE_TITLE);
            deleteRole(roleName);
        }
        while (context.getScenarioContext().isContains(USER_ROLE_TITLE + roleIndex)) {
            String roleName = (String) context.getScenarioContext().getContext(USER_ROLE_TITLE + roleIndex);
            deleteRole(roleName);
            roleIndex++;
        }
    }

    private void deleteRole(String roleName) {
        if (nonNull(roleName) && !roleName.equals(SYSTEM_ADMINISTRATOR) && roleName.startsWith(AUTO_TEST_NAME_PREFIX)) {
            AppApi.deleteRole(roleName);
            logger.info(format("Role: %s is deleted!", roleName));
        }
    }

    private void setUpDefaultFieldValues() {
        if (context.getScenarioContext().isContains(ARE_DEFAULT_THIRD_PARTY_FIELDS_CHANGED)) {
            SIPublicApi.setThirdPartyFieldsManagementToDefault();
        }
    }

    @SuppressWarnings("unchecked")
    private void deleteValues() {
        if (this.context.getScenarioContext().isContains(VALUES_TO_DELETE)) {
            RefDataResponse refDataResponse =
                    (RefDataResponse) this.context.getScenarioContext().getContext(VALUE_CATEGORY_ID);
            List<String> categoriesToDelete =
                    (List<String>) this.context.getScenarioContext().getContext(VALUES_TO_DELETE);
            List<Value> listValues = asList(getRefDataPayload(refDataResponse.get_id()).getListValues());
            categoriesToDelete.forEach(categoryName -> {
                Value value = listValues.stream().filter(result -> result.getName().equals(categoryName))
                        .findFirst().orElse(null);
                if (nonNull(value)) {
                    logger.info(format("Questionnaire Category '%s' is deleted with response: %s", categoryName,
                                       deleteRefData(refDataResponse, value.get_id())));
                }
            });
        }
    }

    @SneakyThrows
    private List<Integer> getSavedScenarioIds() {
        File scenarioIdsFile = new File(Objects.requireNonNull(scenariosFilePath).toString());
        if (scenarioIdsFile.exists()) {
            return readAllLines(scenarioIdsFile.toPath()).stream().map(Integer::parseInt).collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

    @SneakyThrows
    private void saveScenarioIdsToFile(List<Integer> allScenarioIds) {
        Set<String> allScenarioIdsInString = allScenarioIds.stream().map(Object::toString).collect(
                Collectors.toSet());
        String scenarioDirectoryPath = Objects.requireNonNull(scenariosFilePath).getParent().toString();
        File scenarioDirectory = new File(scenarioDirectoryPath);
        if (!scenarioDirectory.exists()) {
            scenarioDirectory.mkdir();
        }
        Files.write(scenariosFilePath, allScenarioIdsInString, Charset.defaultCharset());
    }

    private void deleteCustomField(String fieldId) {
        if (!isNullOrEmpty(fieldId)) {
            ConnectApi.deleteCustomField(fieldId);
        }
    }

    private void setUpDefaultLanguage() {
        String envLanguage = BaseStepDef.getConfigProp().getProperty("language");
        if (!envLanguage.equals(Languages.EN.getCode()) || context.getScenarioContext().isContains(CHANGED_LANGUAGE)) {
            UserData userTestData = new UserData();
            if (!envLanguage.equals(Languages.EN.getCode())) {
                userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);

            } else if (context.getScenarioContext().isContains(CHANGED_LANGUAGE)) {
                userTestData = (UserData) context.getScenarioContext().getContext(CHANGED_LANGUAGE_USER_DATA);
            }
            UserAppApiPayload userDataByEmail = getUserDataByEmail(userTestData.getUsername());
            String languageToReplace = Languages.EN.getApiCode();
            updateUser(userDataByEmail.getPayload().setLanguagePreference(
                    new UserAppApiPayload.UserPayload.LanguagePreference().setLanguageId(languageToReplace)));
        }

    }

    private void createDeletedProcess() {
        if (context.getScenarioContext().isContains(CREATE_DELETED_PROCESS)) {
            ReviewProcessDataAPI reviewProcessData =
                    new JsonUiDataTransfer<ReviewProcessDataAPI>(DataProvider.REVIEW_PROCESS_API).getTestData()
                            .get("Auto Review Process")
                            .getDataToEnter();
            reviewProcessData.getReviewers().setEmail(Config.get().value(reviewProcessData.getReviewers().getEmail()));
            WorkflowApi.postReviewProcessRule(buildReviewProcessRequest(reviewProcessData));
        }
    }

}