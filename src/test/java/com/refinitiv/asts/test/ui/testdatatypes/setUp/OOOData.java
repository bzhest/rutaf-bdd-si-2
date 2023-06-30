package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class OOOData {

    String name;
    String dateTime;
    String oldValue;
    String newValue;

}
