package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;

import static java.util.Arrays.asList;

@Getter
@RequiredArgsConstructor
public enum KeyData {

    CATEGORY("CATEGORY"),
    SUB_CATEGORY("SUB CATEGORY"),
    ORGANISATION_NAME("ORGANISATION NAME"),
    NAME("Name"),
    TITLE("TITLE"),
    POSITION("POSITION"),
    CITIZENSHIP("CITIZENSHIP"),
    AGE("AGE"),
    AGE_AS_OF_DATE("AGE AS OF DATE"),
    GENDER("GENDER"),
    RECORD_UPDATE("RECORD UPDATE"),
    DATE_OF_BIRTH("DATE OF BIRTH"),
    DECEASED_DATE("DECEASED DATE"),
    PLACE_OF_BIRTH("PLACE OF BIRTH"),
    LOCATION_DETAILS("LOCATION DETAILS"),
    IDENTIFICATION_NUMBER("IDENTIFICATION NUMBER(S)"),
    REGISTERED_COUNTRY("REGISTERED COUNTRY"),
    ENTERED_DATE("ENTERED DATE"),
    UPDATED_DATE("UPDATED DATE"),
    UPDATE_CATEGORY("UPDATE CATEGORIZATION"),
    STREET("STREET"),
    CITY("CITY"),
    REGION("REGION"),
    COUNTRY("COUNTRY"),
    NUMBER("NUMBER"),
    ISSUER_COUNTRY("ISSUER/COUNTRY");

    private final String name;

    public static List<String> getLocationDetailsColumnNames() {
        return asList(STREET.getName(), CITY.getName(), REGION.getName(), COUNTRY.getName());
    }

    public static List<String> getIdentificationNumberColumnNames() {
        return asList(NAME.getName(), NUMBER.getName(), ISSUER_COUNTRY.getName());
    }

    public static List<String> getRecordUpdateColumnNames() {
        return asList(ENTERED_DATE.getName(), UPDATED_DATE.getName(), UPDATE_CATEGORY.getName());
    }
}
