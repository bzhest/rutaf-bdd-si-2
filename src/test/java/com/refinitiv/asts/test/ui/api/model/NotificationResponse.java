package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class NotificationResponse {

    private Integer total;
    private List<Notification> objects;

    @Data
    @Accessors(chain = true)
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Notification {

        Long create_time;
        String header;

    }

}