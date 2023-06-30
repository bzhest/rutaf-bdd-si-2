package com.refinitiv.asts.test.ui.api.model;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class ReferencesResponse {

    List<Reference> references;

}
