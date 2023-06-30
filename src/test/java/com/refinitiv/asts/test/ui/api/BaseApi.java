package com.refinitiv.asts.test.ui.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import io.restassured.path.json.exception.JsonPathException;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import lombok.NoArgsConstructor;
import org.apache.http.HttpStatus;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;

import static com.refinitiv.asts.test.ui.utils.AwaitUtil.await;

@NoArgsConstructor
public class BaseApi {

    public static final String URL = Config.get().value("api.url");
    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    public static final int ALL_ITEMS = 100000;
    private static final int TIME_OUT = 120;
    private static final int PULL_INTERVAL = 5;
    public static final int USERS_ITEMS_PER_PAGE = 10000;
    public static final int ZERO = 0;
    public static final int TEN = 10;
    public static final int FIFTY = 50;
    private static ScenarioCtxtWrapper context;
    protected static final String DELIMITER = "/";
    public static final String OBJECTS_FILTER = "objects";
    public static final String TOTAL = "total";
    public static final String CREATE_TIME = "createTime";
    public static final String ID_FILTER = "data.id";

    public BaseApi(ScenarioCtxtWrapper context) {
        BaseApi.context = context;
    }

    public static RequestSpecification given() {
        return new ApiClient(context).getClient(URL);
    }

    protected static boolean isStatusCodeExpected(Response currentResponse, int statusCode) {
        return currentResponse.getStatusCode() == statusCode;
    }

    protected static Response postUntilNonNull(String condition, String endpoint, String filter,
            RequestSpecification specification) {
        return await(condition, TIME_OUT, PULL_INTERVAL).until(() -> specification.post(endpoint),
                                                               currentResponse -> isStatusCodeExpected(currentResponse,
                                                                                                       HttpStatus.SC_OK) &&
                                                                       currentResponse.getBody().jsonPath()
                                                                               .get(filter) != null);
    }

    protected static Response postUntilMoreEqualsThan(String condition, String endpoint,
            RequestSpecification specification, String filter, int expectedSize) {
        return await(condition, TIME_OUT, PULL_INTERVAL).until(() -> specification.post(endpoint),
                                                               currentResponse -> isStatusCodeExpected(currentResponse,
                                                                                                       HttpStatus.SC_OK) &&
                                                                       (int) currentResponse.getBody().jsonPath()
                                                                               .get(filter) >= expectedSize);
    }

    protected static Response postUntilExpectedStatusCode(String endpoint, RequestSpecification specification) {
        return await("Expected status code", TIME_OUT, PULL_INTERVAL).ignoreException(JsonPathException.class)
                .ignoreException(ClassCastException.class)
                .until(() -> specification.post(endpoint),
                       currentResponse -> isStatusCodeExpected(currentResponse,
                                                               HttpStatus.SC_OK));
    }

    protected static Response getUntilNonNull(String condition, String endpoint, String filter,
            RequestSpecification specification) {
        return
                await(condition, TIME_OUT, PULL_INTERVAL).until(() -> specification.get(endpoint),
                                                                currentResponse -> isStatusCodeExpected(currentResponse,
                                                                                                        HttpStatus.SC_OK) &&
                                                                        currentResponse.getBody().jsonPath()
                                                                                .get(filter) != null);
    }

    protected static Response getUntilMoreThen(String condition, String endpoint, String filter,
            RequestSpecification specification) {
        return await(condition, TIME_OUT, PULL_INTERVAL).ignoreException(JsonPathException.class)
                .ignoreException(ClassCastException.class)
                .until(() -> specification.get(endpoint),
                       currentResponse -> isStatusCodeExpected(currentResponse,
                                                               HttpStatus.SC_OK) &&
                               (int) currentResponse.getBody().jsonPath()
                                       .get(filter) >= 1);
    }

    protected static Response getUntilExpectedStatusCode(String endpoint, RequestSpecification specification) {
        return await("Expected status code", TIME_OUT, PULL_INTERVAL).ignoreException(JsonPathException.class)
                .ignoreException(ClassCastException.class)
                .until(() -> specification.get(endpoint),
                       currentResponse -> isStatusCodeExpected(currentResponse,
                                                               HttpStatus.SC_OK));
    }

}
