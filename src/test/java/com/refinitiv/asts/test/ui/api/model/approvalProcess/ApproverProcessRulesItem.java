package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ApproverProcessRulesItem {

    private List<Object> coverage;
    private String method;
    private Object rule;
    private List<Object> approvers;

}