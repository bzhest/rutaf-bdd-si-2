package com.refinitiv.asts.test.api.stepDefinitions.riskscoringengine;

import com.refinitiv.asts.test.api.dto.riskscoringengine.response.*;
import io.restassured.response.Response;
import lombok.SneakyThrows;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;
import java.util.*;

import static com.refinitiv.asts.test.api.constants.ApiRequestConstants.DASH;
import static com.refinitiv.asts.test.api.constants.ApiRequestConstants.UNDERSCORE;

public class RiskScoringEngineApiAssertions {

    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    public static Map<String, String> errorInterationsMap = new LinkedHashMap<>();

    public void verifyEquivalentRiskProfiles(RiskScoringEngineAPIResponseDTO riskScoringEngineAPIResponseDTO,
            RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO, String requestBodyJson) {
        logger.info("================ ASSERT POST API-EPT: apiAverageRiskScore             = '" +
                            riskScoringEngineAPIResponseDTO.getAverageRiskScore() + "' | '" +
                            riskScoringEngineREFResponseDTO.getAverageRiskScore() + "'");
        logger.info("================ ASSERT POST API-EPT: riskScoringEngineAPIResponseDTO = '" +
                            riskScoringEngineAPIResponseDTO + "'");
        logger.info("================ ASSERT POST REF-DOC: riskScoringEngineREFResponseDTO = '" +
                            riskScoringEngineREFResponseDTO + "'");

        RiskScoringEngineApiAssertion rseApiAssertion = new RiskScoringEngineApiAssertion();
        rseApiAssertion.assertEquals(riskScoringEngineAPIResponseDTO.getModelName().trim(),
                                     riskScoringEngineREFResponseDTO.getModelName().trim(),
                                     "RSE API Endpoint [MODEL NAME] is NOT EQUAL to REFERENCE Document [MODEL NAME]");
        rseApiAssertion.assertEquals(riskScoringEngineAPIResponseDTO.getAverageRiskScore(),
                                     riskScoringEngineREFResponseDTO.getAverageRiskScore(),
                                     "RSE API Endpoint [AVG. RISK SCORE] is NOT EQUAL to REFERENCE Document [AVG. RISK SCORE]");
        rseApiAssertion.assertEquals(riskScoringEngineAPIResponseDTO.getRiskAreas(),
                                     riskScoringEngineREFResponseDTO.getRiskAreas(),
                                     "RSE API Endpoint [RISK AREA SCORE/S] are NOT EQUAL to REFERENCE Document [RISK AREA SCORE/S]");

        try {
            rseApiAssertion.assertAll();
            logger.info("================ ASSERT:  EQUALS -  [MODEL CODE/NAME]  [AVG RISK SCORE]  [RISK-AREA SCORE/S]");
            logger.info("================ ASSERT:  ErrorCount='" + errorInterationsMap.size() + "'");
            for (Map.Entry<String, String> assertionErrorsEntry : errorInterationsMap.entrySet()) {
                logger.info("================ ASSERT: Assert FAILED: '" + assertionErrorsEntry.getKey() + "' - '" +
                                    assertionErrorsEntry.getValue() + "'");
            }
        } catch (AssertionError aex) {
            errorInterationsMap.put(requestBodyJson, aex.getMessage());
            logger.info("================ ASSERT:  NOT EQUAL - '" + aex.getMessage() + "'");

            printCompareAPIEndpointREFDocumentResults(riskScoringEngineAPIResponseDTO, riskScoringEngineREFResponseDTO);

            logger.info("================ ASSERT:  ErrorCount='" + errorInterationsMap.size() + "'");
            for (Map.Entry<String, String> assertionErrorsEntry : errorInterationsMap.entrySet()) {
                logger.info("================ ASSERT: Assert FAILED: '" + assertionErrorsEntry.getKey() + "' - '" +
                                    assertionErrorsEntry.getValue() + "'");
            }
            throw aex;
        }
    }

