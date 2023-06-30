package com.refinitiv.asts.test.ui.api.model.mediacheck;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class SimilarArticleResponse {

    private List<SimilarArticle> duplicates;

    @Data
    public static class SimilarArticle {

        private String title;
        private Publication publication;
        private String publicationDate;

    }

    @Data
    public static class Publication {

        private String name;

    }

}
