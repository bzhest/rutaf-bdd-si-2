package com.refinitiv.asts.test.api.dto.references.response;

import com.refinitiv.asts.test.api.dto.references.response.MetaResponseDTO;
import lombok.Data;

import java.util.List;

@Data
public class ReferenceResponseDTO<T> {

    private String message;
    private List<T> data;
    private MetaResponseDTO meta;

}
