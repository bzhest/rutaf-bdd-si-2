package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@NoArgsConstructor
public class GroupData {

    private String groupName;
    private String description;
    private String status;
    private String dateCreated;
    private String lastUpdate;
    private List<String> email;
    private List<String> username;

    public GroupData(String groupName, String description, String status, String dateCreated, String lastUpdate) {
        this.groupName = groupName;
        this.description = description;
        this.status = status;
        this.dateCreated = dateCreated;
        this.lastUpdate = lastUpdate;
    }

}
