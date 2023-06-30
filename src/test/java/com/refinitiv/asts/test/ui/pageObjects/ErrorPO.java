package com.refinitiv.asts.test.ui.pageObjects;

import lombok.Data;
import org.openqa.selenium.By;

import static org.openqa.selenium.By.xpath;

@Data
public class ErrorPO {

    private final By errorPage = xpath("//*[@class='error-content align-center']");
    private final By errorPageText = xpath("//*[@class='error-content align-center']//*[@class='row']");
    private final By errorPageLink = xpath("//a[@class='refinitiv_blue']");

}
