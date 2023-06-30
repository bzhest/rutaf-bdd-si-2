package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.refinitiv.asts.test.ui.api.model.fieldsManagement.customFields.customFieldsResponse.OptionsItem;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class CustomFieldData {

    private String name;
    private String type;
    private String description;
    private String status;
    private String dateCreated;
    private String lastUpdate;
    private List<OptionsItem> options;
    private Boolean usePredefinedValues;
    private Boolean required;

    public CustomFieldData(String name, String type, String description, String status, String dateCreated,
            String lastUpdate) {
        this.name = name;
        this.type = type;
        this.description = description;
        this.status = status;
        this.dateCreated = dateCreated;
        this.lastUpdate = lastUpdate;
    }

}
