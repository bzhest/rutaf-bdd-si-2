package com.refinitiv.asts.test.ui.api.model.thirdParty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.text.DecimalFormat;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class RiskArea {

    String description;
    double score;

    public void setScore(double score) {
        this.score = Double.parseDouble(new DecimalFormat("#.######").format(score));
    }

}
