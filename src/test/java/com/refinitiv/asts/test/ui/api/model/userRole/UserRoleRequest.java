package com.refinitiv.asts.test.ui.api.model.userRole;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UserRoleRequest {

    private String name;
    private Sort sort;
    private Boolean active;

    @Data
    @Accessors(chain = true)
    public static class Sort {

        private String sortType;
        private String sortBy;

    }

}
