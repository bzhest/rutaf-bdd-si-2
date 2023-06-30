package com.refinitiv.asts.test.api.dto.references.response;


import lombok.Data;

@Data
public class DivisionResponseDTO {

    private String country;
    private String lastUpdated;
    private String dateCreated;
    private String name;
    private String divisionId;
    private String region;
    private Boolean status;

}
