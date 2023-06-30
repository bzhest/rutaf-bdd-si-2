package com.refinitiv.asts.test.ui.api.model.mediacheck;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class MediaCheckResponse {

    private List<Article> results;
    public String totalResultCount;
    private PageReferences pageReferences;

    @Data
    public static class Article {

        private ArticleSummary articleSummary;

    }

    @Data
    public static class ArticleSummary {

        public String articleId;
        public String duplicatesKey;
        public String title;
        public List<String> phases;
        public List<String> topics;
        public Publication publication;
        public String snippet;
        public String publicationDate;

    }

    @Data
    public static class Publication {

        public String name;

    }

    @Data
    public static class PageReferences {

        public String current;
        public String first;
        public String last;
        public String next;
        public String previous;

    }

}
