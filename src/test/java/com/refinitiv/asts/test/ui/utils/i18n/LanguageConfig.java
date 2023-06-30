package com.refinitiv.asts.test.ui.utils.i18n;

import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.stepDefinitions.BaseStepDef;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Properties;

import static com.refinitiv.asts.test.ui.constants.TestConstants.KEY_NOT_EXIST;
import static java.lang.String.format;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang.StringUtils.uncapitalize;

@Getter
public class LanguageConfig {

    private static final Logger logger = LoggerFactory.getLogger(Config.class);
    private final Properties properties;
    private static LanguageConfig instance;

    private LanguageConfig() {
        properties = System.getProperties();
        String language = BaseStepDef.getConfigProp().getProperty("language");
        try {
            String bundlesPath =
                    Paths.get(System.getProperty("user.dir"), "src", "test", "resources", "testdata", "i18n",
                              language, "translation.properties").toString();
            properties.load(new FileInputStream(bundlesPath));
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    public String getValue(String key) {
        if (isNull(properties.getProperty(key)) && nonNull(properties.getProperty(uncapitalize(key)))) {
            return properties.getProperty(uncapitalize(key)).toUpperCase();
        }
        return this.properties.getProperty(key, format(KEY_NOT_EXIST, key));
    }

    public static LanguageConfig getInstance() {
        if (instance == null) {
            synchronized (LanguageConfig.class) {
                if (instance == null) {
                    instance = new LanguageConfig();
                }
            }
        }
        return instance;
    }

}
