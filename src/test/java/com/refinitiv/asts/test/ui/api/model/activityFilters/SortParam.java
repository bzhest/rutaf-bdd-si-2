package com.refinitiv.asts.test.ui.api.model.activityFilters;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class SortParam {

    private String sortField;
    private String sort;

}