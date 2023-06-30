package com.refinitiv.asts.test.ui.api.model.valueManagement;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class RefDataRequest {

    private List<Value> listValues;
    private String category;
    private Long dateCreated;
    private Long dateUpdated;
    private Object isDeleted;
    private String name;
    private Object sortable;
    private String valueType;
    private String _id;

}