    @SneakyThrows
    public void verifyAllIterationsEquivalentRiskProfiles() {
        logger.info("================ ASSERT: SUMMARY");
        logger.info(
                "================ ASSERT: ErrorCount = '" + RiskScoringEngineApiAssertions.errorInterationsMap.size() +
                        "'");
        for (Map.Entry<String, String> assertionErrorsEntry : RiskScoringEngineApiAssertions.errorInterationsMap.entrySet()) {
            logger.info("================ ASSERT: Assert FAILED: '" + assertionErrorsEntry.getKey() + "' - '" +
                                assertionErrorsEntry.getValue() + "'");
        }

        if (RiskScoringEngineApiAssertions.errorInterationsMap.size() > 0) {
            throw new Exception(
                    "ERROR: Assert failed - there are '" + RiskScoringEngineApiAssertions.errorInterationsMap.size() +
                            "' errors found.");
        }
    }

    public void verifyRSEReferenceValues(String referenceCategory, Response response,
            RSEPublicReferenceValuesAPIResponseDTO rsePublicReferenceValuesAPIResponseDTO) {
        logger.info("================ ASSERT: REF. CATEGORY='" + referenceCategory + "' | RESPONSE CODE='" +
                            response.getStatusCode() + "' | DATA COUNT='" +
                            rsePublicReferenceValuesAPIResponseDTO.getData().size() + "'");

        RiskScoringEngineApiAssertion rseApiAssertion = new RiskScoringEngineApiAssertion();
        rseApiAssertion.assertEquals(response.getStatusCode(), 200,
                                     "RDDS PUBLIC RSE API Endpoint RESPONSE [CODE] is NOT EQUAL to 200");
        rseApiAssertion.assertTrue(rsePublicReferenceValuesAPIResponseDTO.getData().size() > 0,
                                   "RDDS PUBLIC RSE API Endpoint RESPONSE [DATA] is EMPTY");

        rseApiAssertion.assertAll();
    }

    public void verifyRSEModelValues(String contextKey, Response response,
            RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO) {
        logger.info(
                "================ ASSERT: MODEL ='" + contextKey + "' | RESPONSE CODE='" + response.getStatusCode() +
                        "' | DATA COUNT='" + rsePublicModelValuesAPIResponseDTO.getData().size() + "'");

        RiskScoringEngineApiAssertion rseApiAssertion = new RiskScoringEngineApiAssertion();
        rseApiAssertion.assertEquals(response.getStatusCode(), 200,
                                     "RDDS PUBLIC RSE MODELS Api Endpoint RESPONSE [CODE] is NOT EQUAL to 200");
        rseApiAssertion.assertTrue(rsePublicModelValuesAPIResponseDTO.getData().size() > 0,
                                   "RDDS PUBLIC RSE MODELS Api Endpoint RESPONSE [DATA] is EMPTY");

        rseApiAssertion.assertAll();
    }

    public void verifyRSERangeValues(String contextKey, Response response,
            RSEPublicRangeValuesAPIResponseDTO rsePublicRangeValuesAPIResponseDTO) {
        logger.info(
                "================ ASSERT: RANGE ='" + contextKey + "' | RESPONSE CODE='" + response.getStatusCode() +
                        "' | DATA COUNT='" + rsePublicRangeValuesAPIResponseDTO.getData().size() + "'");

        RiskScoringEngineApiAssertion rseApiAssertion = new RiskScoringEngineApiAssertion();
        rseApiAssertion.assertEquals(response.getStatusCode(), 200,
                                     "RDDS PUBLIC RSE RANGE Api Endpoint RESPONSE [CODE] is NOT EQUAL to 200");
        rseApiAssertion.assertTrue(rsePublicRangeValuesAPIResponseDTO.getData().size() > 0,
                                   "RDDS PUBLIC RSE RANGE Api Endpoint RESPONSE [DATA] is EMPTY");

        rseApiAssertion.assertAll();
    }

