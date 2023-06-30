package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ProcessRuleResponse {

    private Integer total;
    private List<ObjectsItem> objects;

}