package com.refinitiv.asts.test.api.dto.references.response;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class UserResponseDTO {

    private String firstName;
    private String lastName;
    private List<DivisionsItem> divisions;
    private String username;

    @Data
    @Accessors(chain = true)
    public static class DivisionsItem {

        private String name;

    }

}