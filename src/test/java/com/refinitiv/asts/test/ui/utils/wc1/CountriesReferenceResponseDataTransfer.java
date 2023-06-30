package com.refinitiv.asts.test.ui.utils.wc1;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.refinitiv.asts.test.ui.api.model.ReferencesResponse;
import com.refinitiv.asts.test.ui.api.model.Reference;
import lombok.SneakyThrows;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.COUNTRY;
import static com.refinitiv.asts.test.ui.utils.CountryUtil.getISO2ByISO3CountryCode;
import static com.refinitiv.asts.test.ui.utils.wc1.WCOApiResponseExtractor.getCountriesReferenceResponse;

public class CountriesReferenceResponseDataTransfer {

    @SneakyThrows
    public static DocumentContext getExpectedCountriesOutput() {
        Map<String, String> countries = getCountriesReferenceResponse();
        ReferencesResponse expectedResponse = new ReferencesResponse().setReferences(buildCountriesList(countries));
        ObjectMapper mapper = new ObjectMapper();
        return JsonPath.parse(mapper.writeValueAsString(expectedResponse));
    }

    public static List<String> getWC1CountriesNamesList() {
        List<Reference> countries = buildCountriesList(getCountriesReferenceResponse());
        return countries.stream().map(Reference::getDescription).collect(Collectors.toList());
    }

    public static List<String> getCountriesCodesList() {
        List<Reference> countries = buildCountriesList(getCountriesReferenceResponse());
        return countries.stream().map(Reference::getCode).collect(Collectors.toList());
    }

    public static String getCountryNameByCode(String countryCode) {
        List<Reference> countries = buildCountriesList(getCountriesReferenceResponse());
        return countries.stream().filter(value -> value.getCode().contains(countryCode)).map(Reference::getDescription)
                .findFirst().orElse(null);
    }

    private static List<Reference> buildCountriesList(Map<String, String> countries) {
        return countries.keySet()
                .stream()
                .filter(countryCode -> !countryCode.equals("ZZZ"))
                .map(countryCode -> new Reference()
                        .setCode(getISO2ByISO3CountryCode(countryCode))
                        .setDescription(countries.get(countryCode))).collect(Collectors.toList());
    }

}
