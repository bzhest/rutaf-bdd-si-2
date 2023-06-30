package com.refinitiv.asts.test.api.stepDefinitions.riskscoringengine;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.actions.RiskScoringEngineApiActions;
import com.refinitiv.asts.test.api.dataproviders.JsonApiDataTransfer;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.PublicRSEComputeAPIRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.PublicRSEAddRangeRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.RiskScoringEngineAPIRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.request.RiskScoringEngineREFRequestDTO;
import com.refinitiv.asts.test.api.dto.riskscoringengine.response.*;
import com.refinitiv.asts.test.api.stepDefinitions.ApiBaseSteps;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import lombok.SneakyThrows;
import org.springframework.beans.BeanUtils;

import java.util.Map;

import static com.refinitiv.asts.test.api.constants.ApiRequestConstants.*;
import static com.refinitiv.asts.test.api.dataproviders.ApiDataProvider.RISKSCORINGENGINE_REQUEST;

public class RiskScoringEngineApiSteps extends ApiBaseSteps {

    private RiskScoringEngineApiActions riskScoringEngineAction;
    private static final RiskScoringEngineApiAssertions riskScoringEngineApiAssertions =
            new RiskScoringEngineApiAssertions();

    public RiskScoringEngineApiSteps(ScenarioCtxtWrapper context) {
        super(context);
        riskScoringEngineAction = new RiskScoringEngineApiActions(context);
    }

    @Given("Query Risk Scoring Engine reference values from GET Request to Risk Scoring Engine API Endpoint into {string}")
    public void getAllRiskScoringEngineReferenceValues(String riskFactorCategoriesChain) {
        riskScoringEngineAction.fetchIntoContextAllRiskScoringEngineReferenceValues(riskFactorCategoriesChain);
    }

    @Given("Request entries in .json file using {string} as source")
    public void createRequestEntriesInJsonFIle(String sourceJsonFile) {
        logger.info("sourceJsonFile = [" + sourceJsonFile + "]");

        //  Uncomment for when the 'sourceJsonFile is changed, updated or added to.
        //  riskScoringEngineAction.createRequestEntriesInJsonFile(sourceJsonFile);
    }

    @Given("Query available models in DEV PUBLIC Risk Scoring Engine Api Endpoint")
    public void getAllRiskScoringEngineMODELValues_DEV() {
        riskScoringEngineAction.callGETPublicRiskScoringEngineMODELSApiEndpoint_DEV("");
    }

    @Given("Query available models in ENV PUBLIC Risk Scoring Engine Api Endpoint")
    public void getAllRiskScoringEngineMODELValues_ENV() {
        riskScoringEngineAction.callGETPublicRiskScoringEngineMODELSApiEndpoint_ENV("");
    }

    @SneakyThrows
    @When("User invokes POST PUBLIC RSE API endpoint with {string} risk factors for PUBLIC API risk score profile")
    public void callPOSTRequestToPublicRiskScoringEngineCOMPUTEApiEndpoint(String riskFactors) {
        logger.info("riskFactors = [" + riskFactors + "]");
        JsonApiDataTransfer<RiskScoringEngineAPIRequestDTO> requestJsonApiDataTransfer =
                new JsonApiDataTransfer<>(RISKSCORINGENGINE_REQUEST);
        RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO =
                requestJsonApiDataTransfer.getRequestJsonData(riskFactors);
        ObjectMapper mapper = new ObjectMapper();

        String jsonString1 = mapper.writeValueAsString(riskScoringEngineAPIRequestDTO);
        logger.info("1. jsonString1 = |" + jsonString1 + "|");

        Map<String, String> jsonMap = mapper.readValue(jsonString1, Map.class);
        jsonMap.put("industryType", jsonMap.get("industry"));
        jsonMap.remove("industry");
        jsonMap.put("businessType", jsonMap.get("business_type"));
        jsonMap.remove("business_type");
        jsonMap.put("parentBusinessType", jsonMap.get("parent_business_type"));
        jsonMap.remove("parent_business_type");
        jsonMap.put("childBusinessType", jsonMap.get("child_business_type"));
        jsonMap.remove("child_business_type");
        jsonMap.put("spendCategory", jsonMap.get("spend_category"));
        jsonMap.remove("spend_category");
        jsonMap.put("productDesignAgreement", jsonMap.get("design_agreement"));
        jsonMap.remove("design_agreement");
        jsonMap.put("relationshipVisibility", jsonMap.get("relationship_visibility"));
        jsonMap.remove("relationship_visibility");
        jsonMap.put("sourcingMethod", jsonMap.get("sourcing_method"));
        jsonMap.remove("sourcing_method");
        jsonMap.put("sourcingType", jsonMap.get("sourcing_type"));
        jsonMap.remove("sourcing_type");
        jsonMap.put("productImpact", jsonMap.get("product_impact"));
        jsonMap.remove("product_impact");
        jsonMap.put("commodityType", jsonMap.get("commodity_type"));
        jsonMap.remove("commodity_type");
        logger.info("2. jsonMap = |" + jsonMap.toString() + "|");

        PublicRSEComputeAPIRequestDTO publicRSEComputeAPIRequestDTO =
                mapper.convertValue(jsonMap, PublicRSEComputeAPIRequestDTO.class);

        // NOT needed: rationlizing 'industry' and 'business-type' into parent/child business type fields
        logger.info("3. publicRSEComputeAPIRequestDTO = |" + publicRSEComputeAPIRequestDTO.toString() + "|");
        String jsonString2 = mapper.writeValueAsString(publicRSEComputeAPIRequestDTO);
        logger.info("4. jsonString2 = |" + jsonString2 + "|");

        riskScoringEngineAction.callPOSTRequestToPublicRiskScoringEngineCOMPUTEApiEndpoint(riskFactors,
                                                                                           publicRSEComputeAPIRequestDTO);
    }

