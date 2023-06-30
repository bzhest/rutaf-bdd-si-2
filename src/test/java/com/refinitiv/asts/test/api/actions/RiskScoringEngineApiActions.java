package com.refinitiv.asts.test.api.actions;

import com.fasterxml.jackson.core.type.TypeReference;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.constants.ApiRequestConstants;
import com.refinitiv.asts.test.api.dataproviders.JsonApiDataTransfer;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.PublicRSEComputeAPIRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.PublicRSEAddRangeRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.RiskScoringEngineAPIRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.RiskScoringEngineREFRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.response.*;
import com.refinitiv.asts.test.api.stepDefinitions.riskscoringengine.RiskScoringEngineApiAssertions;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.utils.FileUtil;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import lombok.SneakyThrows;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.BeanUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.api.constants.ApiRequestConstants.*;
import static com.refinitiv.asts.test.api.dataproviders.ApiDataProvider.RISKSCORINGENGINE_PUBLIC_ADDRANGE_REQUEST;
import static com.refinitiv.asts.test.utils.FileUtil.*;

public class RiskScoringEngineApiActions<T> extends BaseApiActions<RiskScoringEngineAPIResponseDTO> {

    private final String RSE_API_ENDPOINT_BASE_URL = Config.get().value("rse.api.endpoint.base.url");
    private final String RSE_API_ENDPOINT_PATH_URL = "/rse";
    private final String RSE_API_ENDPOINT_PATH_URI = "";
    private final String RSE_API_ENDPOINT_AUTH_BEARER_TOKEN = Config.get().value("rse.api.endpoint.auth.bearer.token");
    private final String RSE_API_ENDPOINT_X_MODEL_ID = X_MODEL_ID_VALUE;
    private final String RSE_DATA_DOCUMENTS_FILE_PATH = "riskScoringEngine/dataFiles";
    private final String RSE_REFERENCE_DOCUMENT_FILE_NAME = "model_ORIGv2022-09-20 - Copy.xlsx";
    private final String RSE_QA_TESTCASES_FILE_NAME = "RSE API Combinations_2022-09-15.xlsx";
    private final String RSE_TEMP_JSONREQS_FILE_NAME = "TempJsonRequestsFile.txt";
    private final String RSE_TEMP_JSONKEYS_FILE_NAME = "TempJsonKeysFile.txt";

    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL =
            Config.get().value("rdds.public.rse.api.endpoint.base.url");
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL_DEV =
            Config.get().value("rdds.public.rse.api.endpoint.base.url.dev");
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_PATH_URL = "/risk-score-engine";
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_PATH_URI = "/reference";
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE =
            Config.get().value("rdds.public.rse.api.endpoint.reference.x.tenant.code");
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE_DEV =
            Config.get().value("rdds.public.rse.api.endpoint.reference.x.tenant.code.dev");
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL =
            Config.get().value("rdds.public.rse.api.endpoint.reference.requestor.email");
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL = "/risk-score-engine";
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_MODELS_PATH_URI = "/models";
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_COMPUTE_PATH_URI = "/compute";
    private final String RDDS_PUBLIC_RSE_API_ENDPOINT_RANGE_PATH_URI = "/range";

    public RiskScoringEngineApiActions(ScenarioCtxtWrapper context) {
        super(context);
    }

    @Override
    public RiskScoringEngineAPIResponseDTO getBodyFromContext(String reference,
            TypeReference<RiskScoringEngineAPIResponseDTO> typeReference) {
        return getResponseAsObjectFromContext(reference, typeReference);
    }

    @SneakyThrows
    public void fetchIntoContextAllRiskScoringEngineReferenceValues(String riskFactorCategoriesChain) {
        Response getResponse = sendGETRequestToRiskScoringEngineAPIEndpoint();
        logger.info("================ ACTIONS GET API-EPT: response = '" + getResponse.getBody().prettyPrint() + "'");
        RSEReferenceValuesAPIResponseDTO rseReferenceValuesAPIResponseDTO =
                objectMapper.readValue(getResponse.getBody().asString(),
                                       new TypeReference<RSEReferenceValuesAPIResponseDTO>() {
                                       });
        context.getScenarioContext().setContext(riskFactorCategoriesChain, rseReferenceValuesAPIResponseDTO);
    }

    @SneakyThrows
    public void callPOSTRequestToRiskScoringEngineAPIEndpoint(String riskFactors,
            RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO) {
        logger.info("================ ACTIONS POST API-EPT: riskFactors = [" + riskFactors + "]");

        Response postResponse = sendPOSTRequestToRiskScoringEngineAPIEndpoint(riskScoringEngineAPIRequestDTO);
        logger.info(
                "================ ACTIONS POST API-EPT: response = '\n" + postResponse.getBody().prettyPrint() + "\n'");
        context.getScenarioContext().setContext(riskFactors, postResponse);
        RiskScoringEngineAPIResponseDTO riskScoringEngineAPIResponseDTO =
                objectMapper.readValue(postResponse.getBody().asString(),
                                       new TypeReference<RiskScoringEngineAPIResponseDTO>() {
                                       });
        context.getScenarioContext().setContext(riskFactors + _API_DTO, riskScoringEngineAPIResponseDTO);
        logger.info("================ ACTIONS POST API-EPT: apiAverageRiskScore = '" +
                            riskScoringEngineAPIResponseDTO.getAverageRiskScore() + "'");
    }

    public void queryReferenceDocumentForRiskProfile(String refSpreadsheetFilename, String riskFactors,
            RiskScoringEngineREFRequestDTO riskScoringEngineREFRequestDTO) throws Exception {
        logger.info("================ ACTIONS POI  REF-DOC: Query EXCEL file ================");
        logger.info("");

        RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO =
                queryReferenceDocumentForRiskProfile(refSpreadsheetFilename, riskScoringEngineREFRequestDTO);
        logger.info("================ ACTIONS QRY REF-DOC: apiAverageRiskScore = '" +
                            riskScoringEngineREFResponseDTO.getAverageRiskScore() + "'");
        context.getScenarioContext().setContext(riskFactors + _REF_DTO, riskScoringEngineREFResponseDTO);
    }

