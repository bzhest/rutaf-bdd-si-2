package com.refinitiv.asts.test.ui.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.NotificationResponse;

import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.parseResponseBody;
import static com.refinitiv.asts.test.ui.constants.APIConstants.*;
import static org.apache.hc.core5.http.HttpStatus.SC_OK;

public class NotificationsApi extends BaseApi {

    public NotificationsApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    public static NotificationResponse getNotifications(String recipient, String sortBy, String sortOrder,
            String type) {
        return parseResponseBody(given().param(RECIPIENT, recipient)
                                         .param(SORT_BY, sortBy)
                                         .param(SORT_ORDER, sortOrder)
                                         .param(TYPE, type)
                                         .expect().statusCode(SC_OK)
                                         .when()
                                         .get(Endpoints.GET_NOTIFICATIONS), NotificationResponse.class);
    }

}
