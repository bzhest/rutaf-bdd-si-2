package com.refinitiv.asts.test.ui.utils.wc1;

import com.google.common.collect.ImmutableMap;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.util.Map;

public class RestClient {

    private final String baseUriProperty;
    private final String basePath;
    private final ImmutableMap<String, String> requestHeaders;

    public RestClient(ImmutableMap<String, String> headers, String baseUriProperty, String basePath) {
        this.baseUriProperty = baseUriProperty;
        this.basePath = basePath;
        this.requestHeaders = headers;
    }

    public Response sendPUT(String endpoint, String requestBody) {
        return spec()
                .body(requestBody)
                .when()
                .put(endpoint);
    }

    public Response sendPOST(String endpoint, String requestBody) {
        return spec()
                .body(requestBody)
                .when()
                .post(endpoint);
    }

    public Response sendGET(String endpoint) {
        return spec()
                .when()
                .get(endpoint);
    }

    public Response sendGET(String endpoint, Map<String, String> params) {
        return spec()
                .params(params)
                .when()
                .get(endpoint);
    }

    public Response sendDELETE(String endpoint) {
        return spec()
                .when()
                .delete(endpoint);
    }

    private RequestSpecification spec() {
        return RestAssured.given()
                .baseUri(baseUriProperty)
                .basePath(basePath)
                .headers(requestHeaders);
    }

}
