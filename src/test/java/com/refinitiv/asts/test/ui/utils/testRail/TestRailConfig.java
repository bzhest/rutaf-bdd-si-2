package com.refinitiv.asts.test.ui.utils.testRail;

import com.refinitiv.asts.test.config.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Properties;

public class TestRailConfig {

    private static final Logger logger = LoggerFactory.getLogger(Config.class);
    private static volatile TestRailConfig instance;
    private final Properties properties;

    private TestRailConfig() {
        properties = System.getProperties();
        try {
            String propertiesPath =
                    Paths.get(System.getProperty("user.dir"), "src", "test", "resources", "env", "testRail",
                              "testRail.properties").toString();
            properties.load(new FileInputStream(propertiesPath));
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    public static TestRailConfig getInstance() {
        if (instance == null) {
            synchronized (TestRailConfig.class) {
                if (instance == null) {
                    instance = new TestRailConfig();
                }
            }
        }
        return instance;
    }

    public String value(String key) {
        return this.properties.getProperty(key, String.format("The key %s does not exists!", key));
    }

}
