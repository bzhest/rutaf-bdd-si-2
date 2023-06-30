package com.refinitiv.asts.test.api.stepDefinitions;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.lang.invoke.MethodHandles;

public class ApiBaseSteps {

    protected final static Logger logger = LogManager.getLogger(MethodHandles.lookup().lookupClass().getName());
    protected ScenarioCtxtWrapper context;

    protected ApiBaseSteps(ScenarioCtxtWrapper context) {
        this.context = context;
    }

}
