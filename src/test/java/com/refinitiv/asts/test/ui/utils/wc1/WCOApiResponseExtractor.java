package com.refinitiv.asts.test.ui.utils.wc1;

import com.google.common.collect.ImmutableMap;
import com.google.gson.Gson;
import com.refinitiv.asts.test.ui.enums.Providers;
import com.refinitiv.asts.test.ui.utils.wc1.model.CaseResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ProfileResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResolutionToolkitResponseDTO;
import com.refinitiv.asts.test.ui.utils.wc1.model.ResultsResponseDTO;
import io.restassured.response.Response;
import org.apache.http.client.methods.HttpGet;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.core.framework.utils.ApiUtils.getDateNowInHTTPFormat;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiConstants.*;
import static java.lang.String.format;
import static org.apache.commons.codec.digest.HmacAlgorithms.HMAC_SHA_256;
import static org.apache.hc.core5.http.HttpStatus.SC_OK;

public class WCOApiResponseExtractor {

    public static final String WC1_HOST_NAME = "api-worldcheck.refinitiv.com";
    public static final String AUTHORIZATION = "Authorization";
    public static final String DATE = "Date";
    public static final String SIGNATURE_STRING =
            "Signature keyId=\"%s\",algorithm=\"hmac-sha256\",headers=\"%s\",signature=\"%s\"";
    public static final String HOST_DATE = "(request-target) host date";
    public static final String DATA_TO_SIGN = "(request-target): %s %s\nhost: %s\ndate: %s";

    public static CaseResponseDTO getCaseResponse(String caseSystemId) {
        String path = CASES + DELIMITER + caseSystemId;
        Response response =
                WCOApiResponseExtractor.get(path).then().statusCode(SC_OK).log().ifError().extract().response();
        return new Gson().fromJson(response.getBody().asString(), CaseResponseDTO.class);
    }

    public static int getCaseResponseStatusFromWCo(String caseSystemId) {
        String path = CASES + DELIMITER + caseSystemId;
        return get(path).getStatusCode();
    }

    public static List<ResultsResponseDTO> getCaseResultResponse(String caseSystemId) {
        String path = CASES + DELIMITER + caseSystemId + RESULTS;
        Response response = get(path).then().statusCode(SC_OK).log().ifError().extract().response();
        return Arrays.asList(new Gson().fromJson(response.getBody().asString(), ResultsResponseDTO[].class));
    }

    public static ProfileResponseDTO getProfileResponse(String profileId) {
        String path = REFERENCE + PROFILE + DELIMITER + profileId;
        Response response = get(path).then().statusCode(SC_OK).log().ifError().extract().response();
        return new Gson().fromJson(response.getBody().asString(), ProfileResponseDTO.class);
    }

    @SuppressWarnings("unchecked")
    public static Map<String, String> getCountriesReferenceResponse() {
        String path = REFERENCE + COUNTRIES;
        Response response = get(path).then().statusCode(SC_OK).log().ifError().extract().response();
        return new Gson().fromJson(response.getBody().asString(), Map.class);
    }

    public static ResolutionToolkitResponseDTO getResolutionToolkitResponse(String groupId, Providers providerType) {
        String path = GROUPS + DELIMITER + groupId + RESOLUTION_TOOLKITS + DELIMITER + providerType;
        Response response = get(path).then().statusCode(SC_OK).log().ifError().extract().response();
        return new Gson().fromJson(response.getBody().asString(), ResolutionToolkitResponseDTO.class);
    }

    private static Response get(String path) {
        RestClient wc1RestClient = new RestClient(headers(path), PROTOCOL + WC1_HOST_NAME + DELIMITER, V2);
        return wc1RestClient.sendGET(path);
    }

    private static ImmutableMap<String, String> headers(String path) {
        String date = getDateNowInHTTPFormat();
        return new ImmutableMap.Builder<String, String>()
                .put(AUTHORIZATION, getAuthorisationHeader(date, path))
                .put(DATE, date).build();
    }

    private static String getAuthorisationHeader(String date, String url) {
        String hash = generateHashOfContent(date, HttpGet.METHOD_NAME, DELIMITER + V2 + url);
        return format(SIGNATURE_STRING, BASIC_USERNAME, HOST_DATE, hash);
    }

    private static String generateHashOfContent(String date, String requestMethodName, String apiGatewayURL) {
        String dataToSign = format(DATA_TO_SIGN, requestMethodName.toLowerCase(), apiGatewayURL, WC1_HOST_NAME, date);
        return Base64.getEncoder().encodeToString(signContentWithHmacAlgorithm(dataToSign));
    }

    private static byte[] signContentWithHmacAlgorithm(String dataToSign) {
        try {
            Mac mac = Mac.getInstance(HMAC_SHA_256.toString());
            mac.init(new SecretKeySpec(WCOApiConstants.BASIC_PASSWORD.getBytes(), HMAC_SHA_256.toString()));
            return mac.doFinal(dataToSign.getBytes());
        } catch (InvalidKeyException | NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

}
