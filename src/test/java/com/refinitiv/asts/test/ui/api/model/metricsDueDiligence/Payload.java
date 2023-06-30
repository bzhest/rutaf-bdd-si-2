package com.refinitiv.asts.test.ui.api.model.metricsDueDiligence;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class Payload {

    private List<DueDiligenceItem> records;
    private List<ColumnsItem> columns;
    private PageInformation pageInformation;

}