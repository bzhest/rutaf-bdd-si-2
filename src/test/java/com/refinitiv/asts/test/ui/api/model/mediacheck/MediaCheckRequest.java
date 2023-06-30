package com.refinitiv.asts.test.ui.api.model.mediacheck;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class MediaCheckRequest {

    private BaseFilter baseFilter;
    private Pagination pagination;

    @Data
    @Accessors(chain = true)
    public static class BaseFilter {

        public boolean reviewRequiredArticles;
        public boolean smartFilter;
        public String query;
        public PublicationDate publicationDate;

    }

    @Data
    @Accessors(chain = true)
    public static class Pagination {

        public int itemsPerPage;
        public String sort;
        public String pageReference;

    }

    @Data
    @Accessors(chain = true)
    public static class PublicationDate {

        public String min;
        public String max;

    }

}
