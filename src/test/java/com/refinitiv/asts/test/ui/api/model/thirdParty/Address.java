package com.refinitiv.asts.test.ui.api.model.thirdParty;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class Address {

    private String country;
    private Object province;
    private Object city;
    private Object postalCode;
    private Object type;
    private Object addressLine;

}