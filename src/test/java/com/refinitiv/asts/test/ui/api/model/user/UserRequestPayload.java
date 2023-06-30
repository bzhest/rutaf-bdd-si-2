package com.refinitiv.asts.test.ui.api.model.user;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;
@Data
@Accessors(chain = true)
public class UserRequestPayload {

    private List<String> fields;
    private Filter filter;
    private Integer limit;
    private Integer currentPage;
    private String sortBy;
    private String sortOrder;
    private String textSearch;

    @Data
    @Accessors(chain = true)
    public static class Filter {

        private boolean isActive;
        private String  userType_name;

    }

}
