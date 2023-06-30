package com.refinitiv.asts.test.api.client;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.BaseApi;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import static com.refinitiv.asts.test.api.constants.ApiRequestConstants.*;
import static org.apache.http.entity.ContentType.MULTIPART_FORM_DATA;
import static org.apache.http.entity.mime.MIME.CONTENT_TYPE;

public class FileUploadClient extends BaseApi {

    private static final String REQUESTOR = Config.get().value("selfservice.requestor.email");
    private static final String FILE = "file";
    private static final String CSV_MIMETYPE = "text/csv";

    public FileUploadClient(ScenarioCtxtWrapper context) {
        super(context);
    }

    public static Response postFileSelfService(RequestSpecification requestSpec, String endpoint, File file,
            String processType) {
        Map<String, String> headersMap = new HashMap<>();
        headersMap.put(CONTENT_TYPE, MULTIPART_FORM_DATA.getMimeType());
        headersMap.put(REQUESTOR_EMAIL, REQUESTOR);
        return given().spec(requestSpec)
                .headers(headersMap)
                .queryParam(PROCESS_TYPE, processType)
                .multiPart(FILE, file, CSV_MIMETYPE)
                .when()
                .post(endpoint);
    }

}
