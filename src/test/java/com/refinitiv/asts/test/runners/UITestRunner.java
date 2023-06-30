package com.refinitiv.asts.test.runners;

import com.refinitiv.asts.core.framework.enums.EnvironmentType;
import com.refinitiv.asts.core.managers.FileReaderManager;
import com.refinitiv.asts.core.managers.GridManager;
import com.refinitiv.asts.test.ui.api.ApiClient;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import net.masterthought.cucumber.json.support.Status;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.testng.ITestContext;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.xml.XmlSuite;

import java.io.File;
import java.lang.invoke.MethodHandles;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@CucumberOptions(
        features = {"src/test/resources/features/"},
        tags = "@ui and not @ignore",
        glue = {"com.refinitiv.asts.test.ui.stepDefinitions", "com.refinitiv.asts.test.api.stepDefinitions"},
        plugin = {"pretty", "html:target/site/cucumber-pretty",
                "json:target/jsonreports/cucumber.json",
                "com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:", "summary"})

public class UITestRunner extends CucumberParallelExecutor {

}

class CucumberParallelExecutor extends AbstractTestNGCucumberTests {

    private static final Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    private String threadCount = System.getProperty("threadCount", "1");

    @BeforeClass(alwaysRun = true)
    public void setUpClass(ITestContext context) {
        //Set the threadCount here for parallelization
        logger.info("Before Class of TestNG runner is initiated which will always run before the Cucumber runner");

        //If environmentType is REMOTE, the no of threads should change as per the no.of nodes given
        if (FileReaderManager.getInstance().getConfigReader().getEnvironment().equals(EnvironmentType.REMOTE)) {
            GridManager.createInstance().startHub();
            threadCount = String.valueOf(FileReaderManager.getInstance().getConfigReader().getNodes());
        }
        if (FileReaderManager.getInstance().getConfigReader().isParalleForUITests()) {
            context.getCurrentXmlTest().getSuite().setParallel(XmlSuite.ParallelMode.CLASSES);
            context.getCurrentXmlTest().getSuite().setDataProviderThreadCount(Integer.parseInt(threadCount));
        } else {
            context.getCurrentXmlTest().getSuite().setParallel(XmlSuite.ParallelMode.NONE);
        }
        new ApiClient().setUp();
        logger.info("Set the testNG data provider thread count to " + threadCount);
        super.setUpClass();
    }

    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {
        return super.scenarios();
    }

    @AfterSuite(alwaysRun = true)
    public void afterAllCleanUp() {
        generateReport();
    }

    public void generateReport() {
        File reportOutputDirectory = new File("target");
        List<String> jsonFiles = new ArrayList<>();
        jsonFiles.add("target/jsonreports/cucumber.json");
        String buildNumber = "1";
        String projectName = "RDDC Automation";

        Configuration configuration = new Configuration(reportOutputDirectory, projectName);
        // do not make scenario failed when step has status SKIPPED
        configuration.setNotFailingStatuses(Collections.singleton(Status.SKIPPED));
        configuration.setBuildNumber(buildNumber);
        // additional metadata presented on main page
        configuration.addClassifications("Platform", System.getProperty("os.name"));
        configuration.addClassifications("Browser", "Chrome");
        configuration.addClassifications("Branch", "Release/1.0");
        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        reportBuilder.generateReports();
    }

}



