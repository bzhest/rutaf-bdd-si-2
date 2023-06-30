package com.refinitiv.asts.test.ui.api.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class CreateSupplierRequest {

    @JsonProperty(required = true)
    String name;
    @JsonProperty(required = true)
    Address address;
    @JsonProperty(required = true)
    String responsibleParty;
    @JsonProperty(required = true)
    List<String> divisions;
    String workflowGroupId;
    String industryType;
    List<Attachment> attachments;
    @JsonProperty(required = true)
    String worldCheckGroup;

}
