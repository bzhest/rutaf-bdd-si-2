package com.refinitiv.asts.test.ui.api.model.activityFilters;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ActivityMetricsFiltersRequest {

    private SortParam sortParam;
    private Pagination pagination;
    private Filters filters;
    private String type;

}