package com.refinitiv.asts.test.ui.api.model.mediacheck;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MediaCheckUpdateRequest {

    private CheckType checkType;
    private String country;
    private String name;
    private Object worldCheckGroup;

    @Data
    @Accessors(chain = true)
    public static class CheckType {

        private Boolean worldCheck;
        private Boolean mediaCheck;
        private Boolean watchList;

    }

}