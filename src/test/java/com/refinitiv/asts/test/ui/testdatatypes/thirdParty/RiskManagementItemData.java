package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class RiskManagementItemData {

    private String name;
    private String status;
    private String overallRiskScore;
    private String initiatedBy;
    private String startDate;
    private String lastUpdate;

}
