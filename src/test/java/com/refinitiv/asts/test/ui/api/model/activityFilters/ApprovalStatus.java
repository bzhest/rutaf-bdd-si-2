package com.refinitiv.asts.test.ui.api.model.activityFilters;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ApprovalStatus {

    private String filterType;
    private List<String> values;

}
