package com.refinitiv.asts.test.api.dto.references;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class SortParamDTO {

    private String sortField;
    private String sort;

}
