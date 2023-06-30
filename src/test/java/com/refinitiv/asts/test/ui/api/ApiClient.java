package com.refinitiv.asts.test.ui.api;

import com.google.gson.Gson;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.core.framework.drivers.DriverFactory;
import com.refinitiv.asts.test.config.Config;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.ObjectMapperConfig;
import io.restassured.config.RestAssuredConfig;
import io.restassured.filter.log.ErrorLoggingFilter;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.http.ContentType;
import io.restassured.mapper.ObjectMapperType;
import io.restassured.specification.RequestSpecification;
import lombok.NoArgsConstructor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.openqa.selenium.Cookie;

import java.lang.invoke.MethodHandles;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.COOKIES;
import static io.restassured.RestAssured.given;
import static io.restassured.config.EncoderConfig.encoderConfig;
import static io.restassured.config.RedirectConfig.redirectConfig;
import static java.util.Objects.isNull;

@NoArgsConstructor
public class ApiClient {

    protected static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private static ScenarioCtxtWrapper context;

    public ApiClient(ScenarioCtxtWrapper context) {
        ApiClient.context = context;
    }

    public void setUp() {
        if (isNull(RestAssured.requestSpecification)) {
            logger.info("Set up API client");
            RestAssured.requestSpecification = new RequestSpecBuilder()
                    .setContentType(ContentType.JSON)
                    .setAccept(ContentType.JSON)
                    .setRelaxedHTTPSValidation()
                    .addFilters(List.of(new RequestLoggingFilter(LogDetail.URI),
                                        new RequestLoggingFilter(LogDetail.METHOD),
                                        new ResponseLoggingFilter(LogDetail.STATUS),
                                        new ErrorLoggingFilter()))
                    .build();
            RestAssured.config = new RestAssuredConfig()
                    .encoderConfig(encoderConfig().defaultContentCharset(StandardCharsets.UTF_8))
                    .redirect(redirectConfig().followRedirects(false))
                    .objectMapperConfig(new ObjectMapperConfig(ObjectMapperType.GSON)
                                                .gsonObjectMapperFactory((cl, ch) -> new Gson()));
        }
    }

    public RequestSpecification getClient(String baseUrl) {
        return given(new RequestSpecBuilder()
                             .addHeader("cookie", getCookies())
                             .addCookie("X-Tenant-Code", Config.get().value("tenant"))
                             .setBaseUri(baseUrl).build());
    }

    @SuppressWarnings("unchecked")
    public static String getCookies() {
        Set<Cookie> cookies;
        if (Objects.nonNull(context) && context.getScenarioContext().isContains(COOKIES)) {
            cookies = (Set<Cookie>) context.getScenarioContext().getContext(COOKIES);
        } else {
            cookies = DriverFactory.getDriver().manage().getCookies();
        }
        return cookies.stream().map(cookie -> cookie.getName() + "=" + cookie.getValue())
                .collect(Collectors.joining(";"));
    }

    public static void clearCookies() {
        DriverFactory.getDriver().manage().deleteAllCookies();
        DriverFactory.getDriver().navigate().refresh();
    }

}