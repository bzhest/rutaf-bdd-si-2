package com.refinitiv.asts.test.ui.utils.data.ui;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class CommentDTO {

    private String author;
    private String date;
    private String commentText;

}
