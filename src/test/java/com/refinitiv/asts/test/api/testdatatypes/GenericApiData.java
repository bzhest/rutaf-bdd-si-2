package com.refinitiv.asts.test.api.testdatatypes;

import lombok.Data;

@Data
public class GenericApiData<T> {

    T request;
    T response;

}

