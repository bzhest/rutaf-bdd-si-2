package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class WorkflowActivityTableData {

    public String name;
    public String status;
    public String finalAssessment;
    public String overallRiskScore;
    public String initiatedBy;
    public String startDate;
    public String lastUpdate;

}
