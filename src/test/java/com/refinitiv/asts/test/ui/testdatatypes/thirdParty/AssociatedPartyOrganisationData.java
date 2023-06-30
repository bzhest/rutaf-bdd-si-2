package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AssociatedPartyOrganisationData implements AssociatedPartyAddressInterface, AssociatedPartyContactInterface {

    //    General Information
    private String name;
    private Boolean autoScreen;
    private String relationship;

    //    Address
    private String addressLine;
    private String city;
    private String zipCode;
    private String stateProvince;
    private String region;
    private String addressCountry;

    //    Contact
    private String phoneNumber;
    private String fax;
    private String website;
    private String emailAddress;

    //    Description
    private String description;

    private String status;
    private String thirdParty;

}
