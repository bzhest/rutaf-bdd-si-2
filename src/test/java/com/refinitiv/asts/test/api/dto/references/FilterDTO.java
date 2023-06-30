package com.refinitiv.asts.test.api.dto.references;

import lombok.Data;

import java.util.List;

@Data
public class FilterDTO {

    private List<String> values;
    private String filterType;

}
