package com.refinitiv.asts.test.api.client;

import com.refinitiv.asts.test.config.Config;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;

import java.util.Map;

public class ApiSpecificationBuilder {

    public static final String TENANT = Config.get().value("tenant");
    private static final String INVALID_TENANT = "invalid";
    private static final String REQUESTOR_EMAIL = "RequestorEmail";
    private static final String X_TENANT_CODE = "X-Tenant-Code";

    public RequestSpecification getBaseSpec(String baseUrl) {
        return new RequestSpecBuilder()
                .setBaseUri(baseUrl)
                .build();
    }

    public RequestSpecification getSpecWithTenant(String baseUrl) {
        return new RequestSpecBuilder()
                .addHeader(X_TENANT_CODE, TENANT)
                .setBaseUri(baseUrl)
                .build();
    }

    public RequestSpecification getSpecWithTenantAndRequestorEmail(String baseUrl, String requestorEmail) {
        return new RequestSpecBuilder()
                .addHeader(X_TENANT_CODE, TENANT)
                .addHeader(REQUESTOR_EMAIL, requestorEmail)
                .setBaseUri(baseUrl)
                .build();
    }

    public RequestSpecification getSpecWithInvalidTenant(String baseUrl, String tenant) {
        return new RequestSpecBuilder()
                .addHeader(X_TENANT_CODE, INVALID_TENANT)
                .setBaseUri(baseUrl)
                .build();
    }

    public RequestSpecification getSpec(String baseUrl, Map<String, String> headersMap) {
        return new RequestSpecBuilder()
                .addHeaders(headersMap)
                .setBaseUri(baseUrl)
                .build();
    }

}
