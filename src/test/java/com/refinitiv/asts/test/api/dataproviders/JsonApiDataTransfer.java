package com.refinitiv.asts.test.api.dataproviders;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.refinitiv.asts.core.managers.FileReaderManager;
import com.refinitiv.asts.test.api.testdatatypes.GenericApiData;
import com.refinitiv.asts.test.dataTransfer.JsonDataTransfer;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.File;
import java.io.IOException;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class JsonApiDataTransfer<T> extends JsonDataTransfer<ApiDataProvider> {

    private Map<String, GenericApiData<T>> testData;

    public JsonApiDataTransfer(ApiDataProvider dataProvider) {
        createDataFromJson(dataProvider);
    }

    @Override
    public void createDataFromJson(ApiDataProvider dataProvider) {
        mapper.enable(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY);
        String filePath = FileReaderManager.getInstance().getConfigReader().getTestDataResourcePath() +
                dataProvider.getJsonDataFile();
        JavaType mapType = getMapType(GenericApiData.class, dataProvider.getDataPayloadClass());
        try {
            testData = mapper.readValue(new File(filePath), mapType);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public T getResponseJsonData(String reference) {
        return testData.get(reference).getResponse();
    }

    public Object getResponseJsonData(String reference, TypeReference<?> toValueTypeRef) {
        T response = getResponseJsonData(reference);
        return mapper.convertValue(response, toValueTypeRef);
    }

    public T getRequestJsonData(String reference) {
        return testData.get(reference).getRequest();
    }

}
