package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UsersList {

    private UserItem[] users;

}
