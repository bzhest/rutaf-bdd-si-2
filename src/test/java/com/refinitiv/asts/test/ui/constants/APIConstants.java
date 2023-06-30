package com.refinitiv.asts.test.ui.constants;

import com.google.common.collect.ImmutableMap;

/**
 * Add any APIConstants which you think you need to use in your project
 */
public class APIConstants {

    //    Parameters
    public static final String NAME = "name";
    public static final String EMAIL = "email";
    public static final String LIMIT = "limit";
    public static final String SORT_BY = "sort_by";
    public static final String SORT_BY_CAMEL_CASE = "sortBy";
    public static final String SORT_ORDER = "sort_order";
    public static final String OFFSET = "offset";
    public static final String STATUS = "status";
    public static final String SKIP = "skip";
    public static final String FILTER = "filter";
    public static final String LANGUAGE_IDS = "languageIds";
    public static final String SORT = "sort";
    public static final String START_DATE = "startDate";
    public static final String END_DATE = "endDate";
    public static final String TYPE = "type";
    public static final String ALL_ACTIVITIES_TYPE = "DIVISION";
    public static final String MY_ACTIVITIES_TYPE = "USER";
    public static final String ASC = "ASC";
    public static final String DESC = "DESC";
    public static final String SCORE = "score";
    public static final String DATE_CREATED = "dateCreated";
    public static final String _ID = "_id";
    public static final String ALL = "ALL";
    public static final String SAME_DIVISION = "SAME_DIVISION";
    public static final String AUTHORIZATION = "Authorization";
    public static final String RECIPIENT = "recipient";
    public static final String SCREEN = "screen";
    public static final String CURRENT_PAGE = "currentPage";
    public static final String MESSAGE = "message";
    public static final String SUCCESS = "success";
    public static final String FETCH_TYPE = "fetchType";
    public static final String PAGE = "page";
    public static final String PAGE_SIZE = "pageSize";
    public static final String ORDER_BY = "orderBy";
    public static final String SUPPLIER_ID = "supplierId";
    public static final ImmutableMap<String, String> SORT_ORDER_SIGN = new ImmutableMap.Builder<String, String>()
            .put(ASC, "+")
            .put(DESC, "-")
            .build();

}
