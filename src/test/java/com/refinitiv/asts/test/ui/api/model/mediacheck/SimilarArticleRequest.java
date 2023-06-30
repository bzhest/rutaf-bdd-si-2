package com.refinitiv.asts.test.ui.api.model.mediacheck;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class SimilarArticleRequest {

    public String deduplicationHash;

}