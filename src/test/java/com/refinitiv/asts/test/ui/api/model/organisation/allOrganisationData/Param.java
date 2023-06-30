package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class Param {

    private Integer totalRecords;
    private Object search;
    private String sortType;
    private Integer totalPages;
    private Integer limit;
    private String sortBy;
    private Object filters;
    private Object currentPage;

}