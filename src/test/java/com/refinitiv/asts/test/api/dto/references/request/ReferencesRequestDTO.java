package com.refinitiv.asts.test.api.dto.references.request;

import com.refinitiv.asts.test.api.dto.references.FilterDTO;
import com.refinitiv.asts.test.api.dto.references.PaginationDTO;
import com.refinitiv.asts.test.api.dto.references.SortParamDTO;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.HashMap;
import java.util.Map;

@Data
@Accessors(chain = true)
public class ReferencesRequestDTO {

    private SortParamDTO sortParam;
    private PaginationDTO pagination;
    private Map<String, FilterDTO> filters = new HashMap<>();

}
