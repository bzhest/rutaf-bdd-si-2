package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ObjectsItem {

    private String createBy;
    private Object reviewProcessRules;
    private Long createTime;
    private String name;
    private List<ApproverProcessRulesItem> approverProcessRules;
    private String description;
    private List<ApproverItem> approvers;
    private Object updateTime;
    private String id;
    private String type;
    private Object reviewers;
    private String status;

}