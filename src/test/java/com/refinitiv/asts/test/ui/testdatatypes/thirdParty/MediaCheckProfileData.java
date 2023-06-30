package com.refinitiv.asts.test.ui.testdatatypes.thirdParty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Accessors(chain = true)
public class MediaCheckProfileData {

    public String name;
    public String articleId;
    public String countryOfRegistration;
    public String lastScreeningDate;
    public String dataProvider;
    public String createdBy;
    public String lastUpdatedBy;

}
