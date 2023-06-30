package com.refinitiv.asts.test.api.stepDefinitions.riskscoringengine;

import org.testng.asserts.Assertion;
import org.testng.asserts.IAssert;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class RiskScoringEngineApiAssertion extends Assertion {

    private Map<AssertionError, IAssert> errorsMap = new LinkedHashMap<>();
    private List<String> errorInterations;

    public void setErrorInterations(List<String> errInterations) {
        this.errorInterations = errInterations;
    }

    @Override
    public void executeAssert(IAssert iAssert) {
        try {
            iAssert.doAssert();
        } catch (AssertionError aex) {
            onAssertFailure(iAssert, aex);
            this.errorsMap.put(aex, iAssert);
        }
    }

    public void assertAll() {
        if (!this.errorsMap.isEmpty()) {
            StringBuilder sb = new StringBuilder("The following asserts FAILED: ");
            boolean isFirst = true;
            for (Map.Entry<AssertionError, IAssert> assertionErrorsEntry : errorsMap.entrySet()) {
                if (isFirst) {
                    isFirst = false;
                } else {
                    sb.append(" | ");
                }
                sb.append(assertionErrorsEntry.getKey().getMessage());
            }
            throw new AssertionError(sb.toString());
        }
    }

}
