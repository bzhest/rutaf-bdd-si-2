package com.refinitiv.asts.test.ui.pageActions;

import com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.WorkflowHistoryPage;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

import static com.refinitiv.asts.test.utils.FileUtil.waitFileToDownload;

public class FilePage extends BasePage<WorkflowHistoryPage> {

    public FilePage(WebDriver driver) {
        super(driver);
    }

    @Override
    protected ExpectedCondition<WorkflowHistoryPage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return false;
    }

    @Override
    public void load() {

    }

    public void waitForFileToDownload(String fileName) {
        waitLong.until(waitFileToDownload(fileName));
    }

}
