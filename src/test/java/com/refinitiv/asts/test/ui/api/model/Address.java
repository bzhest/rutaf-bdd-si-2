package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class Address {

    private String country;
    private String addressLine;
    private String city;
    private String postalCode;
    private String province;
    private CountryObject countryObj;

    @Data
    @Accessors(chain = true)
    public static class CountryObject {

        private Reference object;

    }

}
