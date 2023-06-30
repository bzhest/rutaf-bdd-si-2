package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;

import java.util.List;

@Data
public class LanguageResponse {

    private Object total;
    private List<Language> objects;

    @Data
    public static class Language {

        private String code;
        private String description;
        private boolean initialValue;

    }

}