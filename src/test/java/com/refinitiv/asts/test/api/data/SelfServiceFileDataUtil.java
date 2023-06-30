package com.refinitiv.asts.test.api.data;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.lang.invoke.MethodHandles;
import java.time.Instant;
import java.util.List;

import static com.refinitiv.asts.test.ui.constants.TestConstants.CLOSED_SQUARE_BRACKET;
import static com.refinitiv.asts.test.ui.constants.TestConstants.OPENED_SQUARE_BRACKET;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getCurrentDateInEpoch;
import static com.refinitiv.asts.test.utils.FileUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.writeStringAsDataFileContent;
import static java.util.stream.Collectors.joining;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.poi.util.StringUtil.join;

public class SelfServiceFileDataUtil {

    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    public static final String SELF_SERVICE_UPLOAD_DATA_FILES = "selfservice/uploadDataFiles";

    public static File createNewFileFromTemplate(String csvFileName, String userEmailRef, ScenarioCtxtWrapper context) {
        List<List<String>> lists = readCSVFile(new File(getAPIFilePath(SELF_SERVICE_UPLOAD_DATA_FILES, csvFileName)));
        String fileContentTemplate = lists.stream().map(row -> join(EMPTY, row)).collect(joining(LF));
        fileContentTemplate =
                fileContentTemplate.substring(1, fileContentTemplate.length() - 1).replaceAll("](\r?\n|\r)+\\[", "\n");
        logger.info("fileContentTemplate='\n" + fileContentTemplate + "'");
        String replaceCsvPlaceholders = replaceCsvPlaceholders(fileContentTemplate);
        String fileContent =
                contextSaveRetrieveByActionType(replaceCsvPlaceholders, csvFileName, userEmailRef, context);
        logger.info("fileContent='\n" + fileContent + "'");
        String tempCsvFilePath = getFilePath(getTempFileName(csvFileName));
        writeStringAsDataFileContent(tempCsvFilePath, fileContent);
        return new File(tempCsvFilePath);
    }

    private static String replaceCsvPlaceholders(String fileContent) {
        String newFileContent = fileContent;
        String nowDtUtc = Instant.now().toString();
        String nowDtStr = nowDtUtc.substring(2, 4) + nowDtUtc.substring(5, 7) + nowDtUtc.substring(8, 10) + "-" +
                nowDtUtc.substring(11, 13) + nowDtUtc.substring(14, 16) + nowDtUtc.substring(17, 19);
        newFileContent = newFileContent.replaceAll("\\[USER-EMAIL-MS\\]", nowDtStr);
        newFileContent = newFileContent.replaceAll("\\[USER-FNAME-MS\\]", nowDtStr);
        logger.info("newFileContent='\n" + newFileContent + "'");
        return newFileContent;
    }

    private static String contextSaveRetrieveByActionType(String newFileContent, String dataFileRefId,
            String userEmailRef, ScenarioCtxtWrapper context) {
        String[] csvData = newFileContent.split("(\r?\n|\r)+")[1].split("\\|");
        String actionType = csvData[0].trim();
        logger.info("actionType='" + actionType + "'");
        if (actionType.equals("ADD")) {
            String userEmail = csvData[14].trim();
            String key = "User Reference" + "-userEmail";
            context.getScenarioContext().setContext(key, userEmail);
            userEmail = (String) context.getScenarioContext().getContext(key);
            logger.info("SET: key='" + key + "' | userEmail='" + userEmail + "'");
        } else if (actionType.equals("PARTUPDATE") || actionType.equals("FULLUPDATE")) {
            String key = userEmailRef + "-userEmail";
            String userEmail = (String) context.getScenarioContext().getContext(key);
            logger.info("GET: key='" + key + "' | userEmail='" + userEmail + "'");
            newFileContent = newFileContent.replaceAll("\\[USER-EMAIL-ADDRESS\\]", userEmail);
        }
        return newFileContent;
    }

    private static String getTempFileName(String csvFileName) {
        String csvFileNamePart = csvFileName.split("\\.")[0];
        String csvFileNameExt = csvFileName.split("\\.")[1];
        return csvFileNamePart + getCurrentDateInEpoch() + "." + csvFileNameExt;
    }

}
