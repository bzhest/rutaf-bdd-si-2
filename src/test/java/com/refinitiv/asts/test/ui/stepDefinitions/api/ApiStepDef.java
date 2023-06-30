package com.refinitiv.asts.test.ui.stepDefinitions.api;

import com.intuit.karate.Results;
import com.refinitiv.asts.core.framework.api.ApiExecutor;
import com.refinitiv.asts.core.framework.utils.TimerUtils;
import com.refinitiv.asts.core.managers.FileReaderManager;
import com.refinitiv.asts.test.runners.APIExecutionHook;
import io.cucumber.java.ParameterType;
import io.cucumber.java.en.Given;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.refinitiv.asts.test.ui.utils.ApiUtil.collectAndPrintResults;

public class ApiStepDef {

    private static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private static final String TAG_DELIMTIER = "tags:";
    private static final String FEATURE_REGEX = "\\[.*\\]";

    /**
     * Transformation of the parameters given in a feature file
     *
     * @param tagsFeatureFile
     * @return
     */
    @ParameterType("[^\"]*")
    public Map<String, String> tagsAndFeatureFile(String tagsFeatureFile) {
        Map<String, String> featureTagsMap = new HashMap<>();
        //User has provided tags
        if (tagsFeatureFile.contains("tags")) {
            if (tagsFeatureFile.split(TAG_DELIMTIER).length > 1) {
                final String tags = tagsFeatureFile.split(TAG_DELIMTIER)[1];
                featureTagsMap.put("tags", tags);
            }
        }
        //For feature files
        final Matcher matcher = Pattern.compile(FEATURE_REGEX).matcher(tagsFeatureFile);
        if (matcher.find()) {
            final String features = matcher.group().replaceAll("[:\\[,\\]]", "");
            featureTagsMap.put("featurefiles", features);
        }

        return featureTagsMap;
    }

    @Given("Run API Tests {string}")
    public void runAPIFeatures(String featureFile) {
        logger.info(
                "Running the API Tests via Karate \n" + "========FOUND FEATURES FILE : " + featureFile + "==========");
        TimerUtils.startTimer();
        Results results = ApiExecutor.getInstance()
                .runFeatures(FileReaderManager.getInstance().getConfigReader().getApiThreadCount(), featureFile);
        TimerUtils.stopTimer();
        collectAndPrintResults(results);

    }

    @Given("Run API Tests {string},{string}")
    public void runApiTestsWithTags(String featureFile, String tags) {
        logger.info(
                "Running the API Tests via Karate \n" + "========FOUND FEATURES FILE : " + featureFile + "==========");
        logger.info("========WITH FEATURES TAGS : " + tags + "==========");
        TimerUtils.startTimer();
        Results results = ApiExecutor.getInstance()
                .runFeatures(tags, FileReaderManager.getInstance().getConfigReader().getApiThreadCount(), featureFile);
        TimerUtils.stopTimer();
        collectAndPrintResults(results);

    }

    //    @Given("Run API Tests with custom hooks")
    public void runApiTestsWithCustomHooks(String featureFile, String tags) {
        logger.info(
                "Running the API Tests via Karate \n" + "========FOUND FEATURES FILE : " + featureFile + "==========");
        logger.info("========WITH FEATURES TAGS : " + tags + "==========");
        TimerUtils.startTimer();
        Results results = ApiExecutor.getInstance()
                .runFeatures(FileReaderManager.getInstance().getConfigReader().getApiThreadCount(),
                             new APIExecutionHook(), featureFile);
        TimerUtils.stopTimer();
        collectAndPrintResults(results);

    }

    @Given("Run API Tests with custom hooks {tagsAndFeatureFile}")
    public void runApiTestsWithTagsAndCustomHooks(Map<String, String> featureTagsInfo) {
        String featureFiles = featureTagsInfo.get("featurefiles");
        String tags = featureTagsInfo.get("tags");
        logger.info(
                "Running the API Tests via Karate \n" + "========FOUND FEATURES FILE : " + featureFiles + "==========");
        logger.info("========WITH FEATURES TAGS : " + (tags == null ? " no tags given " : tags) + "==========");
        TimerUtils.startTimer();
        Results results = ApiExecutor.getInstance()
                .runFeatures(tags, FileReaderManager.getInstance().getConfigReader().getApiThreadCount(),
                             new APIExecutionHook(), featureFiles);
        TimerUtils.stopTimer();
        collectAndPrintResults(results);

    }

}
