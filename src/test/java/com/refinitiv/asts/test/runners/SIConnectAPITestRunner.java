package com.refinitiv.asts.test.runners;

import com.intuit.karate.Results;
import com.refinitiv.asts.core.framework.api.ApiExecutor;
import com.refinitiv.asts.core.framework.basesteps.BaseStepConfig;
import com.refinitiv.asts.core.framework.cucumber.TestContext;
import com.refinitiv.asts.core.framework.utils.TimerUtils;
import com.refinitiv.asts.core.managers.FileReaderManager;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Factory;
import org.testng.annotations.Test;

import java.lang.invoke.MethodHandles;

import static com.refinitiv.asts.test.ui.utils.ApiUtil.collectAndPrintResults;

/**
 * Test Runner exclusively for API Tests lives in TESTNG space not in Cucumber
 */
public class SIConnectAPITestRunner {

    private final static Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    public TestContext testContext;

    public SIConnectAPITestRunner(TestContext testContext) {
        this.testContext = testContext;
    }

    @BeforeClass
    public void apiSetup() throws Exception {
        System.out.println("Running the API Setup");
        logger.info("Running the API SETUP");
        new BaseStepConfig().onPrepare();
        BaseStepConfig.setUpAPI();
        logger.info("API Setup completed");
        testContext.getContext().putIfAbsent("testRailid", "334.4.32");
    }

    @Test
    public void testParallel() {
        String featureFiles = "siconnect";
        String tags = "@siconnect_api";
        logger.info("Running the SIConnect API Tests via Karate");
        logger.info("========FOUND FEATURES FILE : " + featureFiles + "==========");
        logger.info("========WITH FEATURES TAGS : " + (tags == null ? " no tags given " : tags) + "==========");
        TimerUtils.startTimer();
        Results results = ApiExecutor.getInstance()
                .runFeatures(tags,
                             FileReaderManager.getInstance()
                                     .getConfigReader()
                                     .getApiThreadCount(),
                             new APIExecutionHook(),
                             featureFiles);
        TimerUtils.stopTimer();
        collectAndPrintResults(results);
    }

    @AfterClass
    public void cleanUpAPI() {
        System.out.println("COMPLETED THE API TEST EXECUTION");
    }

    public static class APIRunnerFactory {

        private TestContext testContext;

        @Factory
        public Object[] factoryMethod() {
            this.testContext = new TestContext(); //testContext to share data between steps
            return new Object[]{new SIConnectAPITestRunner(testContext)};
        }

    }

}


