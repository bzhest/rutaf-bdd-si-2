package com.refinitiv.asts.test.ui.api.model.fieldsManagement.thirdPartyFields;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class FieldStates {

    boolean configurable;
    boolean active;
    boolean required;

    public static FieldStates setRequired() {
        return new FieldStates().setConfigurable(true).setActive(true).setRequired(true);
    }

    public static FieldStates unsetRequired() {
        return new FieldStates().setConfigurable(true).setActive(true).setRequired(false);
    }

    public static FieldStates unsetActive() {
        return new FieldStates().setConfigurable(true).setActive(false).setRequired(false);
    }

    public static FieldStates setDefaultRequired() {
        return new FieldStates().setConfigurable(false).setActive(true).setRequired(true);
    }



}
