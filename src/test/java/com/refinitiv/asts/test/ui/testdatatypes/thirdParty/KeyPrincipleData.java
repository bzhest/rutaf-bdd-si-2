package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@Accessors(chain = true)
@Builder
public class KeyPrincipleData {

    private String title;
    private String firstName;
    private String lastName;
    private String email;
    private String localLanguageName;
    private String addressLine;
    private String zip;
    private String city;
    private String state;
    private String country;
    private String fullName;
    private Boolean isChecked;

}
