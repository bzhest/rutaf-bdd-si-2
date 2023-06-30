package com.refinitiv.asts.test.ui.api;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.model.FileUploadResponse;

import java.io.File;

import static com.refinitiv.asts.test.ui.api.ResponseBodyParser.parseResponseBody;
import static org.apache.hc.core5.http.HttpStatus.SC_OK;
import static org.apache.http.entity.ContentType.MULTIPART_FORM_DATA;
import static org.apache.http.entity.mime.MIME.CONTENT_TYPE;

public class DmsApi extends BaseApi {

    private static final String TENANT = Config.get().value("tenant");
    private static final String FILE = "file";

    public DmsApi(ScenarioCtxtWrapper context) {
        super(context);
    }

    public static FileUploadResponse postFile(File file, String mimeType) {
        return parseResponseBody(given()
                                         .header(CONTENT_TYPE, MULTIPART_FORM_DATA.getMimeType())
                                         .multiPart(FILE, file, mimeType)
                                         .expect().statusCode(SC_OK)
                                         .when()
                                         .post(Endpoints.API_FILES, TENANT), FileUploadResponse.class);
    }

}
