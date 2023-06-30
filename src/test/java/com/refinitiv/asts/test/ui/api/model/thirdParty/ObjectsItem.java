package com.refinitiv.asts.test.ui.api.model.thirdParty;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ObjectsItem {

    private Object userDivisions;
    @JsonAlias({"riskTier", "riskLevel"})
    private String riskLevel;
    private Address address;
    private Object updateTime;
    private Object managerDivisions;
    private Object createBy;
    private Object industryType;
    private Object createTime;
    private String name;
    private Object supplierManager;
    private String id;
    private String iwOgmStatus;
    @JsonAlias({"screeningStatus", "overallStatus"})
    private String overallStatus;
    private String status;

    @JsonAlias("country")
    private void setAddressCountry(String country) {
        address = new Address().setCountry(country);
    }

}