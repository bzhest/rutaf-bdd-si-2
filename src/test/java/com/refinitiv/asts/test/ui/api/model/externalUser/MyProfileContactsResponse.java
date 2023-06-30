package com.refinitiv.asts.test.ui.api.model.externalUser;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class MyProfileContactsResponse {

    private MyProfilePayload payload;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class MyProfilePayload {

        private List<MyProfileResponseObject> objects;

    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class MyProfileResponseObject {

        private String _id;

    }

}