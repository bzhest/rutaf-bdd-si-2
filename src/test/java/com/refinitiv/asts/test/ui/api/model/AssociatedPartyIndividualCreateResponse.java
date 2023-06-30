package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.refinitiv.asts.test.ui.api.AssociatedPartyAddress;
import lombok.Data;

import java.util.List;

@Data
public class AssociatedPartyIndividualCreateResponse {

    private ContactData data;
    private String message;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class ContactData {

        private String parent;
        private String lastName;
        private List<AssociatedPartyAddress> addresses;
        private String description;
        private String updateTime;
        private String title;
        private boolean isActive;
        private String firstName;
        private Object otherNames;
        private Contact contactInformation;
        private String createTime;
        private Object personalDetails;
        private String middleName;
        private boolean autoScreen;
        private String id;
        private Object screeningStatus;
        private boolean isPrincipal;

    }

}
