package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class MyOrganisation {

    String name;
    String region;
    String country;
    String dateCreated;
    String lastUpdate;
    String status;
    String localName;
    String phoneNumber;
    String fax;
    String description;
    String addressLine;
    String city;
    String zip;
    String state;

}