    @SneakyThrows
    @When("User invokes POST Risk Scoring Engine API endpoint with {string} risk factors for API risk score profile")
    public void callPOSTRequestToRiskScoringEngineApiEndpoint(String riskFactors) {
        logger.info("riskFactors = [" + riskFactors + "]");
        JsonApiDataTransfer<RiskScoringEngineAPIRequestDTO> requestJsonApiDataTransfer =
                new JsonApiDataTransfer<>(RISKSCORINGENGINE_REQUEST);
        RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO =
                requestJsonApiDataTransfer.getRequestJsonData(riskFactors);

        rationalizeRSERequestOnIndustryParentChildBusinessTypes(riskScoringEngineAPIRequestDTO);
        logger.info("================ REQUEST_DTO JSON = '" +
                            new ObjectMapper().writeValueAsString(riskScoringEngineAPIRequestDTO) + "'");

        riskScoringEngineAction.callPOSTRequestToRiskScoringEngineAPIEndpoint(riskFactors,
                                                                              riskScoringEngineAPIRequestDTO);
    }

    @When("User invokes POST Risk Scoring Engine API Endpoint on all {string} risk factor category values against REFERENCE Excel spreadsheet {string}")
    public void sendPOSTRequestToRiskScoringEngineAPIEndpoint(String riskFactorCategoriesChain,
            String refSpreadsheetFilename) {
        riskScoringEngineAction.sendPOSTRequestToRiskScoringEngineAPIEndpoint(riskFactorCategoriesChain,
                                                                              refSpreadsheetFilename);
    }

    @SneakyThrows
    @When("User queries Risk Scoring Engine REFERENCE Excel spreadsheet {string} with the same {string} for REFERENCE risk score profile")
    public void queryRiskScoringEngineReferenceDocument(String refSpreadsheetFilename, String riskFactors) {
        logger.info("================ STEPS POI  REF-DOC: RiskFactors = [" + riskFactors + "] ================");

        JsonApiDataTransfer<RiskScoringEngineAPIRequestDTO> requestJsonApiDataTransfer =
                new JsonApiDataTransfer<>(RISKSCORINGENGINE_REQUEST);
        RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO =
                requestJsonApiDataTransfer.getRequestJsonData(riskFactors);
        rationalizeRSERequestOnIndustryParentChildBusinessTypes(riskScoringEngineAPIRequestDTO);

        RiskScoringEngineREFRequestDTO riskScoringEngineREFRequestDTO = new RiskScoringEngineREFRequestDTO();
        BeanUtils.copyProperties(riskScoringEngineAPIRequestDTO, riskScoringEngineREFRequestDTO);

        riskScoringEngineAction.queryReferenceDocumentForRiskProfile(refSpreadsheetFilename, riskFactors,
                                                                     riskScoringEngineREFRequestDTO);
    }

    @When("User invokes GET Request to PUBLIC Risk Scoring Engine REFERENCE Api Endpoint for {string} values")
    public void callGETPublicRiskScoringEngineREFERENCESApiEndpoint(String referenceCategory) {
        riskScoringEngineAction.callGETPublicRiskScoringEngineREFERENCESApiEndpoint(referenceCategory);
    }

