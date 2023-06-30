package com.refinitiv.asts.test.ui.api.model.thirdParty;

import java.util.List;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ThirdPartyResponse {

    private Integer total;
    private List<ObjectsItem> objects;

}