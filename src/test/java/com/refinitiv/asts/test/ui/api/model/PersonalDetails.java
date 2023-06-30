package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class PersonalDetails {

    private String nationality;
    private String placeOfBirth;

}
