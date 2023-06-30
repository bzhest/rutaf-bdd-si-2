package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ActivityInformationAttachmentData {

    private String fileName;
    private String description;
    private String uploadedBy;
    private String uploadDate;
    private boolean isDownloadIconPresent;
    private boolean isDeleteIconPresent;

}
