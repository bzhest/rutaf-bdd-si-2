
package com.refinitiv.asts.test.scripts;

import com.refinitiv.asts.test.config.Config;
import lombok.SneakyThrows;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.isNotEmpty;

/**
 * PoFilesParser class makes .po file(s) (dictionaries) parsing and creates .txt file(s) with "key=value" format, content of
 * .txt file(s) can be copied and pasted into corresponding to language translation.properties resource bundle (in "src/test/resources/testdata/i18n" path)
 * Before parsing, corresponding .po file(s) should be downloaded from repository https://gitlab.dx1.lseg.com/250248/application/ds-si/-/tree/master/i18n/po
 * and put into path "src/test/resources/testdata/i18n".
 * In 'main' method pass .po file(s) name as argument(s) into List.of() method.
 * <p>
 * Example:
 * List<String> languagesTxtFilesToCreate = List.of("zhCN", "fr", "de");
 * <p>
 * As a result of 'main' method execution, in same path "src/test/resources/testdata/i18n" would be created .txt files with translations.
 * All .po and .txt files are added to .gitignore and wouldn't be commited.
 */
public class PoFilesParser {

    private static final Logger logger = LoggerFactory.getLogger(Config.class);
    private static final Properties properties = new Properties();
    private static Map<String, String> dictionary = new HashMap<>();
    private static List<String> poTranslationFileRecords = new ArrayList<>();
    private final static String englishVersionPattern = "(?<=msgid )(.*)(?=msgstr)";
    private final static String translationVersionPattern = "(?<=msgstr )(.*$)";

    /**
     * Specify the languages list for which the translation.txt file would be created
     */
    @SneakyThrows
    public static void main(String[] args) {
        List<String> languagesTxtFilesToCreate = List.of("de", "fr", "es", "it", "pt");
        loadDefaultTranslationProperties();
        languagesTxtFilesToCreate.forEach(language -> {
            readPoTranslationFile(language);
            getTranslationDictionary();
            writeTranslationToTextFile(language);
        });
    }

    @SneakyThrows
    private static void loadDefaultTranslationProperties() {
        String defaultTranslationPropertiesPath =
                Paths.get(System.getProperty("user.dir"), "src", "test", "resources", "testdata", "i18n",
                          "en", "translation.properties").toString();
        properties.load(new FileInputStream(defaultTranslationPropertiesPath));
    }

    @SneakyThrows
    private static void readPoTranslationFile(String language) {
        String translationFilePath =
                Paths.get(System.getProperty("user.dir"), "src", "test", "resources", "testdata", "i18n",
                          language + ".po").toString();
        FileInputStream fis = new FileInputStream(translationFilePath);
        poTranslationFileRecords = IOUtils.readLines(fis, "UTF-8");
    }

    private static void getTranslationDictionary() {
        List<String> translationRecords = PoFilesParser.poTranslationFileRecords.stream()
                .filter(line -> !line.startsWith(HASH))
                .collect(Collectors.toList());
        ArrayList<String> updatedPOTranslationFileRecords = new ArrayList<>();
        int elementWithoutTranslationNumber = 1;
        String recordToAdd = EMPTY;
        for (int record = 0; record < translationRecords.size(); record++) {
            if (translationRecords.get(record).equals(EMPTY) && isNotEmpty(recordToAdd)) {
                updatedPOTranslationFileRecords.add(recordToAdd);
                recordToAdd = EMPTY;
            } else {
                recordToAdd += translationRecords.get(record);
                if (record == translationRecords.size() - 1) {
                    updatedPOTranslationFileRecords.add(recordToAdd);
                }
            }
        }

        dictionary = updatedPOTranslationFileRecords.stream().skip(elementWithoutTranslationNumber).collect(
                Collectors.toMap(text -> getTextByPattern(englishVersionPattern, text).replaceAll(DOUBLE_QUOTES, EMPTY),
                                 text -> getTextByPattern(translationVersionPattern, text).replaceAll(DOUBLE_QUOTES,
                                                                                                      EMPTY)));
    }

    private static void writeTranslationToTextFile(String language) {
        Enumeration<Object> keys = properties.keys();
        TreeSet<String> sortedKeys = new TreeSet<>();
        while (keys.hasMoreElements()) {
            sortedKeys.add((String) keys.nextElement());
        }
        String translationTextFilesPath =
                Paths.get(System.getProperty("user.dir"), "src", "test", "resources", "testdata", "i18n",
                          "translation_" + language + ".txt").toString();
        File file = new File(translationTextFilesPath);
        StringBuilder buffer = new StringBuilder();

        sortedKeys.forEach(keyValue -> {
            String value = dictionary.get((String) properties.get(keyValue));
            buffer.append(keyValue + EQUALS_SIGN + value + ROW_DELIMITER);
        });

        try {
            FileUtils.write(file, buffer.toString(), "UTF8");
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }

    private static String getTextByPattern(String pattern, String textToMatch) {
        String text;
        Pattern patternText = Pattern.compile(pattern);
        Matcher m = patternText.matcher(textToMatch);
        if (m.find()) {
            text = m.group(1);
        } else {
            throw new RuntimeException("Translation file has incorrect structure");
        }
        return text;
    }

}
