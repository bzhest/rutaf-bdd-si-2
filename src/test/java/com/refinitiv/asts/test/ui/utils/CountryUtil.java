package com.refinitiv.asts.test.ui.utils;

import org.apache.commons.lang3.StringUtils;

import java.util.Arrays;
import java.util.Locale;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

public class CountryUtil {

    public static String getRandomCountry() {
        String[] isoCountries = Locale.getISOCountries();
        int randomNum = ThreadLocalRandom.current().nextInt(0, isoCountries.length);
        return isoCountries[randomNum];
    }

    public static String getISO3ByISO2CountryCode(String iso2CountryName) {
        return new Locale(StringUtils.EMPTY, iso2CountryName).getDisplayCountry();
    }

    public static String getISO2ByISO3CountryCode(String iso3CountryCode) {
        return Arrays.stream(Locale.getISOCountries())
                .map(country -> new Locale(StringUtils.EMPTY, country))
                .collect(Collectors
                                 .toMap(locale -> locale.getISO3Country().toUpperCase(),
                                        locale -> locale))
                .get(iso3CountryCode)
                .getCountry();
    }

    public static String getCountryName(String isoCode) {
        return new Locale(StringUtils.EMPTY, isoCode).getDisplayCountry();
    }

}
