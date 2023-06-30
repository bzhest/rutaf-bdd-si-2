package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.refinitiv.asts.test.ui.api.AssociatedPartyAddress;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ContactInformationRequest {

    private String clientId;
    private String objectType;
    private String objectId;
    private String title;
    @JsonProperty(required = true)
    private String firstName;
    private String middleName;
    @JsonProperty(required = true)
    private String lastName;
    private String description;
    private boolean isActive;
    private boolean isPrincipal;
    private List<AssociatedPartyAddress> address;
    private Contact contact;
    private PersonalDetails personalDetails;

}
