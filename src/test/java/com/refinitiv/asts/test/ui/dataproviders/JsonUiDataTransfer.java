package com.refinitiv.asts.test.ui.dataproviders;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.refinitiv.asts.core.managers.FileReaderManager;
import com.refinitiv.asts.test.dataTransfer.JsonDataTransfer;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.File;
import java.io.IOException;
import java.util.Map;

@EqualsAndHashCode(callSuper = true)
@Data
public class JsonUiDataTransfer<T> extends JsonDataTransfer<DataProvider> {
    private Map<String, GenericTestData<T>> testData;

    public JsonUiDataTransfer(DataProvider dataProvider) {
        createDataFromJson(dataProvider);
    }

    @Override
    public void createDataFromJson(DataProvider dataProvider) {
        mapper.enable(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY);
        String filePath = FileReaderManager.getInstance().getConfigReader().getTestDataResourcePath() +
                dataProvider.getJsonDataFile();
        JavaType mapType = getMapType(GenericTestData.class, dataProvider.getDataPayloadClass());
        try {
            testData = mapper.readValue(new File(filePath), mapType);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
