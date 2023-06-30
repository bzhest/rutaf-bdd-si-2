package com.refinitiv.asts.test.ui.utils.email.mailHog;

import com.google.gson.Gson;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.ObjectMapperConfig;
import io.restassured.config.RestAssuredConfig;
import io.restassured.mapper.ObjectMapperType;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.nio.charset.StandardCharsets;
import java.util.Map;

import static io.restassured.config.EncoderConfig.encoderConfig;
import static io.restassured.config.RedirectConfig.redirectConfig;

public class MailHogApiClient {

    private final String baseUrl;
    private final String username;
    private final String password;

    public MailHogApiClient(String baseUrl, String username, String password) {
        this.baseUrl = baseUrl;
        this.username = username;
        this.password = password;
    }

    private RequestSpecification given() {
        RestAssured.config = new RestAssuredConfig()
                .encoderConfig(encoderConfig().defaultContentCharset(StandardCharsets.UTF_8))
                .redirect(redirectConfig().followRedirects(false))
                .objectMapperConfig(new ObjectMapperConfig(ObjectMapperType.GSON)
                                            .gsonObjectMapperFactory((cl, ch) -> new Gson()));

        return RestAssured.given(new RequestSpecBuilder()
                                         .setBaseUri(baseUrl)
                                         .build())
                .auth()
                .basic(username, password);
    }

    public Response get(String path) {
        return given().get(path);
    }

    public Response get(String path, Map<String, String> params) {
        return given().params(params).get(path);
    }

    public Response delete(String path) {
        return given().delete(path);
    }

}
