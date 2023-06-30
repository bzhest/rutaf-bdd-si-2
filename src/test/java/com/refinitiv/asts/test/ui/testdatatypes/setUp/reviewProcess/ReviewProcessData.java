package com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class ReviewProcessData {

    private String reviewProcessName;
    private String description;
    private String active;
    private String defaultReviewer;
    private String addRulesFor;
    private List<String> activityOwner;
    private List<String> reviewer;
    private String reviewerMethod;

}