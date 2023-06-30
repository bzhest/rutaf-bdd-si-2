package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Attachment {

    String filename;
    String fileFolder;
    String categoryFolder;
    String location;
    String mimeType;
    long fileSize;
    Boolean isFinal;
    String description;
    Object dateUploaded;
    Integer versions;
    String uploadedBy;

}
