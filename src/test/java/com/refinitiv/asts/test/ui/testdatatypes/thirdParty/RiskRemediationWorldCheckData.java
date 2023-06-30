package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class RiskRemediationWorldCheckData {

    private String source;
    private String searchTerm;
    private String tagAsRedFlagRecord;
    private String referenceId;
    private String redFlagDate;

}
