package com.refinitiv.asts.test.runners;

import com.intuit.karate.Results;
import com.intuit.karate.core.*;
import com.refinitiv.asts.core.framework.api.CustomAPIHook;
import com.refinitiv.asts.core.framework.cucumber.TestContext;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;

public class APIExecutionHook implements CustomAPIHook {

    private final static Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    private TestContext testContext;

    public APIExecutionHook() {
    }

    public APIExecutionHook(TestContext testContext) {
        this.testContext = testContext;
    }

    @Override
    public void afterScenario(ScenarioRuntime scenarioRuntime) {
        //Write you custom code after Scenario code
        logger.info("In AfterScenario custom Hook.. ");
        //Write you custom after Scenario code
        //If you want to write additonal docstring details to html reports follow this:
        final com.intuit.karate.Logger logger = scenarioRuntime.logger;
        logger.info("TR Server is down .. something went wrong while logging the results ");

    }

    @Override
    public void afterScenario(ScenarioResult scenarioResult, ScenarioRuntime scenarioRuntime) {

    }

    @Override
    public void afterStep(StepResult result, ScenarioRuntime context) {
        if (testContext != null) {
            System.out.println("The Test Rail id " + testContext.getContext().get("testRailid"));
        }
//        logger.info("In AfterStep custom Hook.. ");
    }

    @Override
    public void afterFeature(FeatureResult result, FeatureRuntime runtime) {
        logger.info("In AfterFeature custom Hook.. ");

    }

    @Override
    public void beforeAll(Results results) {

    }

    @Override
    public void afterAll(Results results) {

    }

}
