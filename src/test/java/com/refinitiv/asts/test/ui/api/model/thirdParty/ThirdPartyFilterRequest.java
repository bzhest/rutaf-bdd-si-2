package com.refinitiv.asts.test.ui.api.model.thirdParty;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ThirdPartyFilterRequest {

    private List<CriteriaItem> criteria;
    private String defaultOperator;

    @Data
    @Accessors(chain = true)
    public static class CriteriaItem {

        private boolean isCustomField;
        private String field;
        private String func;
        private String pvalue;

    }

}
