package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.refinitiv.asts.test.ui.api.AssociatedPartyAddress;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class AssociatedPartyIndividualCreateRequest {

    @JsonProperty(required = true)
    private String parent;
    @JsonProperty(required = true)
    private String firstName;
    private String middleName;
    private String title;
    @JsonProperty(required = true)
    private String lastName;
    private List<AssociatedPartyAddress> addresses;
    private Contact contactInformation;
    private String description;
    private boolean autoScreen;
    private boolean isActive;
    private boolean isPrincipal;

}