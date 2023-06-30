package com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class OrganizationPayload {

    private String clientId;
    private Param param;
    private List<ObjectsItem> objects;
    private Object parentType;
    private Object parentId;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    @Accessors(chain = true)
    public static class ObjectsItem {

        private Country country;
        private String clientId;
        private Long dateCreated;
        private Boolean isDeleted;
        private MapRefObject mapRefObject;
        private Organization organization;
        private String name;
        private Boolean active;
        private String id;
        private Region region;
        private Long dateUpdated;

    }

}