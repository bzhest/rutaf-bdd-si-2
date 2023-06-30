package com.refinitiv.asts.test.utils;

import com.opencsv.*;
import com.opencsv.exceptions.CsvException;
import com.refinitiv.asts.core.managers.FileReaderManager;
import lombok.SneakyThrows;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.io.*;
import java.lang.invoke.MethodHandles;
import java.util.*;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.TestConstants.CHAR_VERTICAL_BAR;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CUSTOM_FIELD_NAME;
import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.LF;

public class FileUtil {

    private final static Logger LOGGER = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private final static String DOWNLOADED_DIR = System.getProperty("user.dir") + "/";
    private final static String DELIMITER = System.getProperty("file.separator");
    private final static String UI = "ui";
    private final static String FILES_FOLDER = "filesForUpload";
    private final static String API_REST_ASSURED = "apiRestAssured";
    private final static String THIRD_PARTY_ID = "Third-party ID";
    public final static String PDF = ".pdf";

    @SneakyThrows
    public static File getCreatedFile(String fileName) {
        File file = new File(fileName);
        if (file.createNewFile()) {
            LOGGER.info(fileName + " successfully created");
        } else {
            LOGGER.info(fileName + " file is already exist");
        }
        return file;
    }

    @SneakyThrows
    public static List<List<String>> readCSVFile(File file) {
        List<List<String>> parsedRecords = new ArrayList<>();
        if (file == null) {
            throw new RuntimeException("File is not found");
        }
        CSVReader csvReader = new CSVReader(new FileReader(file));
        String[] records;
        while ((records = csvReader.readNext()) != null) {
            parsedRecords.add(Arrays.asList(records));
        }
        return parsedRecords;
    }

    @SneakyThrows
    public static List<List<String>> readExcelFile(File file) {
        InputStream fileInputStream = new FileInputStream(file);
        List<List<String>> tableList = new ArrayList<>();
        XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);
        XSSFSheet sheet = workbook.getSheetAt(0);
        for (Row row : sheet) {
            List<String> rowList = new ArrayList<>();
            for (int i = 0; i < row.getLastCellNum(); i++) {
                Cell cell = row.getCell(i, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                switch (cell.getCellType()) {
                    case STRING:
                    case BLANK:
                        rowList.add(cell.getStringCellValue());
                        break;
                    case NUMERIC:
                        rowList.add(Double.toString(cell.getNumericCellValue()));
                        break;
                }
            }
            tableList.add(rowList);
        }
        fileInputStream.close();
        return tableList;
    }

    public static File getLastDownloadedFile() {
        File downloadDirectory = new File(System.getProperty("user.dir"));
        if (downloadDirectory.length() == 0) {
            return null;
        }

        File[] filesList = downloadDirectory.listFiles();
        if (Objects.requireNonNull(filesList).length == 0) {
            throw new RuntimeException("No files in directory " + downloadDirectory.getPath());
        }
        LOGGER.info(format("Download directory %s files are %s", downloadDirectory.getPath(),
                           Arrays.stream(filesList).map(File::getName).collect(Collectors.joining(LF))));

        return Arrays.stream(Objects.requireNonNull(filesList))
                .filter(File::isFile)
                .filter(file -> !StringUtils.endsWith(file.getPath(), ".log"))
                .filter(file -> !file.getPath().contains(downloadDirectory.getPath() + "/."))
                .max(Comparator.comparingLong(File::lastModified))
                .orElseThrow(() -> new RuntimeException("File not found"));
    }

