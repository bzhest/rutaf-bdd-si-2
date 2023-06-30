package com.refinitiv.asts.test.ui.utils.wc1;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.utils.wc1.model.CaseResponseDTO;
import org.apache.commons.lang3.StringUtils;

import java.util.Objects;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_ID;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.SUPPLIER;
import static com.refinitiv.asts.test.ui.utils.wc1.ScreeningResultExpectedDataBuilder.getSearchId;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCaseResponse;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCountriesReferenceResponse;

public class CaseDataBuilder {

    public static String getCaseSecondaryFieldValue(ScenarioCtxtWrapper context, String resultsFor,
            String secondaryFieldTypeId) {
        String systemCaseId = getSearchId(context, resultsFor);
        CaseResponseDTO caseResponse = getCaseResponse(systemCaseId);
        CaseResponseDTO.Field matchedField = caseResponse.getSecondaryFields()
                .stream()
                .filter(field -> field.getTypeId().equals(secondaryFieldTypeId))
                .findFirst()
                .orElse(null);
        return Objects.nonNull(matchedField) ? getCountriesReferenceResponse().get(matchedField.getValue()) :
                StringUtils.EMPTY;
    }

    public static String getOtherNameCaseSecondaryFieldValue(ScenarioCtxtWrapper context, String otherName,
            String resultsFor, String secondaryFieldTypeId) {
        String supplierId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String contactId = AppApi.getContactIdsList(supplierId).get(0);
        String systemCaseId = resultsFor.contains(SUPPLIER) ? ConnectApi.getOtherNameSearchId(supplierId, otherName) :
                AppApi.getContactOtherNameSearchId(contactId, otherName);

        CaseResponseDTO caseResponse = getCaseResponse(systemCaseId);
        CaseResponseDTO.Field matchedField = caseResponse.getSecondaryFields()
                .stream()
                .filter(field -> field.getTypeId().equals(secondaryFieldTypeId))
                .findFirst()
                .orElse(null);
        return Objects.nonNull(matchedField) ? getCountriesReferenceResponse().get(matchedField.getValue()) :
                StringUtils.EMPTY;
    }

    public static String getCaseName(ScenarioCtxtWrapper context, String resultsFor) {
        String systemCaseId = getSearchId(context, resultsFor);
        CaseResponseDTO caseResponse = getCaseResponse(systemCaseId);
        return caseResponse.getName();
    }

}
