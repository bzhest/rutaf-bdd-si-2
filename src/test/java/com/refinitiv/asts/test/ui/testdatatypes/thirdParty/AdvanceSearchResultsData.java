package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
public class AdvanceSearchResultsData {

    private List<ResultLine> resultsList = new ArrayList<>();

    public AdvanceSearchResultsData(List<List<String>> values) {
        values.forEach(value -> {
            int index = 0;
            resultsList.add(
                    new ResultLine()
                            .setThirdPartyName(value.get(index++))
                            .setIndustryType(value.get(index++))
                            .setCountry(value.get(index++))
                            .setStatus(value.get(index++))
                            .setRiskModel(value.get(index++))
                            .setRiskTier(value.get(index++))
                            .setDateCreated(value.get(index++))
                            .setLastUpdate(value.get(index++))
                            .setScreeningStatus(value.get(index)));
        });
    }

    @Data
    @Accessors(chain = true)
    public static class ResultLine {

        String thirdPartyName;
        String industryType;
        String country;
        String status;
        String riskModel;
        String riskTier;
        String dateCreated;
        String lastUpdate;
        String screeningStatus;

    }

}