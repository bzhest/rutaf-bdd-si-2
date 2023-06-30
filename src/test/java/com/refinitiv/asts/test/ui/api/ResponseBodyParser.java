package com.refinitiv.asts.test.ui.api;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonSyntaxException;
import io.restassured.path.json.exception.JsonPathException;
import io.restassured.response.Response;
import lombok.SneakyThrows;

import java.util.List;

import static java.lang.String.format;

public class ResponseBodyParser {

    protected static ObjectMapper objectMapper = new ObjectMapper();

    public static <T> T parseResponseBody(Response response, Class<T> responseClass) {
        try {
            return response.as(responseClass);
        } catch (JsonSyntaxException | IllegalStateException e) {
            throw new RuntimeException(
                    format("Unexpected API response body: %s \n %s", e.getMessage(), response.getBody().asString()));
        }
    }

    public static Object getResponseJsonPath(Response response, String jsonPath) {
        try {
            return response.getBody().jsonPath().get(jsonPath);
        } catch (JsonPathException e) {
            throw new RuntimeException("Unexpected API response body: " + response.getBody().asString());
        }
    }

    public static <T> T getResponseJsonPathAsObject(Response response, String jsonPath, Class<T> responseClass) {
        try {
            return response.getBody().jsonPath().getObject(jsonPath, responseClass);
        } catch (JsonPathException e) {
            throw new RuntimeException("Unexpected API response body: " + response.getBody().asString());
        }
    }

    public static <T> List<T> getResponseJsonPathAsList(Response response, String jsonPath, Class<T> responseClass) {
        try {
            return response.getBody().jsonPath().getList(jsonPath, responseClass);
        } catch (JsonPathException e) {
            throw new RuntimeException("Unexpected API response body: " + response.getBody().asString());
        }
    }

    @SneakyThrows
    public static <T> T getResponseAsObject(Object responseList, TypeReference<T> typeReference) {
        try {
            return objectMapper.readValue(objectMapper.writeValueAsString(responseList), typeReference);
        } catch (JsonSyntaxException | JsonProcessingException e) {
            throw new RuntimeException(e + "\nUnexpected API response body: " + responseList);
        }
    }

    @SneakyThrows
    public static <T> T getResponseAsObject(Response response, Class<T> responseClass) {
        try {
            return objectMapper.readValue(response.getBody().asString(), responseClass);
        } catch (JsonSyntaxException | JsonProcessingException e) {
            throw new RuntimeException("Unexpected API response body: " + response.getBody().asString());
        }
    }

}
