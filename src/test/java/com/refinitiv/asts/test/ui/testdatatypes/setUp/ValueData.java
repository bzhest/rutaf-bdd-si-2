package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ValueData {

    String value;
    String name;
    String scoringRange;
    String dateCreated;
    String lastUpdate;

}
