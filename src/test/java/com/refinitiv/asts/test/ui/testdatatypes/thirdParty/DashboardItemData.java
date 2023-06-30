package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@Accessors(chain = true)
@Builder
public class DashboardItemData {

    public String thirdPartyName;
    public String activityName;
    public String questionnaireName;
    public String description;
    public String questionnaireDescription;
    public String dueDate;
    public String questionnaireDueDate;
    public String renewalDate;
    public String priority;
    public String assignedTo;
    public String reviewerName;
    public String responsibleParty;
    public String renewalAssignee;
    public String status;
    public String questionnaireStatus;
    public String type;
    public String recordName;
    public String reviewer;

}