    public void verifyRSEModelIdRangeValues(String contextKey, Response response,
            RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO) {
        logger.info("================ ASSERT: RANGE-MODELID ='" + contextKey + "' | RESPONSE CODE='" +
                            response.getStatusCode() + "' | DATA COUNT='" +
                            rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().size() + "'");

        RiskScoringEngineApiAssertion rseApiAssertion = new RiskScoringEngineApiAssertion();
        rseApiAssertion.assertEquals(response.getStatusCode(), 200,
                                     "RDDS PUBLIC RSE RANGE-MODELID Api Endpoint RESPONSE [CODE] is NOT EQUAL to 200");
        rseApiAssertion.assertTrue(rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().size() > 0,
                                   "RDDS PUBLIC RSE RANGE Api Endpoint RESPONSE [DATA] is EMPTY");

        for (int i = 0; i < rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().size(); i++) {
            RangeItemPOJO rangeItemPOJO1 =
                    (RangeItemPOJO) rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().get(i);
            if (rangeItemPOJO1.getDeleted()) {
                continue;
            } else {
                for (int j = 0; j < rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().size(); j++) {
                    if (i == j) {
                        continue;
                    } else {
                        RangeItemPOJO rangeItemPOJO2 =
                                (RangeItemPOJO) rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().get(j);
                        rseApiAssertion.assertTrue(!(rangeItemPOJO1.getMin() >= rangeItemPOJO1.getMax()),
                                                   "RDDS PUBLIC RSE RANGE-MODELID [" + rangeItemPOJO1.getName() + ": " +
                                                           rangeItemPOJO1.getMin() + "-" + rangeItemPOJO1.getMax() +
                                                           "] Api Endpoint RESPONSE [MIN>MAX] has range with MIN >= MAX");
                        rseApiAssertion.assertTrue(!(rangeItemPOJO1.getName().equals(rangeItemPOJO2.getName())),
                                                   "RDDS PUBLIC RSE RANGE-MODELID [" + rangeItemPOJO1.getName() +
                                                           "] Api Endpoint RESPONSE [NAME] has DUPLICATE with [" +
                                                           rangeItemPOJO2.getName() + "]");
                        rseApiAssertion.assertTrue(!(rangeItemPOJO1.getMin() >= rangeItemPOJO2.getMin() &&
                                                           rangeItemPOJO1.getMin() <= rangeItemPOJO2.getMax()),
                                                   "RDDS PUBLIC RSE RANGE-MODELID [" + rangeItemPOJO1.getName() + ": " +
                                                           rangeItemPOJO1.getMin() + "-" + rangeItemPOJO1.getMax() +
                                                           "] Api Endpoint RESPONSE [  MIN  ] has OVERLAP with [" +
                                                           rangeItemPOJO2.getName() + ": " + rangeItemPOJO2.getMin() +
                                                           "-" + rangeItemPOJO2.getMax() + "]");
                        rseApiAssertion.assertTrue(!(rangeItemPOJO1.getMax() >= rangeItemPOJO2.getMin() &&
                                                           rangeItemPOJO1.getMax() <= rangeItemPOJO2.getMax()),
                                                   "RDDS PUBLIC RSE RANGE-MODELID [" + rangeItemPOJO1.getName() + ": " +
                                                           rangeItemPOJO1.getMin() + "-" + rangeItemPOJO1.getMax() +
                                                           "] Api Endpoint RESPONSE [  MAX  ] has OVERLAP with [" +
                                                           rangeItemPOJO2.getName() + ": " + rangeItemPOJO2.getMin() +
                                                           "-" + rangeItemPOJO2.getMax() + "]");
                        rseApiAssertion.assertTrue(!(rangeItemPOJO1.getMin() <= rangeItemPOJO2.getMin() &&
                                                           rangeItemPOJO1.getMax() >= rangeItemPOJO2.getMax()),
                                                   "RDDS PUBLIC RSE RANGE-MODELID [" + rangeItemPOJO1.getName() + ": " +
                                                           rangeItemPOJO1.getMin() + "-" + rangeItemPOJO1.getMax() +
                                                           "] Api Endpoint RESPONSE [MIN-MAX] has OVERLAP with [" +
                                                           rangeItemPOJO2.getName() + ": " + rangeItemPOJO2.getMin() +
                                                           "-" + rangeItemPOJO2.getMax() + "]");
                    } // end if-else
                } // end for
            } // end if-else
        } //end for
        rseApiAssertion.assertAll();
    }

