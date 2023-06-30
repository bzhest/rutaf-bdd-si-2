package com.refinitiv.asts.test.ui.api;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class AssociatedPartyAddress {

    private String addressLine;
    private String city;
    private String country;
    private String postalCode;
    private String province;
    private String region;

}

