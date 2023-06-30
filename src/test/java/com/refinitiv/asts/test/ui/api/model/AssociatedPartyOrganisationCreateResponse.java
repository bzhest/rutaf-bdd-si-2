package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.refinitiv.asts.test.ui.api.AssociatedPartyAddress;
import lombok.Data;

import java.util.List;

@Data
public class AssociatedPartyOrganisationCreateResponse {

    private AssociatedPartyOrganizationData data;
    private String message;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class AssociatedPartyOrganizationData {

        private String parent;
        private List<AssociatedPartyAddress> addresses;
        private String description;
        private String updateTime;
        private Object otherNames;
        private Contact contactInformation;
        private String createTime;
        private String name;
        private String relationshipInfo;
        private boolean autoScreen;
        private boolean miniProfile;
        private String id;

    }

}
