package com.refinitiv.asts.test.ui.api.model.valueManagement;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class RefDataListRetrieveRequest {

    private String sortBy;
    private String sortType;
    private String _id;

}

