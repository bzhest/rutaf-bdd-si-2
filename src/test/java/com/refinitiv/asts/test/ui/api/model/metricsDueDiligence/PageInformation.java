package com.refinitiv.asts.test.ui.api.model.metricsDueDiligence;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class PageInformation {

    private Integer totalRecords;
    private Integer limit;
    private Integer totalPages;
    private Integer currentPage;

}