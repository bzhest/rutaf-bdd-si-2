package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;

import java.util.List;

@Data
public class MyExportsResponse {

    private List<RecordsItem> records;
    private Param param;

    @Data
    public static class Param {

        private Object search;
        private int totalRecords;
        private String sortType;
        private int limit;
        private int totalPages;
        private String sortBy;
        private int currentPage;

    }

    @Data
    public static class RecordsItem {

        private String summary;
        private String processingStatus;
        private UploadInfo uploadInfo;
        private String reportExportType;
        private long toBeDeletedDateTime;
        private long createdDateTime;
        private String id;
        private long completedDateTime;

        @Data
        public static class UploadInfo {

            private String fileName;
            private String fileLocation;

        }

    }

}