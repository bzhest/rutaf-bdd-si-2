package com.refinitiv.asts.test.ui.utils;

import com.refinitiv.asts.core.managers.FileReaderManager;
import com.refinitiv.asts.test.ui.api.ApiClient;
import lombok.SneakyThrows;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import ru.yandex.qatools.ashot.AShot;
import ru.yandex.qatools.ashot.Screenshot;
import ru.yandex.qatools.ashot.comparison.ImageDiff;
import ru.yandex.qatools.ashot.comparison.ImageDiffer;
import ru.yandex.qatools.ashot.coordinates.WebDriverCoordsProvider;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.lang.invoke.MethodHandles;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;

import static com.refinitiv.asts.core.framework.drivers.DriverFactory.getDriver;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DEVICE_PIXEL_RATIO;
import static java.lang.String.format;
import static ru.yandex.qatools.ashot.shooting.ShootingStrategies.scaling;
import static ru.yandex.qatools.ashot.shooting.ShootingStrategies.viewportPasting;

public class ImageUtil {

    private final static String standardImageFolder = "img";
    private final static String diffImageFolder = "imgDiff";
    private final static String slash = "/";
    private final static String dot = ".";
    private final static String png = "png";
    private final static String pathFromRout =
            FileReaderManager.getInstance().getConfigReader().getTestDataResourcePath();
    private static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());

    @SneakyThrows
    public static boolean isImageCorrect(String filePath, String imageName, WebElement imageWebElement) {
        String path = format(pathFromRout + filePath, imageName);
        return isImageCorrect(getExpectedScreenshot(path), getActualScreenshot(imageWebElement),
                              generateDifferencesFile(filePath, imageName));
    }

    @SneakyThrows
    public static boolean isDownloadedImageCorrect(String filePath, String imageName, WebElement imageWebElement) {
        String path = format(pathFromRout + filePath, imageName);
        return isImageCorrect(getExpectedScreenshot(path), getImageFromUrl(imageWebElement),
                              generateDifferencesFile(filePath, imageName));
    }

    public static ImageDiff compareBufferedImages(BufferedImage actualImage, BufferedImage expectedImage) {
        ImageDiffer imgDiff = new ImageDiffer();
        return imgDiff.makeDiff(actualImage, expectedImage).withDiffSizeTrigger(10000);
    }

    @SneakyThrows
    public static Boolean isImageEqualsStandard(ImageDiff diffInActualAndExpectedImages, File fileWithDifferences) {
        logger.info("Images difference size: " + diffInActualAndExpectedImages.getDiffSize());
        if (diffInActualAndExpectedImages.hasDiff()) {
            ImageIO.write(diffInActualAndExpectedImages.getMarkedImage(), png, fileWithDifferences);
            return false;
        } else {
            return true;
        }
    }

    private static BufferedImage getActualScreenshot(WebElement image) {
        /*
         * devicePixelRatio could be retrieved by executing command in devTool console 'window.devicePixelRatio;'
         */
        Number devicePixelRatio = (Number) ((JavascriptExecutor) getDriver()).executeScript(DEVICE_PIXEL_RATIO);
        logger.info("Device Pixel Ratio is: " + devicePixelRatio);
        Screenshot screenshot = new AShot().coordsProvider(new WebDriverCoordsProvider())
                .shootingStrategy(viewportPasting(scaling(devicePixelRatio.floatValue()), 1000))
                .takeScreenshot(getDriver(), image);
        return screenshot.getImage();
    }

    @SneakyThrows
    private static BufferedImage getExpectedScreenshot(String fileImagePath) {
        return ImageIO.read(new File(fileImagePath));
    }

    @SneakyThrows
    private static File generateDifferencesFile(String filePath, String imageName) {
        String pathToFolderWithImages = StringUtils.substringBefore(filePath, slash + standardImageFolder);
        String diffFolder = pathFromRout + pathToFolderWithImages + slash + diffImageFolder + slash;
        if (!new File(diffFolder).exists()) {
            boolean isNewDir = new File(diffFolder).mkdir();
            if (isNewDir) {
                logger.info("New imgDiff directory is created!");
            }
        }
        String fileToWriteDifferences = diffFolder + imageName + dot + png;
        File fileWithDifferences = new File(fileToWriteDifferences);
        Files.deleteIfExists(fileWithDifferences.toPath());
        return fileWithDifferences;
    }

    @SneakyThrows
    public static BufferedImage getImageFromUrl(WebElement image) {
        String imageSource = image.getAttribute("src");
        URL imageUrl = new URL(imageSource);
        HttpURLConnection connection = (HttpURLConnection) imageUrl.openConnection();
        connection.setRequestProperty("cookie", ApiClient.getCookies());
        return ImageIO.read(connection.getInputStream());
    }

    @SneakyThrows
    private static boolean isImageCorrect(BufferedImage expectedImage, BufferedImage actualImage,
            File differencesFile) {
        logger.info("Actual Image: " + actualImage.toString());
        logger.info("Expected Image: " + expectedImage.toString());
        ImageDiff diffInActualAndExpectedImages = compareBufferedImages(actualImage, expectedImage);
        return isImageEqualsStandard(diffInActualAndExpectedImages, differencesFile);
    }

}


