package com.refinitiv.asts.test.ui.api.model.valueManagement;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class RefDataResponse {

    private String category;
    private long dateCreated;
    private long dateUpdated;
    private String isDeleted;
    private String name;
    private String sortable;
    private String valueType;
    private String _id;
    private Value[] listValues;

}