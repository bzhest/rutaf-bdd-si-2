package com.refinitiv.asts.test.ui.api.model.dashboard;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Data
public class RenewalMatrixResponse {

    private int firstNDays;
    private int renewingVolumeForRenewal;
    private double renewingCycleTimeAverage;
    private int renewedLastNDays;
    private double renewingCycleTimeLongest;
    private int secondNDays;
    private int renewingVolumeRenewing;
    private double renewingCycleTimeShortest;

    @JsonProperty("renewingCycleTimeAverage")
    public void setRenewingCycleTimeAverage(double renewingCycleTimeAverage) {
        this.renewingCycleTimeAverage = BigDecimal.valueOf(renewingCycleTimeAverage)
                .setScale(1, RoundingMode.HALF_UP)
                .doubleValue();
    }

}
