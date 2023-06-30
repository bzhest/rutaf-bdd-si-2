package com.refinitiv.asts.test.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Config {

    private static final Logger LOG = LoggerFactory.getLogger(Config.class);

    private final Properties properties;
    private static Config instance = null;

    private Config() {
        properties = new Properties();
        try {
            InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("config.properties");
            properties.load(inputStream);
        } catch (IOException e) {
            LOG.error(e.getMessage());
        }
    }

    public static synchronized Config get() {
        if (instance == null) {
            instance = new Config();
        }
        return instance;
    }

    public String value(String key) {
        return this.properties.getProperty(key, String.format("The key %s does not exists!", key));
    }

}
