package com.refinitiv.asts.test.ui.utils.email.gmail;

import com.refinitiv.asts.test.config.Config;

import javax.mail.Folder;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;

public class GmailConnector {

    public static final String INBOX = "INBOX";

    public static Folder connect()
            throws MessagingException {

        Session session = Session.getInstance(EmailConfig.get().getProperties());
        Store store = session.getStore(EmailConfig.get().value("mail.protocol"));
        store.connect(EmailConfig.get().value("mail.smtp.host"),
                      Config.get().value("mail.username"),
                      Config.get().value("mail.application.password"));
        Folder folder = store.getFolder(INBOX);
        folder.open(Folder.READ_WRITE);
        return folder;
    }

}