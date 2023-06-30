package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.refinitiv.asts.test.ui.api.AssociatedPartyAddress;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class AssociatedPartyOranisationCreateRequest {

    @JsonProperty(required = true)
    private String parent;
    @JsonProperty(required = true)
    private String name;
    @JsonAlias({"addresses", "address"})
    private AssociatedPartyAddress address;
    private Contact contactInformation;
    private String description;
    private String relationshipInfo;
    private String worldCheckGroup;
    private boolean autoScreen;
    private boolean isActive;
    private RelationshipInfo relationShipInfo;

    @Data
    @Accessors(chain = true)
    public static class RelationshipInfo {

        private String relationshipId;
        private String relationship;

    }

}
