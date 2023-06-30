package com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.apache.commons.text.CaseUtils.toCamelCase;
import static org.openqa.selenium.By.*;

@Getter
public class UserPO extends BasePO {

    private final By userManagementLabel = xpath("//h6[text()='User Management']");
    private final By addNewUserButton = id("add-new-" + translator.getValue("user.user"));
    private final By addUserPage =
            xpath("//*[contains(@class, 'MuiBreadcrumbs')]//*[text()=\"" +
                          toCamelCase(translator.getValue("user.user"), true) + "\"]");
    private final By userOverviewPageEditButton =
            xpath("//button[@title='" + translator.getValue("user.editButton") + "']");
    private final By userPageSubmitButton = id("user-management-user-submit");
    private final By userPageUserTypeInput =
            xpath("//span[contains(., \"" + translator.getValue("user.userType") +
                          "\")]/../following-sibling::div//input");
    private final By tableColumnHeader = xpath("//thead//th");
    private final By backUserManagementButton = id("users-management-user-back-button");
    private final By
            usersNameColumn = xpath("//h6[text()='User Management']/..//table/thead/tr//span[text()='User Name']");
    private final By usersTableRows = xpath("//tbody/tr");
    private final String userInputFieldSpan = "//label//span[text()=\"%s\"]";
    private final String userInputField = userInputFieldSpan +
            "/ancestor::label/following-sibling::*//input | //label/span[contains(.,\"%<s\")]/../..//input";
    private final String userInputFieldButton = userInputFieldSpan +
            "/ancestor::label/following-sibling::*//button[@title='Open' or @title='Close']";
    private final By noRecordResults =
            xpath("(//h4[text()='User Management']/ancestor::div[@class='right-panel']//h4)[4] | //h6[contains(text(), 'Management')]/following-sibling::div//h6");
    private final By enableSingleSignOnCheckbox = xpath("//input[@name='isSingleSignOnEnabled']");
    private final By enableSingleSignOnCheckboxButton = xpath("//input[@name='isSingleSignOnEnabled']/..");
    private final String activeCheckbox = "//input[@name='active']";
    private final By activeCheckboxSpan = xpath(activeCheckbox + "/../..");
    private final By externalOrganisationLabel =
            xpath("//div/preceding-sibling::span/descendant-or-self::*[text()='External Organisation']");
    private final By externalOrganisationValue =
            xpath("//span[contains(text(), 'External')]/../..//input | //span[text()='External Organisation']/ancestor-or-self::span/following-sibling::div//span");
    private final String userTableRowValue = "//tbody/tr[%s]/td[%s]";
    private final String editRowButton =
            "//td/span[contains(., '%s')]/ancestor::tr//*[@aria-label='edit-" + translator.getValue("user.user") +
                    "']";
    private final String userRowFirstName = "//td[2]//span[contains(., \"%s\")]";
    private final String userRowUserName = "//td[4]//span[contains(., '%s')]";
    private final String userOverviewField =
            "//span[text()=\"%s\"]/ancestor::label/following-sibling::div[1] | //span[text()=\"%<s\"]/ancestor-or-self::span/following-sibling::div[1]";
    private final String usersTableColumn = "//thead//*[text()='%s']/../../span";
    private final String usersTableRow = "//tbody//tr[%s]/td[2]";
    private final String editButtonForRow =
            "//tbody//tr[%s]//*[@aria-label='edit-" + translator.getValue("user.user") + "']/..";
    private final String divisionDeleteButtonList =
            "//span[text()=\"" + translator.getValue("user.division") +
                    "\"]/../../div/div/span/following-sibling::*[contains(@class, 'Svg')]";
    private final By firstDivisionDeleteButton = xpath(divisionDeleteButtonList + "[1]");
    private final String rowThirdParty = "//span[text()='%s']/ancestor::tr//td[5]";
    private final By cancelButton = xpath("//*[text()='Cancel']/ancestor::button");
    private final String requiredIndicator = "//label/span[contains(., '%s')]/following-sibling::span[text()='*']";
    private final By notice =
            xpath("(//*[@id='user-management-user-cancel']/../../preceding-sibling::div/p)[last()]");
    private final String section = "//p[text()='%s']";
    private final By userTypeInput = xpath("//*[@name='userType']");
    private final By username = xpath("//*[@name='username']");
    private final By organisation = xpath("//*[@name='organization']");
    private final By deactivateButton = id("user-deactivate-users");
    private final String rowCheckbox = "//tr[%s]/td//input[@type='checkbox']";
    private final By oooNotice = xpath("(//nav/following-sibling::div//p)[1]");
    private final By statusIcon =
            xpath("//span[text()='Status']/ancestor::div/following-sibling::*[contains(@class, 'Svg')]");
    private final String calendarButton =
            userInputFieldSpan + "/ancestor::label/following-sibling::div//button[@aria-label='[object Object]']";
    private final By timeButton =
            xpath("//label/span[contains(.,'Time')]/../following-sibling::div//button[@aria-label='[object Object]']");
    private final By statusInput = id("OOOStatus");
    private final By historyMessage =
            xpath("//p[text()='History']/ancestor::div[@role='button']/following-sibling::div//h6");

    public UserPO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

}