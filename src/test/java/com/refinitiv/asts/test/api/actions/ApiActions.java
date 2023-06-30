package com.refinitiv.asts.test.api.actions;

import com.fasterxml.jackson.core.type.TypeReference;

public interface ApiActions<T> {

    T getBodyFromContext(String reference, TypeReference<T> typeReference);

}
