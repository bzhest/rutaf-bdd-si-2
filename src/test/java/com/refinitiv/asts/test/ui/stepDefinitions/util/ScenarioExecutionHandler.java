package com.refinitiv.asts.test.ui.stepDefinitions.util;

import com.refinitiv.asts.core.managers.FileReaderManager;
import io.cucumber.java.Scenario;
import lombok.SneakyThrows;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.lang.invoke.MethodHandles;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.regex.Pattern;

import static com.refinitiv.asts.test.ui.constants.TestConstants.BLOCKED_DUE_TO_THE_ISSUE;
import static com.refinitiv.asts.test.ui.constants.TestConstants.FAILED_DUE_TO_THE_BUG;
import static com.refinitiv.asts.test.ui.stepDefinitions.BaseStepDef.getFilteredTags;
import static com.refinitiv.asts.test.ui.stepDefinitions.BaseStepDef.getScenarioError;
import static java.lang.Boolean.parseBoolean;
import static java.lang.String.format;
import static java.nio.file.Files.readString;
import static java.util.Objects.nonNull;

public class ScenarioExecutionHandler {

    private static final Logger LOGGER = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private static final boolean RERUN_FAILED_SCENARIOS = parseBoolean(
            System.getProperty("rerunFailedScenarios",
                               FileReaderManager.getInstance().getConfigReader().getProperty("rerunFailedScenarios")));
    private static final Path FAILED_SCENARIOS_FILE_PATH = Paths.get(System.getProperty("user.dir"),
                                                                     "src", "test", "resources", "scenarios",
                                                                     "failedScenariosTags.txt");
    private static final String OR = " or ";
    private static final Pattern CASE_TAG_PATTERN = Pattern.compile("(@C\\d{2,})");

    public static void saveFailedScenarioFilter(Scenario scenario) {
        if (RERUN_FAILED_SCENARIOS && scenario.isFailed()) {
            List<String> currentFailedScenarioTags = getCurrentFailedScenarioTags(scenario);
            if (!currentFailedScenarioTags.isEmpty()) {
                LOGGER.info(format("Save failed test tags for rerun: '%s'", scenario.getName()));
                String savedScenarioTags = getSavedScenarioTags();
                StringBuilder tagFilterBuilder = new StringBuilder(savedScenarioTags);
                currentFailedScenarioTags.forEach(tag -> {
                    if (savedScenarioTags.isEmpty() && tagFilterBuilder.length() == 0) {
                        tagFilterBuilder.append(tag);
                    } else {
                        if (!savedScenarioTags.contains(tag)) {
                            tagFilterBuilder.append(OR).append(tag);
                        }
                    }
                });
                saveScenarioTagsFilterToFile(tagFilterBuilder.toString());
            }
        }
    }

    private static List<String> getCurrentFailedScenarioTags(Scenario scenario) {
        Throwable error = getScenarioError(scenario);
        if (nonNull(error.getMessage()) && (error.getMessage().contains(BLOCKED_DUE_TO_THE_ISSUE) ||
                error.getMessage().contains(FAILED_DUE_TO_THE_BUG))) {
            return new ArrayList<>();
        } else {
            return getFilteredTags(scenario, CASE_TAG_PATTERN, 1);
        }
    }

    @SneakyThrows
    private static String getSavedScenarioTags() {
        File scenarioTagsFile = new File(Objects.requireNonNull(FAILED_SCENARIOS_FILE_PATH).toString());
        if (scenarioTagsFile.exists()) {
            return readString(scenarioTagsFile.toPath());
        }
        return StringUtils.EMPTY;
    }

    @SneakyThrows
    private static void saveScenarioTagsFilterToFile(String tagsFilter) {
        LOGGER.info(format("Full tags filter: '%s'", tagsFilter));
        String scenarioDirectoryPath = Objects.requireNonNull(FAILED_SCENARIOS_FILE_PATH).getParent().toString();
        File scenarioDirectory = new File(scenarioDirectoryPath);
        if (!scenarioDirectory.exists()) {
            scenarioDirectory.mkdir();
        }
        Files.write(FAILED_SCENARIOS_FILE_PATH, tagsFilter.getBytes(StandardCharsets.UTF_8));
    }

}
