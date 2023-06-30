package com.refinitiv.asts.test.api.dto.selfservice.response;

import lombok.Data;

@Data
public class SelfServiceProcessIdStatusResponseDTO {

    private String message;
    private DataResponseDTO data;

    @Data
    public class DataResponseDTO {

        private String processId;
        private String filename;
        private MetaResponseDTO meta;
        private String uploadTime;
        private String uploadDate;
        private String status;
        private String relatedFilesStatus;
        private String errors;
        private StatusResponseFileDTO successResponseFile;
        private StatusResponseFileDTO errorResponseFile;
        private int numberOfRecords;
        private int recordProcessed;
        private int recordWithErrors;
        private String triggeredBy;
        private String entityId;
        private String childReferenceId;
        private String entityType;
        private String processType;

        @Data
        public class MetaResponseDTO {

            private String filename;
            private int fileSize;
            private String location;

        }

        @Data
        public class StatusResponseFileDTO {

            private String filename;
            private int fileSize;
            private String location;

        }

    }

}
