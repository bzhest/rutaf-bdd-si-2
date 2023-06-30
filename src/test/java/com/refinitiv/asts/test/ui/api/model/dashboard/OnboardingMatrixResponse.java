package com.refinitiv.asts.test.ui.api.model.dashboard;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.text.DecimalFormat;

import static java.lang.Double.parseDouble;

@Data
public class OnboardingMatrixResponse {

    private int onboardingCycleTimeShortest;
    private double partnerVolumePercent;
    private double onboardingCycleTimeLongest;
    private int partnerVolumeCount;
    private int onboardingVolumeInProgress;
    private int onboardingVolumeNew;
    private double onboardingCycleTimeAverage;
    private int onboardedLastNDays;

    @JsonProperty("partnerVolumePercent")
    public void setPartnerVolumePercent(double percent) {
        this.partnerVolumePercent = parseDouble(new DecimalFormat("#.#").format(percent));
    }

    @JsonProperty("onboardingCycleTimeAverage")
    public void setOnboardingCycleTimeAverage(double onboardingCycleTimeAverage) {
        this.onboardingCycleTimeAverage =
                parseDouble(new DecimalFormat("#.#").format(onboardingCycleTimeAverage));
    }

}
