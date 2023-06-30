package com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Objects;

import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class WorkflowGroupData {

    @JsonProperty("name")
    private String groupName;
    private String status;
    private String dateCreated;
    private String lastUpdate;
    private String workflowGroupId;

    public WorkflowGroupData(String groupName, String status, String dateCreated, String lastUpdate) {
        this.groupName = groupName;
        this.status = status;
        this.dateCreated = dateCreated;
        this.lastUpdate = lastUpdate;
    }

    @JsonProperty("status")
    private void setStatusFromResponse(String isActive) {
        status = isActive.equals("true") ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    @JsonProperty("createTime")
    private void setCreateTime(Long createTime) {
        dateCreated = Objects.isNull(createTime) ? null : getDateFromEpochMilli(createTime, REACT_FORMAT);
    }

    @JsonProperty("updateTime")
    private void setUpdateTime(Long updateTime) {
        lastUpdate = Objects.isNull(updateTime) ? null : getDateFromEpochMilli(updateTime, REACT_FORMAT);
    }

}
