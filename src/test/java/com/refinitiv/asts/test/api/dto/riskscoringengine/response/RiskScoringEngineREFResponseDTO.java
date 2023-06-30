package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class RiskScoringEngineREFResponseDTO {

    private String modelName;
    private String modelCode;
    private List<RiskAreaPOJO> riskAreas;
    private Double averageRiskScore;

    public String getModelName() {
        return String.format("%-24.24s", (this.modelName!=null? this.modelName : "NULL") );
    }

    public String getModelCode() {
        return String.format("%-8.8s", (this.modelCode!=null? this.modelCode : "NULL") );
    }

    @Override
    public boolean equals( Object otherObj ) {
        if (this == otherObj) {
            return true;
        }
        if (! (otherObj instanceof RiskScoringEngineREFResponseDTO ) ) {
            return false;
        }
        RiskScoringEngineREFResponseDTO other = (RiskScoringEngineREFResponseDTO) otherObj;
        boolean isAverageRiskScoreEquals = ( this.averageRiskScore==null && other.averageRiskScore==null ) || (this.averageRiskScore!=null && this.averageRiskScore.equals(other.averageRiskScore) );
        return isAverageRiskScoreEquals;
    }

    @Override
    public final int hashCode() {
        int prime = 31;
        int hash = (int) (this.averageRiskScore==null? 0 : (this.averageRiskScore.hashCode() ^ (this.averageRiskScore.hashCode() >>> 32)) );
        hash     = prime * hash  +  (this.riskAreas==null? 0 : this.riskAreas.hashCode());
        return hash;
    }

}
