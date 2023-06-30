package com.refinitiv.asts.test.api.dto.riskscoringengine.response;

import lombok.Data;

import java.text.DecimalFormat;

@Data
public class RiskAreaPOJO {

    private Double score;
    private String uid;
    private String description;

    public void setScore(Double score) {
        this.score = Double.parseDouble( new DecimalFormat("#.##").format(score.doubleValue()) );
    }

    public Double getScore() {
        return Double.parseDouble( new DecimalFormat("#.##").format(score.doubleValue()) );
    }

    @Override
    public boolean equals(Object otherObj) {
        if (this == otherObj) {
            return true;
        }
        if (! (otherObj instanceof RiskAreaPOJO)) {
            return false;
        }
        RiskAreaPOJO other = (RiskAreaPOJO) otherObj;
        boolean isUidEquals         = (this.uid==null         && other.uid==null        ) || (this.uid!=null         && this.uid.equals(other.uid)                );
        boolean isDescriptionEquals = (this.description==null && other.description==null) || (this.description!=null && this.description.equals(other.description));
        boolean isScoreEquals       = (this.score==null       && other.score==null      ) || (this.score!=null       && this.score.equals(other.score)            );

        return isUidEquals && isDescriptionEquals && isScoreEquals;
    }

    @Override
    public final int hashCode() {
        int prime = 31;
        int hash = (int) (this.score==null? 0 : (this.score.hashCode() ^ (this.score.hashCode() >>> 32)) );
        hash = prime * hash  +  (this.uid==null?         0 : this.uid.hashCode()        );
        hash = prime * hash  +  (this.description==null? 0 : this.description.hashCode());
        return hash;
    }

}