    @When("User invokes GET Request to PUBLIC Risk Scoring Engine MODELS-RANGE Api Endpoints with {string} value")
    public void callGETPublicRiskScoringEngineMODELSRANGEApiEndpoint(String uriPath) {
        riskScoringEngineAction.callGETPublicRiskScoringEngineMODELSRANGEApiEndpoint(uriPath);
    }

    @When("User invokes ADD RANGE {string} to model {string} with range name {string} and interval {string}-{string} and color {string}")
    public void callPOSTPublicRiskScoringEngineADDRANGEApiEndpointCase(String rangeRef, String modelName,
            String rangeName, String intervalMin, String intervalMax, String color) {
        PublicRSEAddRangeRequestDTO publicRSEAddRangeRequestDTO =
                riskScoringEngineAction.buildPublicRSEAddRangeRequestDTO(rangeRef, rangeName, intervalMin, intervalMax,
                                                                         color);
        riskScoringEngineAction.callPOSTPublicRiskScoringEngineADDRANGEApiEndpointCase(modelName, rangeName,
                                                                                       publicRSEAddRangeRequestDTO);
    }

    @When("User invokes UPDATE RANGE of model {string} and range name {string} with new color {string}")
    public void callPATCHPublicRiskScoringEngineUPDATERANGEApiEndpointCase(String modelName, String rangeName,
            String updateColor) {
        riskScoringEngineAction.callPATCHPublicRiskScoringEngineUPDATERANGEApiEndpointCase(modelName, rangeName,
                                                                                           updateColor);
    }

    @Then("Risk profile with the same {string} should be equal for both Risk Scoring Engine API Endpoint and REFERENCE Excel spreadsheet")
    public void verifyEquivalentRiskProfiles(String riskFactors) {

        RiskScoringEngineAPIResponseDTO riskScoringEngineAPIResponseDTO =
                (RiskScoringEngineAPIResponseDTO) context.getScenarioContext().getContext(riskFactors + _API_DTO);
        RiskScoringEngineREFResponseDTO riskScoringEngineREFResponseDTO =
                (RiskScoringEngineREFResponseDTO) context.getScenarioContext().getContext(riskFactors + _REF_DTO);

        riskScoringEngineApiAssertions.verifyEquivalentRiskProfiles(riskScoringEngineAPIResponseDTO,
                                                                    riskScoringEngineREFResponseDTO, riskFactors);
    }