    @SneakyThrows
    public void callGETPublicRiskScoringEngineREFERENCESApiEndpoint(String referenceCategory) {
        switch (referenceCategory) {
            case "affiliation":
            case "business-category":
            case "commodity-type":
            case "company-type":
            case "country":
            case "design-agreement":
            case "industry-type":
            case "product-impact":
            case "relationship-visibility":
            case "revenue":
            case "sourcing-method":
            case "sourcing-type":
            case "spend-category":
            case "retrieve-risk-scoring-range":
                queryPublicRiskScoringEngineREFERENCESGENApiEndpoint(referenceCategory, null);
                break;
            case "retrieve-rating-groups": {
                Response modelsResponse = sendGETRequestToPublicRiskScoringEngineMODELSApiEndpoint_ENV();
                RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO =
                        objectMapper.readValue(modelsResponse.getBody().asString(),
                                               new TypeReference<RSEPublicModelValuesAPIResponseDTO>() {
                                               });
                List<RSEPublicModelValuePOJO> data = rsePublicModelValuesAPIResponseDTO.getData();
                List<String> modelIds = data.stream()
                        .map(RSEPublicModelValuePOJO::getId)
                        .collect(Collectors.toList());
                for (String modelId : modelIds) {
                    Map paramsMap = new HashMap<String, String>();
                    paramsMap.put(MODEL_ID, modelId);
                    queryPublicRiskScoringEngineREFERENCESGENApiEndpoint(referenceCategory, paramsMap);
                }
                break;
            }
            case "industry-business-map": {
                Response industryTypesResponse =
                        sendGETRequestToPublicRiskScoringEngineREFERENCESApiEndpoint("industry-type", null);
                RSEPublicReferenceValuesAPIResponseDTO<RSEPublicReferenceValuePOJO>
                        rsePublicReferenceValuesAPIResponseDTO =
                        objectMapper.readValue(industryTypesResponse.getBody().asString(),
                                               new TypeReference<RSEPublicReferenceValuesAPIResponseDTO<RSEPublicReferenceValuePOJO>>() {
                                               });
                List<RSEPublicReferenceValuePOJO> data = rsePublicReferenceValuesAPIResponseDTO.getData();
                List<String> industryTypes = data.stream()
                        .map(RSEPublicReferenceValuePOJO::getCode)
                        .collect(Collectors.toList());
                for (String industryType : industryTypes) {
                    logger.info("================ industryType='" + industryType + "'");
                    Map paramsMap = new HashMap<String, String>();
                    paramsMap.put("parentId", industryType);
                    queryPublicRiskScoringEngineREFERENCESGENApiEndpoint(referenceCategory, paramsMap);
                }
                break;
            }
        }
    }

    @SneakyThrows
    public void callGETPublicRiskScoringEngineMODELSRANGEApiEndpoint(String uriPath) {

        callGETPublicRiskScoringEngineRANGESApiEndpoint(uriPath + UNDERSCORE);

        String modelsKey = "models";
        RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO =
                (RSEPublicModelValuesAPIResponseDTO) context.getScenarioContext().getContext(modelsKey + _DTO);
        List<RSEPublicModelValuePOJO> rsePublicModelValuePOJOs = rsePublicModelValuesAPIResponseDTO.getData();

        callGETPublicRiskScoringEngineMODELSRANGESApiEndpoint(uriPath + UNDERSCORE, rsePublicModelValuePOJOs);
    }

    @SneakyThrows
    public void callGETPublicRiskScoringEngineMODELSApiEndpoint_DEV(String uriPath) {
        Response modelsResponse = sendGETRequestToPublicRiskScoringEngineMODELSApiEndpoint_DEV();
        String modelsKey = uriPath + "models";
        context.getScenarioContext().setContext(modelsKey, modelsResponse);

        logger.info(
                "================ ACTIONS GET MODELS API-EPT: response = '" + modelsResponse.getBody().prettyPrint() +
                        "'");

        RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO =
                objectMapper.readValue(modelsResponse.getBody().asString(),
                                       new TypeReference<RSEPublicModelValuesAPIResponseDTO>() {
                                       });
        context.getScenarioContext().setContext(modelsKey + _DTO, rsePublicModelValuesAPIResponseDTO);
    }

    @SneakyThrows
    public void callGETPublicRiskScoringEngineMODELSApiEndpoint_ENV(String uriPath) {
        Response modelsResponse = sendGETRequestToPublicRiskScoringEngineMODELSApiEndpoint_ENV();
        String modelsKey = uriPath + "models";
        context.getScenarioContext().setContext(modelsKey, modelsResponse);

        logger.info(
                "================ ACTIONS GET MODELS API-EPT: response = '" + modelsResponse.getBody().prettyPrint() +
                        "'");

        RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO =
                objectMapper.readValue(modelsResponse.getBody().asString(),
                                       new TypeReference<RSEPublicModelValuesAPIResponseDTO>() {
                                       });
        context.getScenarioContext().setContext(modelsKey + _DTO, rsePublicModelValuesAPIResponseDTO);
    }

    @SneakyThrows
    public void callGETPublicRiskScoringEngineRANGESApiEndpoint(String uriPath) {
        Response rangeResponse = sendGETRequestToPublicRiskScoringEngineRANGEApiEndpoint();
        String rangeKey = uriPath + "range";
        context.getScenarioContext().setContext(rangeKey, rangeResponse);
        logger.info("================ ACTIONS GET RANGE API-EPT: response = '" + rangeResponse.getBody().prettyPrint() +
                            "'");
        RSEPublicRangeValuesAPIResponseDTO rsePublicRangeValuesAPIResponseDTO =
                objectMapper.readValue(rangeResponse.getBody().asString(),
                                       new TypeReference<RSEPublicRangeValuesAPIResponseDTO>() {
                                       });
        context.getScenarioContext().setContext(rangeKey + _DTO, rsePublicRangeValuesAPIResponseDTO);

    }

    @SneakyThrows
    public void callGETPublicRiskScoringEngineMODELSRANGESApiEndpoint(String uriPath,
            List<RSEPublicModelValuePOJO> rsePublicModelValuePOJOs) {
        for (RSEPublicModelValuePOJO rsePublicModelValuePOJO : rsePublicModelValuePOJOs) {
            String modelId = rsePublicModelValuePOJO.getId();
            Response rangeModelIdResponse = sendGETRequestToPublicRiskScoringEngineRANGEMODELIDApiEndpoint(modelId);
            String rangeModelIdKey = uriPath + "range_" + modelId;
            context.getScenarioContext().setContext(rangeModelIdKey, rangeModelIdResponse);
            logger.info("================ ACTIONS GET RANGE-" + modelId + " API-EPT: response = '" +
                                rangeModelIdResponse.getBody().prettyPrint() + "'");
            RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO =
                    objectMapper.readValue(rangeModelIdResponse.getBody().asString(),
                                           new TypeReference<RSEPublicModelIdRangeValuesAPIResponseDTO>() {
                                           });
            context.getScenarioContext()
                    .setContext(rangeModelIdKey + _DTO, rsePublicModelIdRangeValuesAPIResponseDTO);
        }

    }

