package com.refinitiv.asts.test.ui.utils.wc1.model;

import lombok.Data;

@Data
public class Address {

    String city;
    Country country;
    String postCode;
    String region;
    String street;

}