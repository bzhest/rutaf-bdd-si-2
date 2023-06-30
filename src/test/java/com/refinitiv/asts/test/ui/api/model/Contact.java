package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class Contact {

    private List<String> phoneNumber;
    private List<String> fax;
    List<String> website;
    @JsonProperty(required = true)
    private List<String> email;

}
