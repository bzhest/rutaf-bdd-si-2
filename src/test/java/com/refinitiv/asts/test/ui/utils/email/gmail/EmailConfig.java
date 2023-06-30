package com.refinitiv.asts.test.ui.utils.email.gmail;

import com.refinitiv.asts.test.config.Config;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

@Getter
public class EmailConfig {

    private static final Logger LOG = LoggerFactory.getLogger(Config.class);
    private static final String GMAIL = "gmail";
    private static final String MAIL_HOG = "mailHog";
    private static EmailConfig instance;
    private final Properties properties;

    private EmailConfig() {
        properties = System.getProperties();
        try {
            String propertiesPath = System.getProperty("user.dir") +
                    File.separator + "src" +
                    File.separator + "test" +
                    File.separator + "resources" +
                    File.separator + "env" +
                    File.separator + "email" +
                    File.separator + "email.properties";

            properties.load(new FileInputStream(propertiesPath));
        } catch (IOException e) {
            LOG.error(e.getMessage());
        }
    }

    public static synchronized EmailConfig get() {
        if (instance == null) {
            instance = new EmailConfig();
        }
        return instance;
    }

    public String value(String key) {
        return this.properties.getProperty(key, String.format("The key %s does not exists!", key));
    }

    public static boolean isGmailEmailUtil() {
        return Config.get().value("emailUtil").equals(GMAIL);
    }

}