    @Then("New range {string} is successfully added to {string}")
    public void verifyADDRANGESuccess(String rangeName, String modelName) {
        RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO =
                (RSEPublicModelIdRangeValuesAPIResponseDTO) context.getScenarioContext()
                        .getContext(modelName + UNDERSCORE + rangeName + _DTO);
        String min = (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_min");
        String max = (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_max");
        String color = (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_color");
        logger.info("================ STEPS: ModelName='" +
                            rsePublicModelIdRangeValuesAPIResponseDTO.getData().getModelName() + "' | min='" + min +
                            "' | max='" + max + "' | color='" + color + "'");
        riskScoringEngineApiAssertions.verifyScoringRangeAdded(rsePublicModelIdRangeValuesAPIResponseDTO, rangeName,
                                                               modelName, min, max, color);
    }

    @Then("Target range {string} in model {string} is successfully updated to color {string}")
    public void verifyUPDATERANGESuccess(String rangeName, String modelName, String updateColor) {
        RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO =
                (RSEPublicModelIdRangeValuesAPIResponseDTO) context.getScenarioContext()
                        .getContext(modelName + UNDERSCORE + rangeName + _DTO);
        String min = (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_min");
        String max = (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_max");
        String color = (String) context.getScenarioContext().getContext(modelName + UNDERSCORE + rangeName + "_color");
        logger.info("================ STEPS: ModelName='" +
                            rsePublicModelIdRangeValuesAPIResponseDTO.getData().getModelName() + "' | min='" + min +
                            "' | max='" + max + "' | color='" + color + "'");
        riskScoringEngineApiAssertions.verifyScoringRangeAdded(rsePublicModelIdRangeValuesAPIResponseDTO, rangeName,
                                                               modelName, min, max, updateColor);
    }

    @SneakyThrows
    @Then("All iterations must have equal API Endpoint results and REFERENCE Excel spreadsheet outputs")
    public void verifyAllIterationsEquivalentRiskProfiles() {
        riskScoringEngineApiAssertions.verifyAllIterationsEquivalentRiskProfiles();
    }

    @Then("Response contains the {string} values")
    public void verifyRSEReferenceValues(String referenceCategory) {

        Response response = (Response) context.getScenarioContext().getContext(referenceCategory);

        RSEPublicReferenceValuesAPIResponseDTO rsePublicReferenceValuesAPIResponseDTO;

        switch (referenceCategory) {
            case "business-category":
                rsePublicReferenceValuesAPIResponseDTO =
                        (RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefBUSCATValuePOJO>) context.getScenarioContext()
                                .getContext(referenceCategory + _DTO);
                break;
            case "retrieve-risk-scoring-range":
                rsePublicReferenceValuesAPIResponseDTO =
                        (RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefRSRANGEValuePOJO>) context.getScenarioContext()
                                .getContext(referenceCategory + _DTO);
                break;
            case "retrieve-rating-groups":
                rsePublicReferenceValuesAPIResponseDTO =
                        (RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefRATINGGRPValuePOJO>) context.getScenarioContext()
                                .getContext(referenceCategory + _DTO);
                break;
            case "industry-business-map":
                rsePublicReferenceValuesAPIResponseDTO =
                        (RSEPublicReferenceValuesAPIResponseDTO<RSEPublicRefINDBUSMAPValuePOJO>) context.getScenarioContext()
                                .getContext(referenceCategory + _DTO);
                break;
            default:
                rsePublicReferenceValuesAPIResponseDTO =
                        (RSEPublicReferenceValuesAPIResponseDTO<RSEPublicReferenceValuePOJO>) context.getScenarioContext()
                                .getContext(referenceCategory + _DTO);
                break;
        }

        riskScoringEngineApiAssertions.verifyRSEReferenceValues(referenceCategory, response,
                                                                rsePublicReferenceValuesAPIResponseDTO);
    }

    @Then("Response outputs the {string} values")
    public void verifyRSEModelRangeValues(String uriPath) {
        String modelsKey = "models";
        Response modelsResponse = (Response) context.getScenarioContext().getContext(modelsKey);
        RSEPublicModelValuesAPIResponseDTO rsePublicModelValuesAPIResponseDTO =
                (RSEPublicModelValuesAPIResponseDTO) context.getScenarioContext().getContext(modelsKey + _DTO);

        riskScoringEngineApiAssertions.verifyRSEModelValues(modelsKey, modelsResponse,
                                                            rsePublicModelValuesAPIResponseDTO);

        String rangeKey = uriPath + "_range";
        Response rangeResponse = (Response) context.getScenarioContext().getContext(rangeKey);
        RSEPublicRangeValuesAPIResponseDTO rsePublicRangeValuesAPIResponseDTO =
                (RSEPublicRangeValuesAPIResponseDTO) context.getScenarioContext().getContext(rangeKey + _DTO);

        riskScoringEngineApiAssertions.verifyRSERangeValues(rangeKey, modelsResponse,
                                                            rsePublicRangeValuesAPIResponseDTO);

        for (RSEPublicModelValuePOJO rsePublicModelValuePOJO : rsePublicModelValuesAPIResponseDTO.getData()) {

            String modelId = rsePublicModelValuePOJO.getId();
            String rangeModelIdKey = uriPath + "_range_" + modelId;
            Response rangeModelIdResponse = (Response) context.getScenarioContext().getContext(rangeModelIdKey);
            RSEPublicModelIdRangeValuesAPIResponseDTO rsePublicModelIdRangeValuesAPIResponseDTO =
                    (RSEPublicModelIdRangeValuesAPIResponseDTO) context.getScenarioContext()
                            .getContext(rangeModelIdKey + _DTO);

            riskScoringEngineApiAssertions.verifyRSEModelIdRangeValues(rangeModelIdKey, rangeModelIdResponse,
                                                                       rsePublicModelIdRangeValuesAPIResponseDTO);
        }

    }

    private void rationalizeRSERequestOnIndustryParentChildBusinessTypes(
            RiskScoringEngineAPIRequestDTO riskScoringEngineAPIRequestDTO) {
        if (riskScoringEngineAPIRequestDTO.getBusinessType() != null &&
                !riskScoringEngineAPIRequestDTO.getBusinessType().trim().equals("")) {
            riskScoringEngineAPIRequestDTO.setParentBusinessType(riskScoringEngineAPIRequestDTO.getIndustry());
            riskScoringEngineAPIRequestDTO.setChildBusinessType(riskScoringEngineAPIRequestDTO.getBusinessType());
            riskScoringEngineAPIRequestDTO.setIndustry(null);
            riskScoringEngineAPIRequestDTO.setBusinessType(null);
        }
    }

}
