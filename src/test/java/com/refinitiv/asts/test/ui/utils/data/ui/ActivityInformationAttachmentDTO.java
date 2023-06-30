package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;
import org.openqa.selenium.WebElement;

import java.util.Comparator;

import static com.refinitiv.asts.test.ui.utils.DateUtil.SI_UI_DATE_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getDateFromStringDate;

@Data
@Accessors(chain = true)
public class ActivityInformationAttachmentDTO {

    private WebElement fileName;
    private WebElement description;
    private WebElement uploadedBy;
    private WebElement uploadDate;
    private WebElement downloadIcon;
    private WebElement deleteIcon;

    public static class ActivityAttachmentFilenameComparator implements Comparator<ActivityInformationAttachmentDTO> {

        @Override
        public int compare(ActivityInformationAttachmentDTO attachmentObject1,
                ActivityInformationAttachmentDTO attachmentObject2) {
            return attachmentObject1.getFileName().getText().compareToIgnoreCase(attachmentObject2.getFileName().getText());
        }

    }

    public static class ActivityDescriptionComparator implements Comparator<ActivityInformationAttachmentDTO> {

        @Override
        public int compare(ActivityInformationAttachmentDTO attachmentObject1,
                ActivityInformationAttachmentDTO attachmentObject2) {
            return attachmentObject1.getDescription().getText().compareToIgnoreCase(attachmentObject2.getDescription().getText());
        }

    }

    public static class ActivityAttachmentDateComparator implements Comparator<ActivityInformationAttachmentDTO> {

        @Override
        public int compare(ActivityInformationAttachmentDTO attachmentObject1,
                ActivityInformationAttachmentDTO attachmentObject2) {
            return getDateFromStringDate(attachmentObject1.getUploadDate().getText(), SI_UI_DATE_FORMAT)
                    .compareTo(getDateFromStringDate(attachmentObject2.getUploadDate().getText(), SI_UI_DATE_FORMAT));
        }

    }

}
