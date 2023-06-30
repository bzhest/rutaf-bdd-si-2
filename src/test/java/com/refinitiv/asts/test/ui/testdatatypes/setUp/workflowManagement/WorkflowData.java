package com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.text.DecimalFormat;

@Data
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class WorkflowData {

    private String workflowName;
    private String workflowType;
    private String description;
    private String riskScoringRange;
    private String from;
    private String to;
    private String workflowGroup;
    private String dateCreated;
    private String lastUpdate;
    private String status;

    public WorkflowData(String workflowName, String workflowType, String dateCreated,
            String lastUpdate, String status) {
        this.workflowName = workflowName;
        this.workflowType = workflowType;
        this.dateCreated = dateCreated;
        this.lastUpdate = lastUpdate;
        this.status = status;
    }

    @JsonProperty("min")
    private void setMin(Double min) {
        from = new DecimalFormat("0.########").format(min);
    }

    @JsonProperty("max")
    private void setMax(Double max) {
        to = new DecimalFormat("0.#########").format(max);
    }

    @JsonProperty("name")
    private void setRiskScoring(String riskScoringName) {
        riskScoringRange = riskScoringName;
    }

}
