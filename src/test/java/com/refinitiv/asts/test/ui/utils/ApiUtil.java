package com.refinitiv.asts.test.ui.utils;

import com.intuit.karate.Results;
import com.intuit.karate.core.ScenarioResult;
import com.refinitiv.asts.core.framework.utils.TimerUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static org.testng.Assert.assertEquals;

public class ApiUtil {

    private final static Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    public static void collectAndPrintResults(Results results) {
        List<ScenarioResult> scenarioResults =
                results.getScenarioResults().filter(ScenarioResult::isFailed).collect(Collectors.toList());
        List<String> failedResults = new ArrayList<>();
        scenarioResults.forEach(scenarioResult -> scenarioResult.getStepResults().stream()
                .filter(stepResult -> stepResult.getResult().isFailed())
                .forEach(failedResult -> failedResults.add(failedResult.getErrorMessage())));

        if (failedResults.size() > 0) {
            System.out.println("======================================================");
            System.out.println("FAILED STEP RESULTS: \n" + failedResults);
            System.out.println("======================================================");
        }
        logger.info("Completed API Tests with in time: " + TimerUtils.getTime());
        logger.info("Finished RUN API Tests Step def and results failure reason phrase " + results.getErrorMessages());
        assertEquals(results.getFailCount(), 0, results.getErrorMessages());
    }

}
