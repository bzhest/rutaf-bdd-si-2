package com.refinitiv.asts.test.api.dto.references.response;

import com.refinitiv.asts.test.api.dto.references.request.ReferencesRequestDTO;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MetaResponseDTO {

    private Integer totalRecords;
    private Integer totalPages;
    private Integer pageSize;
    private Integer currentPage;
    private ReferencesRequestDTO queryRequest;

}
