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
public class AssociatedPartyIndividualData implements AssociatedPartyAddressInterface, AssociatedPartyContactInterface {

    //    General Information
    private String title;
    private String firstName;
    private String lastName;
    private String middleName;
    private String fullName;
    private Boolean autoScreen;
    private Boolean isPrincipal;

    //    Address
    private String addressLine;
    private String city;
    private String zipCode;
    private String stateProvince;
    private String region;
    private String addressCountry;

    //    Personal Details
    private String nationality;
    public String placeOfBirth;

    //    Contact
    private String phoneNumber;
    private String fax;
    private String website;
    private String emailAddress;
    private Boolean isEnabledAsUser;

    //    Description
    private String description;

    private Boolean keyPrinciple;
    private String status;
    private String thirdParty;
    private String screeningCriteriaCountry;

}
