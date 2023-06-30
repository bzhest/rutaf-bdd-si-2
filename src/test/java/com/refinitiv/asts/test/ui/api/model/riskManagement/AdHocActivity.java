package com.refinitiv.asts.test.ui.api.model.riskManagement;

import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import lombok.Data;
import lombok.experimental.Accessors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.AUTO_TEST_NAME_PREFIX;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;

@Data
@Accessors(chain = true)
public class AdHocActivity {

    private Long dueDate;
    private String name;
    private String description;
    private Assignee assignee;
    private ActivityType activityType;
    private String status;

    @Data
    public static class Assignee {

        private String name;
        private String email;

    }

    @Data
    public static class ActivityType {

        private String name;

    }

    public static AdHocActivity defaultValues() {
        return new AdHocActivity()
                .setActivityType(new ActivityType().setName("Approve Onboarding"))
                .setStatus("Draft")
                .setAssignee(new Assignee()
                                     .setEmail(Config.get().value("admin.username"))
                                     .setName(String.format("%s %s",
                                                            Config.get().value("admin.firstName"),
                                                            Config.get().value("admin.lastName"))))
                .setDescription(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10))
                .setName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10))
                .setDueDate(DateUtil.getDateAfterInEpoch(2));
    }

}
