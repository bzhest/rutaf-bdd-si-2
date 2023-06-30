package com.refinitiv.asts.test.api.dto.selfservice.response;

import lombok.Data;

@Data
public class SelfServiceResponseDTO {

    private String message;
    private ProcessIdResponseDTO data;

    @Data
    public class ProcessIdResponseDTO {
        private String processId;
    }

}
