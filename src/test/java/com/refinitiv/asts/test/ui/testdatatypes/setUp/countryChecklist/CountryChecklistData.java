package com.refinitiv.asts.test.ui.testdatatypes.setUp.countryChecklist;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class CountryChecklistData {

    private String listName;
    private String alertType;
    private String alertMessage;
    private String countryChecklistId;
    private String status;
    private Object[] countryList;
    private String dateCreated;
    private String lastUpdate;

}
