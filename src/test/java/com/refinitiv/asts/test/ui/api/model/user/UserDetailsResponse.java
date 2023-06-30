package com.refinitiv.asts.test.ui.api.model.user;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserDetailsResponse {

    private List<UserData> records;

}
