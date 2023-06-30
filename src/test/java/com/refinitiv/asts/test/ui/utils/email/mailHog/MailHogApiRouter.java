package com.refinitiv.asts.test.ui.utils.email.mailHog;

import com.refinitiv.asts.test.config.Config;

import java.util.List;

import static java.util.Arrays.asList;

public class MailHogApiRouter {

    private static final Config CONFIG = Config.get();
    private static final List<String> WSO2_EMAILS_SUBJECT = asList("Create Password",
                                                                   "Password Reset",
                                                                   "Your Account has been Disabled",
                                                                   "Your Account has been Enabled",
                                                                   "Créer un mot de passe pour le nouveau compte",
                                                                   "Login Request");

    protected static MailHogApiClient getMailHogClient(boolean isWSO2MailHog) {
        return isWSO2MailHog ?
                new MailHogApiClient(CONFIG.value("wso2.mail.hog.url"),
                                     CONFIG.value("wso2.mail.hog.username"),
                                     CONFIG.value("wso2.mail.hog.password")) :
                new MailHogApiClient(CONFIG.value("si.mail.hog.url"),
                                     CONFIG.value("si.mail.hog.username"),
                                     CONFIG.value("si.mail.hog.password"));
    }

    protected static boolean isWSO2MailHogClient(String subject) {
        return WSO2_EMAILS_SUBJECT.stream().anyMatch(subject::contains);
    }

}
