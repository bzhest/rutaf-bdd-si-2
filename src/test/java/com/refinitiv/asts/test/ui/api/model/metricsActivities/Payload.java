package com.refinitiv.asts.test.ui.api.model.metricsActivities;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class Payload {

    private List<ActivityItem> records;
    private List<ColumnsItem> columns;
    private PageInformation pageInformation;

}