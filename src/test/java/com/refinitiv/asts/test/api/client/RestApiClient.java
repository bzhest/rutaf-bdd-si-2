package com.refinitiv.asts.test.api.client;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.HttpClientConfig;
import io.restassured.config.RestAssuredConfig;
import io.restassured.filter.log.ErrorLoggingFilter;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.config.EncoderConfig.encoderConfig;
import static io.restassured.config.RedirectConfig.redirectConfig;

public class RestApiClient {

    public RestApiClient() {
        RestAssured.requestSpecification = new RequestSpecBuilder()
                .setContentType(ContentType.JSON)
                .setAccept(ContentType.JSON)
                .setRelaxedHTTPSValidation()
                .addFilters(List.of(new RequestLoggingFilter(LogDetail.URI),
                                    new RequestLoggingFilter(LogDetail.METHOD),
                                    new ResponseLoggingFilter(LogDetail.STATUS),
                                    new ErrorLoggingFilter()))
                .build();
        RestAssured.config = new RestAssuredConfig()
                .encoderConfig(encoderConfig().defaultContentCharset(StandardCharsets.UTF_8))
                .redirect(redirectConfig().followRedirects(false));
    }

    public Response sendPut(RequestSpecification requestSpec, String endpoint, String requestBody) {
        return given().spec(requestSpec)
                .body(requestBody)
                .when()
                .put(endpoint);
    }

    public Response sendPost(RequestSpecification requestSpec, String endpoint, Object requestBody) {
        return given().spec(requestSpec)
                .body(requestBody)
                .when()
                .post(endpoint);
    }

    public Response sendPost(RequestSpecification requestSpec, String endpoint, Object requestBody, Integer timeout) {
        RestAssured.config = RestAssuredConfig.config()
                .httpClient(HttpClientConfig.httpClientConfig()
                                    .setParam("http.socket.timeout", timeout.intValue())
                                    .setParam("http.connection.timeout", timeout.intValue()));

        return given().spec(requestSpec)
                .body(requestBody)
                .when()
                .post(endpoint);
    }

    public Response sendGet(RequestSpecification requestSpec, String endpoint) {
        return given().spec(requestSpec)
                .when()
                .get(endpoint);
    }

    public Response sendGet(RequestSpecification requestSpec, String endpoint, Map<String, String> params) {
        return given().spec(requestSpec)
                .params(params)
                .when()
                .get(endpoint);
    }

    public Response sendPatch(RequestSpecification requestSpec, String endpoint, Map<String, String> params) {
        return given().spec(requestSpec)
                .params(params)
                .when()
                .patch(endpoint);
    }

    public Response sendDelete(RequestSpecification requestSpec, String endpoint) {
        return given().spec(requestSpec)
                .when()
                .delete(endpoint);
    }

}
