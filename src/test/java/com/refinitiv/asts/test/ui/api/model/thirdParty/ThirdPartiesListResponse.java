package com.refinitiv.asts.test.ui.api.model.thirdParty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ThirdPartiesListResponse {

    private List<ObjectsItem> data;
    private Meta meta;

}
