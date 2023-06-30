package com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.openqa.selenium.By.*;

@Getter
public class GroupTablePO extends BasePO {

    public GroupTablePO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

    private final By addNewGroupButton = id("users-management-add-new-group");
    private final By deactivateButton = id("users-management-deactivate-groups");
    private final By userSearchInput = id("users-management-set-up-search-input");
    private final String groupTableRowValue = "//span[contains(., '%s')]/ancestor::tr//td[%s]";
    private final By iconsEdit = cssSelector("[title='Edit']");
    private final By iconsDelete = cssSelector("[title='Delete']");
    private final String groupNameInTable = "//td[2]//span[text()[contains(., \"%s\")]]";
    private final String groupIcon = groupNameInTable + "/ancestor::tr//*[@title='%s']";
    private final String groupCheckbox = groupNameInTable + "/ancestor::tr//input";
    private final String groupCheckboxSpan = groupCheckbox + "/../..";
    private final String groupStatus = groupNameInTable + "/ancestor::tr/td[6]";
    private final By groupTableColumnNames = xpath("//tr/th/span/span[@data-cid='TextEllipsis-root']");
    private final By rowInTable = xpath("//tbody/tr");
    private final String pageHeader = "//h6[text()=\"" + translator.getValue("groups.groupManagement") + "\"]";
    private final By userGroupsTableList = xpath(pageHeader + "/..//table");
    private final By noMatchFound = xpath(pageHeader + "/following-sibling::div//h6[text()='No match found']");

}