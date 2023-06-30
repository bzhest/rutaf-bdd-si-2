package com.refinitiv.asts.test.ui.utils.testRail;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.APIConstants.AUTHORIZATION;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.CommonSteps.COLON;
import static io.restassured.RestAssured.given;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.isNotEmpty;
import static org.apache.http.HttpStatus.SC_OK;

public class TestRailApi {

    public static final String testRunId =
            System.getProperty("testRunId", TestRailConfig.getInstance().value("test.run.id"));
    public static final String testPlanId =
            System.getProperty("testPlanId", TestRailConfig.getInstance().value("test.plan.id"));
    public static final String testPlanEntryId = System.getProperty("testPlanEntryId", TestRailConfig.getInstance()
            .value("test.plan.entry.id"));
    private static final RequestSpecification specification = new RequestSpecBuilder()
            .setBaseUri(TestRailConfig.getInstance().value("base.url"))
            .addHeader(AUTHORIZATION, TestRailConfig.getInstance().value("authorization.key"))
            .build();
    public static final Pattern DEFECT_PATTERN = Pattern.compile("RMS-\\d+");

    public static void updateTestRun(Integer[] caseIds) {
        if (isNotEmpty(testRunId)) {
            UpdateTestRunRequest updateTestRunRequest =
                    new UpdateTestRunRequest().setCase_ids(caseIds).setInclude_all(false);
            given(specification).body(updateTestRunRequest).expect().statusCode(SC_OK).when()
                    .post(format(TestRailConfig.getInstance().value("update.run.endpoint"), testRunId));
        } else {
            throw new NullPointerException("Test Run Id is undefined. Request for test run update is not sent");
        }
    }

    public static void updatePlanEntry(Integer[] caseIds) {
        if (isNotEmpty(testPlanId) && isNotEmpty(testPlanEntryId)) {
            UpdateTestRunRequest updatePlanEntryRequest =
                    new UpdateTestRunRequest().setCase_ids(caseIds).setInclude_all(false);
            given(specification).body(updatePlanEntryRequest).expect().statusCode(SC_OK).when()
                    .post(format(TestRailConfig.getInstance().value("update.plan.endpoint"), testPlanId,
                                 testPlanEntryId));
        } else {
            throw new NullPointerException(
                    "Test Plan Id or Test Plan Entry Id are undefined. Request for test plan entry update is not sent");
        }
    }

    public static void addResultForCases(List<Integer> caseIds, int status, String comment, List<String> defectTags,
            String version) {
        if (isNotEmpty(testRunId)) {
            AddResultForCaseRequest addResultForCaseRequest = new AddResultForCaseRequest().setStatus_id(status)
                    .setComment(comment)
                    .setDefects(getDefects(status, comment, defectTags))
                    .setVersion(version);
            for (Integer caseId : caseIds) {
                given(specification)
                        .body(addResultForCaseRequest)
                        .when()
                        .post(format(TestRailConfig.getInstance().value("add.result.for.run.endpoint"), testRunId,
                                     caseId));
            }
        } else {
            throw new NullPointerException("Test Run Id is undefined. Request with test result is not sent");
        }
    }

    private static String getDefects(int status, String comment, List<String> defectTags) {
        List<String> defectsList = getDefectsFromComment(comment);
        if (status == Integer.parseInt(TestRailConfig.getInstance().value("passed.status"))) {
            defectsList.addAll(defectTags);
        }
        return defectsList.isEmpty() ? EMPTY : defectsList.stream().distinct().collect(Collectors.joining(COMMA));
    }

    private static List<String> getDefectsFromComment(String comment) {
        List<String> defects = new ArrayList<>();
        if (comment.contains(FAILED_DUE_TO_THE_BUG)) {
            Matcher m = DEFECT_PATTERN.matcher(comment);
            while (m.find()) {
                defects.add(m.group(0));
            }
        } else if (comment.contains(BLOCKED_DUE_TO_THE_ISSUE)) {
            defects.add(comment.substring(comment.lastIndexOf(COLON) + 1));
        }
        return defects;
    }

}
