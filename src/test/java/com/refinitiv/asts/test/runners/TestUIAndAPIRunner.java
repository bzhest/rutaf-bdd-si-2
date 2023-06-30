package com.refinitiv.asts.test.runners;

import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
        features = {"src/test/resources/features"},
        tags = "@demo",
        glue = {"com.refinitiv.asts.test.stepDefinition"},
        plugin = {"pretty",
                "json:target/jsonreports/cucumber.json"})
public class TestUIAndAPIRunner {

}


