package com.refinitiv.asts.test.ui.testdatatypes;

import lombok.Data;

@Data
public class GenericTestData<T> {

    T dataToEnter;
    T dataToEdit;
    T dataForAssertions;

}

