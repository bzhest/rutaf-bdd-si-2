package com.refinitiv.asts.test.ui.utils;

import org.awaitility.Awaitility;
import org.awaitility.core.ConditionFactory;

import java.util.concurrent.TimeUnit;

import static java.lang.String.format;

public class AwaitUtil {

    public static ConditionFactory await(String entity, int timeOut, int pullInterval) {
        return Awaitility.await(format("Wait for appearance the entity: %s", entity))
                .atMost(timeOut, TimeUnit.SECONDS).pollInterval(pullInterval, TimeUnit.SECONDS);
    }

    public static ConditionFactory await(String entity, int timeOut, int pullInterval, int pollDelay) {
        return await(entity, timeOut, pullInterval).pollDelay(pollDelay, TimeUnit.SECONDS);
    }

}
