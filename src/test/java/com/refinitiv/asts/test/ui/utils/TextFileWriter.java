package com.refinitiv.asts.test.ui.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import java.lang.invoke.MethodHandles;

public class TextFileWriter {

    private String fqFilename;
    private final static Logger LOGGER = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    public TextFileWriter() {
    }

    public void writeToFile(String fqFilename, String text) throws IOException {

        this.fqFilename = fqFilename;
        File file = new File(this.fqFilename);
        if (file.createNewFile()) {
            LOGGER.info("File '" + this.fqFilename + "' successfully created.");
        } else {
            LOGGER.info("File '" + this.fqFilename + "' already exists.");
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
            bw.append(text);
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void writeToFileObject(String fqFilename, String text) throws IOException {

        this.fqFilename = fqFilename;
        File file = new File(this.fqFilename);
        if (file.createNewFile()) {
            LOGGER.info("File '" + this.fqFilename + "' successfully created.");
        } else {
            LOGGER.info("File '" + this.fqFilename + "' already exists.");
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
            bw.append(text.substring(1, text.length() - 1));
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        }
    }

}
