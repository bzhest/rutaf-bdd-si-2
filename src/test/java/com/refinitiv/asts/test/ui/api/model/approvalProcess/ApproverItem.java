package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ApproverItem {

    private Object userGroupId;
    private Object processed;
    private Boolean emailed;
    private Boolean notified;
    private String name;
    private Object updateTime;
    private Object type;
    private String email;
    private String status;

}