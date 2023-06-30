package com.refinitiv.asts.test.ui.api.model.metricsActivities;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ColumnsItem {

    private Integer columnOrdinal;
    private String code;
    private Boolean defaultColumn;
    private String name;
    private String filterType;

}