    @SneakyThrows
    public static String getBase64EncodedFile(String filePath) {
        String path = FileReaderManager.getInstance().getConfigReader().getTestDataResourcePath() + filePath;
        File file = new File(path);
        FileInputStream fileInputStreamReader = new FileInputStream(file);
        byte[] bytes = new byte[(int) file.length()];
        fileInputStreamReader.read(bytes);
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static ExpectedCondition<Boolean> waitFileToDownload(String fileName) {
        return new ExpectedCondition<>() {
            public Boolean apply(WebDriver driver) {
                File file = new File(DOWNLOADED_DIR + fileName);
                return file.exists();
            }

            public String toString() {
                return format("%s file to be present within the time specified", DOWNLOADED_DIR + fileName);
            }
        };
    }

    public static void deleteDownloadedFile(String fileName) {
        File file = new File(DOWNLOADED_DIR + fileName);
        if (file.delete()) {
            LOGGER.info(format("%s File deleted successfully", fileName));
        } else {
            LOGGER.info(format("Failed to delete the file %s", fileName));
        }
    }

    @SneakyThrows
    public static String readDownloadedPdfFile(String fileName) {
        PDDocument document = PDDocument.load(new File(DOWNLOADED_DIR + fileName));
        PDFTextStripper stripper = new PDFTextStripper();
        String output = stripper.getText(document);
        if (document != null) {
            document.close();
        }
        return output;
    }

    public static String getFilePath(String fileName) {
        String filePath = System.getProperty("user.dir") + DELIMITER +
                FileReaderManager.getInstance().getConfigReader().getTestDataResourcePath() + DELIMITER + UI +
                DELIMITER + FILES_FOLDER + DELIMITER + fileName;
        LOGGER.info("Upload File path: " + filePath);
        return filePath;
    }

    public static String getAPIFilePath(String folder, String fileName) {
        String filePath = System.getProperty("user.dir") + DELIMITER +
                FileReaderManager.getInstance().getConfigReader().getTestDataResourcePath() + DELIMITER +
                API_REST_ASSURED + DELIMITER + folder + DELIMITER + fileName;
        LOGGER.info("File path: " + filePath);
        return filePath;
    }

    public static String readDataFileContentAsString(String fullFilePath) {
        LOGGER.info("Full filePath = '" + fullFilePath + "'");
        StringBuilder stringBuilder = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new FileReader(fullFilePath))) {
            String currentLine;
            while ((currentLine = br.readLine()) != null) {
                stringBuilder.append(currentLine).append("\n");
            }
        } catch (IOException iox) {
            iox.printStackTrace();
        }
        return stringBuilder.toString();
    }

    public static void writeStringAsDataFileContent(String fullFilePath, String fileContent) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(fullFilePath))) {
            bw.write(fileContent);
        } catch (IOException iox) {
            iox.printStackTrace();
        }
    }

    public static void writeStringAsDataFileContent(String fullFilePath, String fileContent, boolean isAppend) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(fullFilePath, isAppend))) {
            bw.write(fileContent);
        } catch (IOException iox) {
            iox.printStackTrace();
        }
    }

    public static void deleteFile(File file) {
        if (file.delete()) {
            LOGGER.info(format("%s File deleted successfully", file.getName()));
        } else {
            LOGGER.info(format("Failed to delete the file %s", file.getName()));
        }
    }

    public static void deleteFile(String filePath) {
        File file = new File(filePath);
        deleteFile(file);
    }

    @SneakyThrows
    public static List<String[]> getCsvFileContentWithUpdatedValues(String fileName, int lineNumber, String value,
            String valueType) {
        String filePath = FileUtil.getFilePath(fileName);
        CSVParser csvParser = new CSVParserBuilder().withSeparator(CHAR_VERTICAL_BAR).build();
        FileReader fileReader = new FileReader(filePath);
        try (CSVReader csvReader = new CSVReaderBuilder(fileReader).withCSVParser(csvParser).build()) {
            List<String[]> fileAsList = csvReader.readAll();
            int columnNumber;
            switch (valueType) {
                case THIRD_PARTY_ID:
                    columnNumber = 1;
                    break;
                case CUSTOM_FIELD_NAME:
                    columnNumber = 45;
                    break;
                default:
                    throw new IllegalArgumentException("Value Type is unknown");
            }
            fileAsList.get(lineNumber - 1)[columnNumber] = value;
            return fileAsList;
        } catch (CsvException e) {
            throw new RuntimeException(e);
        }
    }

    @SneakyThrows
    public static void updateCsvFileContent(List<String[]> contentToUpdate, String fileName) {
        String filePath = FileUtil.getFilePath(fileName);
        FileWriter fileWriter = new FileWriter(filePath);
        try (CSVWriter csvWriter = new CSVWriter(fileWriter, CHAR_VERTICAL_BAR,
                                                 CSVWriter.NO_QUOTE_CHARACTER, CSVWriter.DEFAULT_ESCAPE_CHARACTER,
                                                 CSVWriter.DEFAULT_LINE_END)) {
            csvWriter.writeAll(contentToUpdate);
        }
    }

}
