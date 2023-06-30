package com.refinitiv.asts.test.ui.api.model.thirdParty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class Meta {

    private Integer currentPage;
    private Integer pageSize;
    private Integer totalPages;
    private Integer totalRecords;

}
