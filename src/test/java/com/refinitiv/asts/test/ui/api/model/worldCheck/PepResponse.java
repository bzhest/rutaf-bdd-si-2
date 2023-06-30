package com.refinitiv.asts.test.ui.api.model.worldCheck;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class PepResponse {

    private PepResponse.Payload payload;

    @Data
    public static class Payload {

        public String pepStatus;

    }

}
