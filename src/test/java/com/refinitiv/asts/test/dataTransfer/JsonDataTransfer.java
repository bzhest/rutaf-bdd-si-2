package com.refinitiv.asts.test.dataTransfer;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;

import java.util.Map;

@Data
public abstract class JsonDataTransfer<T> {

    protected final ObjectMapper mapper = new ObjectMapper();

    public abstract void createDataFromJson(T dataProvider);

    protected JavaType getMapType(Class<?> parametrized, Class<?> dataPayloadClass) {
        JavaType dataType = mapper.getTypeFactory().constructParametricType(parametrized, dataPayloadClass);
        JavaType keyType = mapper.getTypeFactory().constructType(String.class);
        return mapper.getTypeFactory().constructMapType(Map.class, keyType, dataType);
    }

}
