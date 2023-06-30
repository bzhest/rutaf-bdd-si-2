package com.refinitiv.asts.test.api.actions;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonSyntaxException;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.api.client.ApiSpecificationBuilder;
import com.refinitiv.asts.test.api.client.RestApiClient;
import com.refinitiv.asts.test.config.Config;
import io.restassured.response.Response;
import lombok.SneakyThrows;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;
import java.lang.reflect.Field;
import java.util.Map;

public abstract class BaseApiActions<T> implements ApiActions<T> {

    protected static final String URL = Config.get().value("public.api.url");
    protected static final String DX1_URL = Config.get().value("public.api.dx1.url");
    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    protected static final RestApiClient restClient = new RestApiClient();
    protected static final ApiSpecificationBuilder specBuilder = new ApiSpecificationBuilder();
    protected static final ObjectMapper objectMapper = new ObjectMapper();
    protected ScenarioCtxtWrapper context;

    public BaseApiActions(ScenarioCtxtWrapper context) {
        this.context = context;
    }

    @SneakyThrows
    public <T> T getResponseAsObjectFromContext(String responseReference, TypeReference<T> typeReference) {
        Response response = (Response) context.getScenarioContext().getContext(responseReference);
        try {
            return objectMapper.readValue(response.getBody().asString(), typeReference);
        } catch (JsonSyntaxException | JsonMappingException e) {
            throw new RuntimeException("Unexpected API response body: " + response.getBody().prettyPrint());
        }
    }

    public boolean areFieldsValuesExpected(Object object, Map<String, String> fieldValueMap) {
        for (String fieldName : fieldValueMap.keySet()) {
            String fieldValueByName = String.valueOf(getFieldValueByName(object, fieldName));
            if (!fieldValueByName.equals(fieldValueMap.get(fieldName))) {
                return false;
            }
        }
        return true;
    }

    @SneakyThrows
    private Object getFieldValueByName(Object object, String fieldName) {
        Field field = object.getClass().getDeclaredField(fieldName);
        field.setAccessible(true);
        return field.get(object);
    }

}