    @SneakyThrows
    public void callPOSTPublicRiskScoringEngineADDRANGEApiEndpointCase(String modelName, String rangeName,
            PublicRSEAddRangeRequestDTO publicRSEAddRangeRequestDTO) {
        RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO =
                (RSEPublicModelValuesAPIResponseDTO) context.getScenarioContext().getContext("models" + _DTO);
        List<RSEPublicModelValuePOJO> data = rsePublicModelValuesAPIResponseDTO.getData();
        RSEPublicModelValuePOJO targetRSEPublicModelValuePOJO = data.stream()
                .filter(rsePublicModelValuePOJO -> rsePublicModelValuePOJO != null)
                .filter(rsePublicModelValuePOJO -> rsePublicModelValuePOJO.getModelName().equals(modelName))
                .findFirst()
                .orElseThrow();

        Response addRangeResponse =
                sendPOSTRequestToPublicRiskScoringEngineADDRANGEITEMApiEndpoint(targetRSEPublicModelValuePOJO.getId(),
                                                                                publicRSEAddRangeRequestDTO);
        logger.info(
                "================ ACTIONS ADD RANGE API-EPT: response = '" + addRangeResponse.getBody().prettyPrint() +
                        "'");
        context.getScenarioContext().setContext(modelName + UNDERSCORE + rangeName, addRangeResponse);

        RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO =
                objectMapper.readValue(addRangeResponse.getBody().asString(),
                                       new TypeReference<RSEPublicModelIdRangeValuesAPIResponseDTO>() {
                                       });
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + _DTO, rsePublicModelIdRangeValuesAPIResponseDTO);

        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_name", publicRSEAddRangeRequestDTO.getName());
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_min", publicRSEAddRangeRequestDTO.getMin());
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_max", publicRSEAddRangeRequestDTO.getMax());
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_color", publicRSEAddRangeRequestDTO.getColor());
    }

    @SneakyThrows
    public void callPATCHPublicRiskScoringEngineUPDATERANGEApiEndpointCase(String modelName, String rangeName,
            String updateColor) {
        RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO =
                (RSEPublicModelIdRangeValuesAPIResponseDTO) context.getScenarioContext()
                        .getContext(modelName + UNDERSCORE + rangeName + _DTO);
        RSEPublicRangeValuePOJO targetRSEPublicRangeValuePOJO = rsePublicModelIdRangeValuesAPIResponseDTO.getData();
        String targetRangeName =
                (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_name");
        List<RangeItemPOJO> ranges = targetRSEPublicRangeValuePOJO.getRanges();
        RangeItemPOJO targetRangeItemPOJO = ranges.stream()
                .filter(rangeItemPOJO -> rangeItemPOJO != null)
                .filter(rangeItemPOJO -> rangeItemPOJO.getName().equals(targetRangeName))
                .findFirst()
                .orElseThrow();
        logger.info("================ ACTIONS UPDATE RANGE TARGET: model name='" +
                            targetRSEPublicRangeValuePOJO.getModelName() + "' | range id='" +
                            targetRangeItemPOJO.getId() + "' | name='" + targetRangeItemPOJO.getName() + "' | min='" +
                            targetRangeItemPOJO.getMin() + "' | max='" + targetRangeItemPOJO.getMax() + "' | color='" +
                            targetRangeItemPOJO.getColor() + "'");

        String modelId = targetRSEPublicRangeValuePOJO.getId();
        String rangeId = targetRangeItemPOJO.getId();

        Response updateRangeResponse =
                sendPATCHRequestToPublicRiskScoringEngineUPDATERANGEITEMApiEndpoint(modelId, rangeId, updateColor);
        logger.info("================ ACTIONS UPDATE RANGE API-EPT: response = '" +
                            updateRangeResponse.getBody().prettyPrint() + "'");
        context.getScenarioContext().setContext(modelName + UNDERSCORE + rangeName, updateRangeResponse);

        RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO2 =
                objectMapper.readValue(updateRangeResponse.getBody().asString(),
                                       new TypeReference<RSEPublicModelIdRangeValuesAPIResponseDTO>() {
                                       });
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + _DTO, rsePublicModelIdRangeValuesAPIResponseDTO2);

        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_name", targetRangeItemPOJO.getName());
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_min", String.valueOf(targetRangeItemPOJO.getMin()));
        context.getScenarioContext()
                .setContext(modelName + UNDERSCORE + rangeName + "_max", String.valueOf(targetRangeItemPOJO.getMax()));
        context.getScenarioContext().setContext(modelName + UNDERSCORE + rangeName + "_color", updateColor);
    }

    @SneakyThrows
    public void sendPOSTRequestToRiskScoringEngineAPIEndpoint(String riskFactorCategoriesChain,
            String refSpreadsheetFilename) {
        RSEReferenceValuesAPIResponseDTO rseReferenceValuesAPIResponseDTO =
                (RSEReferenceValuesAPIResponseDTO) context.getScenarioContext().getContext(riskFactorCategoriesChain);

        List<String> requestBodyJsons = getAllRiskFactorPermutationsRequestBodyJsons(riskFactorCategoriesChain,
                                                                                     rseReferenceValuesAPIResponseDTO);

        long startMillis = new Date().getTime();
        int i = 0;
        for (String requestBodyJson : requestBodyJsons) {
            ++i;
            logger.info("================ ACTIONS: " + (i) + ") requestBodyJson=|" + requestBodyJson + "|");

            RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO =
                    objectMapper.readValue(requestBodyJson, new TypeReference<RiskScoringEngineAPIRequestDTO>() {
                    });

            RiskScoringEngineREFRequestDTO riskScoringEngineREFRequestDTO = new RiskScoringEngineREFRequestDTO();
            BeanUtils.copyProperties(riskScoringEngineAPIRequestDTO, riskScoringEngineREFRequestDTO);

            RiskScoringEngineAPIResponseDTO riskScoringEngineAPIResponseDTO = null;
            RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO = null;
            boolean isTryOk = false;
            int t = 0;
            do {
                try {
                    t++;
                    Response postResponse =
                            sendPOSTRequestToRiskScoringEngineAPIEndpoint(riskScoringEngineAPIRequestDTO);
                    riskScoringEngineAPIResponseDTO = objectMapper.readValue(postResponse.getBody().asString(),
                                                                             new TypeReference<RiskScoringEngineAPIResponseDTO>() {
                                                                             });

                    riskScoringEngineREFResponseDTO =
                            queryReferenceDocumentForRiskProfile(refSpreadsheetFilename,
                                                                 riskScoringEngineREFRequestDTO);

                    new RiskScoringEngineApiAssertions().verifyEquivalentRiskProfiles(riskScoringEngineAPIResponseDTO,
                                                                                      riskScoringEngineREFResponseDTO,
                                                                                      requestBodyJson);

                    isTryOk = true;
                } catch (Exception x) {
                    isTryOk = false;
                }
            }
            while (t < 3 && !isTryOk);

            long endMillis = new Date().getTime();
            String elapsedTime = calculateElapsedTime(startMillis, endMillis);
            logger.info("================ ACTIONS POST API-EPT: apiAverageRiskScore             = '" +
                                riskScoringEngineAPIResponseDTO.getAverageRiskScore() + "' | '" +
                                riskScoringEngineREFResponseDTO.getAverageRiskScore() + "'");
            logger.info("================ ACTIONS POST API-EPT: riskScoringEngineAPIResponseDTO = '" +
                                riskScoringEngineAPIResponseDTO + "'");
            logger.info("================ ACTIONS POST REF-DOC: riskScoringEngineREFResponseDTO = '" +
                                riskScoringEngineREFResponseDTO + "'");
            logger.info(
                    "================ ACTIONS POST REF-DOC: Elapsed TIME                    = '" + elapsedTime + "'");
            logger.info("");

        }

    }

    public PublicRSEAddRangeRequestDTO buildPublicRSEAddRangeRequestDTO(String rangeRef, String rangeName,
            String intervalMin, String intervalMax, String color) {
        PublicRSEAddRangeRequestDTO publicRSEAddRangeRequestDTO = new JsonApiDataTransfer<PublicRSEAddRangeRequestDTO>(
                RISKSCORINGENGINE_PUBLIC_ADDRANGE_REQUEST).getRequestJsonData(rangeRef);

        setRiskScoringRangeMINMAXWithSuffix5Digits(publicRSEAddRangeRequestDTO, intervalMin, intervalMax);
        String rangeItemName = rangeName + UNDERSCORE + publicRSEAddRangeRequestDTO.getMin() + DASH +
                publicRSEAddRangeRequestDTO.getMax();
        publicRSEAddRangeRequestDTO.setName(rangeItemName);
        publicRSEAddRangeRequestDTO.setColor(color);
        logger.info("================ ACTIONS POST ADD-RANGE rangeItemName='" + publicRSEAddRangeRequestDTO.getName() +
                            "' | min='" + publicRSEAddRangeRequestDTO.getMin() + "' | max='" +
                            publicRSEAddRangeRequestDTO.getMax() + "' | color='" +
                            publicRSEAddRangeRequestDTO.getColor() + "'");

        return publicRSEAddRangeRequestDTO;
    }

    @SneakyThrows
    public void createRequestEntriesInJsonFile(String sourceJsonFile) {
        logger.info("================ ACTIONS WRITE JSON: sourceJsonFile = '" + sourceJsonFile + "'");

        File file = new File(getAPIFilePath(RSE_DATA_DOCUMENTS_FILE_PATH, RSE_QA_TESTCASES_FILE_NAME));
        InputStream is = new FileInputStream(file);
        XSSFWorkbook workbook = new XSSFWorkbook(is);
        XSSFSheet sheet = workbook.getSheetAt(0);

        String tempJsonRequestsFilePath = getAPIFilePath(RSE_DATA_DOCUMENTS_FILE_PATH, RSE_TEMP_JSONREQS_FILE_NAME);
        FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath, "");

        String tempJsonKeysFilePath = getAPIFilePath(RSE_DATA_DOCUMENTS_FILE_PATH, RSE_TEMP_JSONKEYS_FILE_NAME);
        FileUtil.writeStringAsDataFileContent(tempJsonKeysFilePath, "");

        FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath, "{" + System.getProperty("line.separator") +
                System.getProperty("line.separator"), true);

        List<String> keys = new ArrayList<>();
        XSSFRow keysRow = sheet.getRow(99);
        for (int colNum = 1; colNum < 13; colNum++) {
            XSSFCell keyCell = keysRow.getCell(colNum);
            String key = keyCell.getStringCellValue();
            keys.add(key);
        }

        for (int rowNum = 1; rowNum < 92; rowNum++) {
            XSSFRow sheetRow = sheet.getRow(rowNum);

            StringBuilder rowSb = composeRowContentJsonString(sheetRow, keys);

            String jsonRequestBody = rowSb.toString().trim();
            String jsonRequestKey = jsonRequestBody.replaceAll("\"", "")
                    .replaceAll(": ", ":")
                    .trim();

            FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath,
                                                  "  " + "\"" + String.format("%03d) ", rowNum) + jsonRequestKey +
                                                          "\": {" + System.getProperty("line.separator"), true);

            FileUtil.writeStringAsDataFileContent(tempJsonKeysFilePath, "|" +
                    String.format("%-310.310s", String.format("%03d) ", rowNum) + jsonRequestKey) + "|" +
                    System.getProperty("line.separator"), true);

            FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath,
                                                  "    " + "\"request\": {" + System.getProperty("line.separator"),
                                                  true);

            String stringFileContent = jsonRequestBody.replaceAll("\"null\"", "null")
                    .replaceAll(",\\s+", "," + System.getProperty("line.separator") + "      ")
                    .trim();
            FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath,
                                                  "      " + stringFileContent + System.getProperty("line.separator"),
                                                  true);

            FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath,
                                                  "    " + "}" + System.getProperty("line.separator"), true);

            FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath, "  " + "}" + (rowNum == 91 ? "" : ",") +
                    System.getProperty("line.separator") + System.getProperty("line.separator"), true);
        }

        FileUtil.writeStringAsDataFileContent(tempJsonRequestsFilePath, "}" + System.getProperty("line.separator"),
                                              true);

        is.close();
    }

    @SneakyThrows
    public void callPOSTRequestToPublicRiskScoringEngineCOMPUTEApiEndpoint(String riskFactors,
            PublicRSEComputeAPIRequestDTO publicRSEComputeAPIRequestDTO) {
        logger.info("================ ACTIONS POST API-EPT: riskFactors = [" + riskFactors + "]");

        Response postResponse =
                sendPOSTRequestToPublicRiskScoringEngineCOMPUTEApiEndpoint(publicRSEComputeAPIRequestDTO);
        logger.info("================ ACTIONS POST API-EPT: postResponse='\n" + postResponse.getBody().prettyPrint() +
                            "\n'");
        context.getScenarioContext().setContext(riskFactors, postResponse);

        RSEPublicComputeAPIResponseDTO rsePublicComputeAPIResponseDTO =
                objectMapper.readValue(postResponse.getBody().asString(),
                                       new TypeReference<RSEPublicComputeAPIResponseDTO>() {
                                       });
        RiskScoringEngineAPIResponseDTO riskScoringEngineAPIResponseDTO = rsePublicComputeAPIResponseDTO.getData();
        context.getScenarioContext().setContext(riskFactors + _API_DTO, riskScoringEngineAPIResponseDTO);
        logger.info("================ ACTIONS POST API-EPT: apiAverageRiskScore = '" +
                            rsePublicComputeAPIResponseDTO.getData().getAverageRiskScore() + "'");
    }

    private StringBuilder composeRowContentJsonString(XSSFRow sheetRow, List<String> keys) {
        StringBuilder rowSb = new StringBuilder();
        for (int colNum = 1; colNum < 13; colNum++) {
            XSSFCell riskFactorCell = sheetRow.getCell(colNum);
            String keyValuePair = "\"" + keys.get(colNum - 1) + "\": " +
                    ("\"" + riskFactorCell.getStringCellValue().trim() + "\"").replaceAll("\"-\"", "\"null\"") +
                    (colNum < 13 - 1 ? "," : "");
            int w = 1;
            switch (colNum) {
                case 1:
                    w = 20;
                    break;
                case 2:
                    w = 21;
                    break;
                case 3:
                    w = 26;
                    break;
                case 4:
                    w = 24;
                    break;
                case 5:
                    w = 25;
                    break;
                case 6:
                    w = 27;
                    break;
                case 7:
                    w = 29;
                    break;
                case 8:
                    w = 49;
                    break;
                case 9:
                    w = 39;
                    break;
                case 10:
                    w = 28;
                    break;
                case 11:
                    w = 43;
                    break;
                case 12:
                    w = 25;
                    break;
                default:
                    w = 8;
                    break;
            }
            rowSb.append(String.format("%-" + w + "." + w + "s", keyValuePair));
        }
        return rowSb;
    }

    private Response sendGETRequestToPublicRiskScoringEngineREFERENCESApiEndpoint(String referenceCategory,
            Map paramsMap) {
        String endpoint = RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_PATH_URL +
                (RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_PATH_URI + "/" + referenceCategory);
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = (paramsMap == null || paramsMap.size() == 0 ? restClient.sendGet(reqSpec, endpoint) :
                restClient.sendGet(reqSpec, endpoint, paramsMap));
        return response;
    }

    private Response sendGETRequestToPublicRiskScoringEngineMODELSApiEndpoint_DEV() {
        String endpoint =
                RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL + RDDS_PUBLIC_RSE_API_ENDPOINT_MODELS_PATH_URI;
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE_DEV);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL_DEV, headersMap);

        Response response = restClient.sendGet(reqSpec, endpoint);
        return response;
    }

    private Response sendGETRequestToPublicRiskScoringEngineMODELSApiEndpoint_ENV() {
        String endpoint =
                RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL + RDDS_PUBLIC_RSE_API_ENDPOINT_MODELS_PATH_URI;
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = restClient.sendGet(reqSpec, endpoint);
        return response;
    }

    private Response sendGETRequestToPublicRiskScoringEngineRANGEApiEndpoint() {
        String endpoint =
                RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL + RDDS_PUBLIC_RSE_API_ENDPOINT_RANGE_PATH_URI;
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = restClient.sendGet(reqSpec, endpoint);
        return response;
    }

    private Response sendGETRequestToPublicRiskScoringEngineRANGEMODELIDApiEndpoint(String modelId) {
        String endpoint = RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL +
                (RDDS_PUBLIC_RSE_API_ENDPOINT_RANGE_PATH_URI + "/" + modelId);
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = restClient.sendGet(reqSpec, endpoint);
        return response;
    }

    private Response sendPOSTRequestToPublicRiskScoringEngineADDRANGEITEMApiEndpoint(String modelId,
            PublicRSEAddRangeRequestDTO publicRSEAddRangeRequestDTO) {
        String endpoint = RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL +
                (RDDS_PUBLIC_RSE_API_ENDPOINT_RANGE_PATH_URI + "/" + modelId);
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE_DEV);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL_DEV, headersMap);

        Response response = restClient.sendPost(reqSpec, endpoint, publicRSEAddRangeRequestDTO);
        return response;
    }

    private Response sendPATCHRequestToPublicRiskScoringEngineUPDATERANGEITEMApiEndpoint(String modelId, String rangeId,
            String updateColor) {
        String endpoint = RDDS_PUBLIC_RSE_API_ENDPOINT_RISKSCOREENGINE_PATH_URL +
                (RDDS_PUBLIC_RSE_API_ENDPOINT_RANGE_PATH_URI + "/" + modelId + "/" + rangeId);
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(ApiRequestConstants.X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE_DEV);
        headersMap.put(ApiRequestConstants.REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        Map<String, String> paramsMap = new HashMap<>();
        paramsMap.put("color", updateColor);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL_DEV, headersMap);

        Response response = restClient.sendPatch(reqSpec, endpoint, paramsMap);
        return response;
    }

    private Response sendGETRequestToRiskScoringEngineAPIEndpoint() {
        String endpoint = RSE_API_ENDPOINT_PATH_URL + RSE_API_ENDPOINT_PATH_URI;
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(AUTHORIZATION, RSE_API_ENDPOINT_AUTH_BEARER_TOKEN);
        headersMap.put(X_MODEL_ID, RSE_API_ENDPOINT_X_MODEL_ID);
        RequestSpecification reqSpec = specBuilder.getSpec(RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = restClient.sendGet(reqSpec, endpoint);
        return response;
    }

    private Response sendPOSTRequestToRiskScoringEngineAPIEndpoint(
            RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO) {
        String endpoint = RSE_API_ENDPOINT_PATH_URL + RSE_API_ENDPOINT_PATH_URI;
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(AUTHORIZATION, RSE_API_ENDPOINT_AUTH_BEARER_TOKEN);
        headersMap.put(X_MODEL_ID, RSE_API_ENDPOINT_X_MODEL_ID);
        RequestSpecification reqSpec = specBuilder.getSpec(RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = restClient.sendPost(reqSpec, endpoint, riskScoringEngineAPIRequestDTO, 15000);
        return response;
    }

    private Response sendPOSTRequestToPublicRiskScoringEngineCOMPUTEApiEndpoint(
            PublicRSEComputeAPIRequestDTO publicRSEComputeAPIRequestDTO) {
        String endpoint = RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_PATH_URL +
                (RDDS_PUBLIC_RSE_API_ENDPOINT_MODELS_PATH_URI + RDDS_PUBLIC_RSE_API_ENDPOINT_COMPUTE_PATH_URI + "/" +
                        RSE_API_ENDPOINT_X_MODEL_ID);
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(X_TENANT_CODE, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_X_TENANT_CODE);
        headersMap.put(REQUESTOR_EMAIL, RDDS_PUBLIC_RSE_API_ENDPOINT_REFERENCE_REQUESTOR_EMAIL);
        RequestSpecification reqSpec = specBuilder.getSpec(RDDS_PUBLIC_RSE_API_ENDPOINT_BASE_URL, headersMap);

        Response response = restClient.sendPost(reqSpec, endpoint, publicRSEComputeAPIRequestDTO);
        return response;
    }

    @SneakyThrows
    private RiskScoringEngineREFResponseDTO queryReferenceDocumentForRiskProfile(String refSpreadsheetFilename,
            RiskScoringEngineREFRequestDTO riskScoringEngineREFRequestDTO) {

        File file = new File(getAPIFilePath(RSE_DATA_DOCUMENTS_FILE_PATH, refSpreadsheetFilename));

        InputStream is = new FileInputStream(file);
        XSSFWorkbook workbook = new XSSFWorkbook(is);
        setReferenceDocumentInputValues(workbook, riskScoringEngineREFRequestDTO);

        XSSFFormulaEvaluator.evaluateAllFormulaCells(workbook);

        RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO = getReferenceDocumentOutputValues(workbook);

        is.close();

        return riskScoringEngineREFResponseDTO;
    }

    private void setReferenceDocumentInputValues(XSSFWorkbook workbook,
            RiskScoringEngineREFRequestDTO riskScoringEngineREFRequestDTO) {

        setReferenceDocumentCellStringValue(workbook, 6, 1, riskScoringEngineREFRequestDTO.getCountry());
        setReferenceDocumentCellStringValue(workbook, 7, 1, riskScoringEngineREFRequestDTO.getIndustry());
        setReferenceDocumentCellStringValue(workbook, 6, 4, riskScoringEngineREFRequestDTO.getParentBusinessType());
        setReferenceDocumentCellStringValue(workbook, 7, 4, riskScoringEngineREFRequestDTO.getChildBusinessType());
        setReferenceDocumentCellStringValue(workbook, 8, 1, riskScoringEngineREFRequestDTO.getAffiliation());
        setReferenceDocumentCellStringValue(workbook, 9, 1, riskScoringEngineREFRequestDTO.getRevenue());
        setReferenceDocumentCellStringValue(workbook, 10, 1, riskScoringEngineREFRequestDTO.getSpendCategory());
        setReferenceDocumentCellStringValue(workbook, 11, 1, riskScoringEngineREFRequestDTO.getDesignAgreement());
        setReferenceDocumentCellStringValue(workbook, 12, 1,
                                            riskScoringEngineREFRequestDTO.getRelationshipVisibility());
        setReferenceDocumentCellStringValue(workbook, 13, 1, riskScoringEngineREFRequestDTO.getSourcingMethod());
        setReferenceDocumentCellStringValue(workbook, 14, 1, riskScoringEngineREFRequestDTO.getSourcingType());
        setReferenceDocumentCellStringValue(workbook, 15, 1, riskScoringEngineREFRequestDTO.getProductImpact());
        setReferenceDocumentCellStringValue(workbook, 16, 1, riskScoringEngineREFRequestDTO.getCommodityType());
    }

    private void setReferenceDocumentCellStringValue(XSSFWorkbook workbook, int rowNum, int cellColNum,
            String cellValue) {
        XSSFSheet sheet = workbook.getSheetAt(0);
        if (!StringUtils.isEmpty(cellValue)) {
            XSSFRow targetRow = sheet.getRow(rowNum);
            XSSFCell targetCell = targetRow.getCell(cellColNum);
            targetCell.setCellValue(cellValue);
        }
    }

    private RiskScoringEngineREFResponseDTO getReferenceDocumentOutputValues(XSSFWorkbook workbook) {
        XSSFSheet sheet = workbook.getSheetAt(0);

        RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO = new RiskScoringEngineREFResponseDTO();

        RiskAreaPOJO riaCobRiskArea = getRiskArea(workbook, 22, 23, 51, 1);
        RiskAreaPOJO riaSocRiskArea = getRiskArea(workbook, 22, 23, 51, 2);
        RiskAreaPOJO riaSaeRiskArea = getRiskArea(workbook, 22, 23, 51, 3);
        RiskAreaPOJO riaFmlRiskArea = getRiskArea(workbook, 22, 23, 51, 4);
        RiskAreaPOJO riaExcRiskArea = getRiskArea(workbook, 22, 23, 51, 5);
        RiskAreaPOJO riaPolRiskArea = getRiskArea(workbook, 22, 23, 51, 6);
        RiskAreaPOJO riaAnbRiskArea = getRiskArea(workbook, 22, 23, 51, 7);

        RiskAreaPOJO riaHesRiskArea = getRiskArea(workbook, 22, 23, 51, 8);
        RiskAreaPOJO riaDivRiskArea = getRiskArea(workbook, 22, 23, 51, 9);
        RiskAreaPOJO riaEmrRiskArea = getRiskArea(workbook, 22, 23, 51, 10);
        RiskAreaPOJO riaMdsRiskArea = getRiskArea(workbook, 22, 23, 51, 11);
        RiskAreaPOJO riaMlhRiskArea = getRiskArea(workbook, 22, 23, 51, 12);
        RiskAreaPOJO riaIrmRiskArea = getRiskArea(workbook, 22, 23, 51, 13);

        RiskAreaPOJO riaPimRiskArea = getRiskArea(workbook, 22, 23, 51, 14);
        RiskAreaPOJO riaIpiRiskArea = getRiskArea(workbook, 22, 23, 51, 15);
        RiskAreaPOJO riaDsbRiskArea = getRiskArea(workbook, 22, 23, 51, 16);
        RiskAreaPOJO riaBucRiskArea = getRiskArea(workbook, 22, 23, 51, 17);

        RiskAreaPOJO riaChuRiskArea = getRiskArea(workbook, 22, 23, 51, 18);
        RiskAreaPOJO riaEwmRiskArea = getRiskArea(workbook, 22, 23, 51, 19);
        RiskAreaPOJO riaPrrRiskArea = getRiskArea(workbook, 22, 23, 51, 20);
        RiskAreaPOJO riaSusRiskArea = getRiskArea(workbook, 22, 23, 51, 21);
        RiskAreaPOJO riaIatRiskArea = getRiskArea(workbook, 22, 23, 51, 22);
        RiskAreaPOJO riaEnsRiskArea = getRiskArea(workbook, 22, 23, 51, 23);

        Double averageRiskScore = getReferenceDocumentCellDoubleValue(workbook, 54, 1);
        String modelCode = getReferenceDocumentCellStringValue(workbook, 4, 1);
        String modelName = getReferenceDocumentCellStringValue(workbook, 5, 1);

        if (riskScoringEngineREFResponseDTO.getRiskAreas() == null) {
            riskScoringEngineREFResponseDTO.setRiskAreas(new ArrayList<RiskAreaPOJO>());
        }

        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaCobRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaSocRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaSaeRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaFmlRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaExcRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaPolRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaAnbRiskArea);

        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaHesRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaDivRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaEmrRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaMdsRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaMlhRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaIrmRiskArea);

        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaPimRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaIpiRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaDsbRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaBucRiskArea);

        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaChuRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaEwmRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaPrrRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaSusRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaIatRiskArea);
        riskScoringEngineREFResponseDTO.getRiskAreas().add(riaEnsRiskArea);

        riskScoringEngineREFResponseDTO.setAverageRiskScore(averageRiskScore);
        riskScoringEngineREFResponseDTO.setModelCode(modelCode);
        riskScoringEngineREFResponseDTO.setModelName(modelName);

        return riskScoringEngineREFResponseDTO;
    }

    private RiskAreaPOJO getRiskArea(XSSFWorkbook workbook, int descRowNum, int uidRowNum, int scoreRowNum,
            int cellColNum) {
        XSSFSheet sheet = workbook.getSheetAt(0);
        RiskAreaPOJO riaRiskArea = new RiskAreaPOJO();
        riaRiskArea.setDescription(getReferenceDocumentCellStringValue(workbook, descRowNum, cellColNum));
        riaRiskArea.setUid(getReferenceDocumentCellStringValue(workbook, uidRowNum, cellColNum));
        riaRiskArea.setScore(getReferenceDocumentCellDoubleValue(workbook, scoreRowNum, cellColNum));
        return riaRiskArea;
    }

    private Double getReferenceDocumentCellDoubleValue(XSSFWorkbook workbook, int rowNum, int cellColNum) {
        XSSFSheet sheet = workbook.getSheetAt(0);
        XSSFRow outputRow = sheet.getRow(rowNum);
        XSSFCell outputCell = outputRow.getCell(cellColNum);
        Double outputDoubleValue = outputCell.getNumericCellValue();
        return outputDoubleValue;
    }

    private String getReferenceDocumentCellStringValue(XSSFWorkbook workbook, int rowNum, int cellColNum) {
        XSSFSheet sheet = workbook.getSheetAt(0);
        XSSFRow outputRow = sheet.getRow(rowNum);
        XSSFCell outputCell = outputRow.getCell(cellColNum);
        String outputStringValue = outputCell.getStringCellValue();
        return outputStringValue;
    }

    @SneakyThrows
    private List<String> getAllRiskFactorPermutationsRequestBodyJsons(String riskFactorCategoriesChain,
            RSEReferenceValuesAPIResponseDTO rseReferenceValuesAPIResponseDTO) {

        List<String> riskFactorCategories = Arrays.asList(riskFactorCategoriesChain.split("\\-"));
        logger.info("riskFactorCategories=" + riskFactorCategories);

        List<List<String>> riskFactorCategoryValuesList =
                getRiskFactorCategoriesValuesListFromRiskFactorCategories(riskFactorCategories,
                                                                          rseReferenceValuesAPIResponseDTO);

        List<String> prevReqBodyJsons = new ArrayList<>();
        List<String> currReqBodyJsons = new ArrayList<>();
        int i = 0, j = 0;
        boolean isContinue = true;
        while (isContinue) {
            String key = getProperRiskFactorCategoryKey(riskFactorCategories.get(i));
            String riskFactorCategoryValue = riskFactorCategoryValuesList.get(i).get(j);
            String jsonEntry = "\"" + key + "\":\"" + riskFactorCategoryValue + "\"";

            if (prevReqBodyJsons.size() == 0) {
                currReqBodyJsons.add(jsonEntry);
            } else {
                for (String prevReqBodyJson : prevReqBodyJsons) {
                    String currReqBodyJson = prevReqBodyJson + ", " + jsonEntry;
                    currReqBodyJsons.add(currReqBodyJson);
                }
            }

            if (j < riskFactorCategoryValuesList.get(i).size() - 1) {
                j++;
            } else {
                j = 0;
                i++;
                isContinue = (i < riskFactorCategoryValuesList.size());
                prevReqBodyJsons = currReqBodyJsons;
                currReqBodyJsons = new ArrayList<>();
            }
        }

        List<String> reqBodyJsons = prevReqBodyJsons.stream()
                .map(reqBodyJson -> "{" + reqBodyJson + "}")
                .collect(Collectors.toList());
        return reqBodyJsons;
    }

    @SneakyThrows
    private List<List<String>> getRiskFactorCategoriesValuesListFromRiskFactorCategories(
            List<String> riskFactorCategories, RSEReferenceValuesAPIResponseDTO rseReferenceValuesAPIResponseDTO) {
        List<List<String>> riskFactorCategoryValuesList = new ArrayList<>();
        for (String riskFactorCategory : riskFactorCategories) {

            Class<?> objClass = rseReferenceValuesAPIResponseDTO.getClass();
            Method getRiskFactorMethod = objClass.getMethod("get" + riskFactorCategory.substring(0, 1).toUpperCase() +
                                                                    riskFactorCategory.substring(1,
                                                                                                 riskFactorCategory.length()) +
                                                                    "s");
            List<RSERefUidDescriptionPOJO> riskFactorPOJOs =
                    (List<RSERefUidDescriptionPOJO>) getRiskFactorMethod.invoke(rseReferenceValuesAPIResponseDTO);

            List<String> riskFactorCategoryValues = new ArrayList<>();
            riskFactorPOJOs.stream().forEach(rf -> riskFactorCategoryValues.add(rf.getUid()));
            logger.info("riskFactorCategory='" + riskFactorCategory + "' | size='" + riskFactorCategoryValues.size() +
                                "' | riskFactorValues='" + riskFactorCategoryValues + "'");

            riskFactorCategoryValuesList.add(riskFactorCategoryValues);
        }
        logger.info("riskFactorCategoryValuesList = '" + riskFactorCategoryValuesList + "'");

        return riskFactorCategoryValuesList;
    }

    private String getProperRiskFactorCategoryKey(String key) {
        switch (key) {
            case "country":
                key = "country";
                break;
            case "sourcingType":
            case "sourcing_type":
                key = "sourcing_type";
                break;
            case "revenue":
                key = "revenue";
                break;
            case "affiliation":
                key = "affiliation";
                break;
            case "sourcingMethod":
            case "sourcing_method":
                key = "sourcing_method";
                break;
            case "spendCategory":
            case "spend_category":
                key = "spend_category";
                break;
            case "productImpact":
            case "product_impact":
                key = "product_impact";
                break;
            case "commodityType":
            case "commodity_type":
                key = "commodity_type";
                break;
            case "industry":
                key = "industry";
                break;
            case "designAgreement":
            case "design_agreement":
                key = "design_agreement";
                break;
            case "relationshipVisibility":
            case "relationship_visibility":
                key = "relationship_visibility";
                break;
            case "businessType":
            case "business_type":
                key = "business_type";
                break;
            default:
                break;
        }
        return key;
    }

    private String calculateElapsedTime(long startMillis, long endMillis) {
        long totalMillis = endMillis - startMillis;
        long HH = TimeUnit.MILLISECONDS.toHours(totalMillis);
        long mm = TimeUnit.MILLISECONDS.toMinutes(totalMillis) % 60;
        long ss = TimeUnit.MILLISECONDS.toSeconds(totalMillis) % 60;
        long SSS = TimeUnit.MILLISECONDS.toMillis(totalMillis) % 1000;
        return String.format("%02d:%02d:%02d.%03d", HH, mm, ss, SSS);
    }

    private void setRiskScoringRangeMINMAXWithSuffix5Digits(PublicRSEAddRangeRequestDTO publicRSEAddRangeRequestDTO,
            String intervalMin, String intervalMax) {
        String intervalSuffix = Long.toString((new Date().getTime() / 1000) % 100000);
        logger.info(
                "================================ INTERVAL intervalMin=" + publicRSEAddRangeRequestDTO.getMin() + "'");
        logger.info("================================ nowDate.getTime=" + intervalSuffix + "'");

        Double min = Double.valueOf(
                Double.parseDouble(intervalMin + String.valueOf((Integer.parseInt(intervalSuffix) + 0))));
        Double max = Double.valueOf(
                Double.parseDouble(intervalMin + String.valueOf((Integer.parseInt(intervalSuffix) + 1))));
        if (Double.parseDouble(intervalMin) < min.doubleValue() &&
                max.doubleValue() < Double.parseDouble(intervalMax)) {
            publicRSEAddRangeRequestDTO.setMin(String.valueOf(min));
            publicRSEAddRangeRequestDTO.setMax(String.valueOf(max));
        }
    }

    @SneakyThrows
    private void queryPublicRiskScoringEngineREFERENCESGENApiEndpoint(String referenceCategory, Map paramsMap) {

        Response getResponse =
                sendGETRequestToPublicRiskScoringEngineREFERENCESApiEndpoint(referenceCategory, paramsMap);
        context.getScenarioContext().setContext(referenceCategory, getResponse);

        RSEPublicReferenceValuesAPIResponseDTO rsePublicReferenceValuesAPIResponseDTO = null;

        switch (referenceCategory) {
            case "affiliation":
            case "commodity-type":
            case "company-type":
            case "country":
            case "design-agreement":
            case "industry-type":
            case "product-impact":
            case "relationship-visibility":
            case "revenue":
            case "sourcing-method":
            case "sourcing-type":
            case "spend-category":
                rsePublicReferenceValuesAPIResponseDTO =
                        objectMapper.readValue(getResponse.getBody().asString(),
                                               new TypeReference<RSEPublicReferenceValuesAPIResponseDTO<RSEPublicReferenceValuePOJO>>() {
                                               });
                break;
            case "business-category":
                rsePublicReferenceValuesAPIResponseDTO =
                        objectMapper.readValue(getResponse.getBody().asString(),
                                               new TypeReference<RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefBUSCATValuePOJO>>() {
                                               });
                break;
            case "retrieve-risk-scoring-range":
                rsePublicReferenceValuesAPIResponseDTO =
                        objectMapper.readValue(getResponse.getBody().asString(),
                                               new TypeReference<RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefRSRANGEValuePOJO>>() {
                                               });
                break;
            case "retrieve-rating-groups":
                rsePublicReferenceValuesAPIResponseDTO =
                        objectMapper.readValue(getResponse.getBody().asString(),
                                               new TypeReference<RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefRATINGGRPValuePOJO>>() {
                                               });
                break;
            case "industry-business-map":
                RSEPublicReferenceValuesINDBUSMAPAPIResponseDTO<RSEPublicRefINDBUSMAPValuePOJO>
                        rsePublicReferenceValuesINDBUSMAPAPIResponseDTO =
                        objectMapper.readValue(getResponse.getBody().asString(),
                                               new TypeReference<RSEPublicReferenceValuesINDBUSMAPAPIResponseDTO<RSEPublicRefINDBUSMAPValuePOJO>>() {
                                               });

                rsePublicReferenceValuesAPIResponseDTO =
                        new RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefINDBUSMAPValuePOJO>();
                rsePublicReferenceValuesAPIResponseDTO.setMessage(
                        rsePublicReferenceValuesINDBUSMAPAPIResponseDTO.getMessage());
                List<RSEPublicRefINDBUSMAPValuePOJO> data = new ArrayList<RSEPublicRefINDBUSMAPValuePOJO>();
                data.add(rsePublicReferenceValuesINDBUSMAPAPIResponseDTO.getData());
                rsePublicReferenceValuesAPIResponseDTO.setData(data);
                break;
        }

        context.getScenarioContext().setContext(referenceCategory + _DTO, rsePublicReferenceValuesAPIResponseDTO);

        logger.info("================ ACTIONS GET API-EPT: response = '" + getResponse.getBody().prettyPrint() + "'");
    }

}
