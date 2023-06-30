package com.refinitiv.asts.test.ui.api.model.screeningManagement;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ScreeningManagementRequestDTO {

    boolean defaultEnableScreeningNewAssociatedParty;
    boolean defaultEnableScreeningNewThirdParty;
    boolean defaultEnableWC1AndCustomWatchlistOGS;

}