    public void verifyScoringRangeAdded(
            RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO, String rangeName,
            String modelName, String min, String max, String color) {
        logger.info("================ ASSERT: dto.modelName='" +
                            rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges()
                                    .get(rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges().size() - 1)
                                    .getName() + "' | modelName='" + modelName + "' | rangeName='" + rangeName +
                            "' | min='" + min + "' | max='" + max + "' | color='" + color + "'");
        RangeItemPOJO targetRangeItemPOJO1 = rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges()
                .stream()
                .filter(rangeItemPOJO -> rangeItemPOJO != null)
                .filter(rangeItemPOJO -> rangeItemPOJO.getMin().equals(Double.parseDouble(min)))
                .findFirst()
                .orElseThrow();
        String resultRangeName = targetRangeItemPOJO1.getName();
        logger.info("================ ASSERT: resultRangeName='" + resultRangeName + "' | modelName='" + modelName +
                            "' | rangeName='" + rangeName + "'");

        String expectedRangeName = rangeName + UNDERSCORE + min + DASH + max;

        RangeItemPOJO targetRangeItemPOJO = rsePublicModelIdRangeValuesAPIResponseDTO.getData().getRanges()
                .stream()
                .filter(rangeItemPOJO -> rangeItemPOJO != null)
                .filter(rangeItemPOJO -> rangeItemPOJO.getName().equals(expectedRangeName))
                .findFirst()
                .orElseThrow();

        RiskScoringEngineApiAssertion rseApiAssertion = new RiskScoringEngineApiAssertion();

        rseApiAssertion.assertTrue(targetRangeItemPOJO.getName().equals(expectedRangeName),
                                   "ERROR: New/Updated range NOT added/updated - 'range name' NOT equal to '" +
                                           expectedRangeName + "'");
        rseApiAssertion.assertTrue(targetRangeItemPOJO.getMin().equals(Double.parseDouble(min)),
                                   "ERROR: New/Updated range NOT added/updated - 'min' NOT equal to '" + min + "'");
        rseApiAssertion.assertTrue(targetRangeItemPOJO.getMax().equals(Double.parseDouble(max)),
                                   "ERROR: New/Updated range NOT added/updated - 'max' not equal to '" + max + "'");
        rseApiAssertion.assertTrue(targetRangeItemPOJO.getColor().equals(color),
                                   "ERROR: New range NOT added/updated - 'color' not equal to '" + color + "'");

        rseApiAssertion.assertAll();
    }

    private void printCompareAPIEndpointREFDocumentResults(
            RiskScoringEngineAPIResponseDTO riskScoringEngineAPIResponseDTO,
            RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO) {

        List<RiskAreaPOJO> riskAreasAPIList = riskScoringEngineAPIResponseDTO.getRiskAreas();
        List<RiskAreaPOJO> riskAreasREFList = riskScoringEngineREFResponseDTO.getRiskAreas();

        for (int i = 0; i < riskAreasAPIList.size(); i++) {
            logger.info("");
            logger.info("================ ASSERT POST API-EPT: " + riskAreasAPIList.get(i));
            try {
                logger.info("================ ASSERT POI  REF-DOC: " + riskAreasREFList.get(i));
                logger.info("================ ASSERT      Match? : " +
                                    (riskAreasAPIList.get(i).equals(riskAreasREFList.get(i)) ? "EQUAL ! ! !" :
                                            "NOT EQUAL # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"));
            } catch (Exception x) {
                logger.info(
                        "================ ACTIONS POI  REF-DOC: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
            }
        }

        logger.info("");
        logger.info("================ ASSERT POST API-EPT: apiAverageRiskScore = '" +
                            riskScoringEngineAPIResponseDTO.getAverageRiskScore() + "' ================");
        logger.info("================ ASSERT POI  REF-DOC: refAverageRiskScore = '" +
                            riskScoringEngineREFResponseDTO.getAverageRiskScore() + "' ================");
        logger.info("================ ASSERT      Match? : " + (riskScoringEngineAPIResponseDTO.getAverageRiskScore()
                .equals(riskScoringEngineREFResponseDTO.getAverageRiskScore()) ? "EQUAL ! ! ! ! ! ! ! ! ! ! ! !" :
                "NOT EQUAL # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"));
        logger.info("");
    }

}
