package com.refinitiv.asts.test.ui.pageObjects.setUp.questionnaireManagement;

import com.refinitiv.asts.test.ui.pageObjects.BasePO;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import lombok.Getter;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static java.lang.String.format;
import static org.openqa.selenium.By.*;

@Getter
public class QuestionnairePO extends BasePO {

    /**
     * Common
     */
    private final By questionnaireWizard = xpath("(//*[contains(@class, 'MuiPaper-elevation3')])[2]");
    private final String dropDownWithLabel = "//span[contains(.,'%s')]/ancestor::label/following-sibling::div";
    private final String label = "//span[@value='%s']";
    private final String dropDownWithLabelInput = dropDownWithLabel + "//input";
    private final By editButton = xpath("//button[@aria-label='edit-questionnaire']");
    private final By alertIcon = xpath("//*[@class='MuiAlert-message']");
    private final String dropDownItem = "//*[@role='option']//*[text()=\"%s\"]/ancestor::li";
    private final By availableDropDownItem = xpath("//*[@role='option' and not(@aria-disabled)]");
    private final String dropDownListBoxItem =
            "//ul[@role='listbox']//li//div[text()='%s'] | //ul[@role='listbox' or @role='menu']//li[text()='%<s']";
    private final By dropDownValuesList = xpath("//ul[@role='listbox']//li//div");
    private final String buttonWithName = "//span[text()='%s']/..";
    private final By backButton = xpath("//span[text()='Back']/..");
    private final By breadcrumb = xpath("//*[contains(@class, 'MuiBreadcrumbs')]");
    private final By breadcrumbButton = xpath("//*[contains(@class, 'MuiBreadcrumbs')]//button");
    private final String clearDropDownButton =
            "(//*[text()='%s']/../../following-sibling::div//button[@title='Clear'])[last()]";
    private final String inputField = "//*[text()='%s']/ancestor::fieldset/preceding-sibling::input";

    /**
     * Information tab
     */
    private final By infoTab = xpath("//*[text()='Information']/parent::button");
    private final By questionnaireNameLabel = xpath("//*[@name='name']/../../label");
    private final String questionnaireInputLabel = "//*[text()='%s']/../following-sibling::span";
    private final By questionnaireNameInput = name("name");
    private final By questionnaireDescriptionInput = name("description");
    private final By questionnaireHeaderInput = xpath("//*[@contenteditable='true']");
    private final By questionnaireLanguageInput =
            xpath("//label//span[text()=\"" + translator.getValue("questionnaire.language") +
                          "\"]/../../following-sibling::div//input");
    private final By externalRadioButton =
            xpath("//*[text()=\"" + translator.getValue("questionnaire.assigneeType.external") +
                          "\"]/../preceding-sibling::span//input/..");
    private final By internalRadioButton = xpath("//*[text()='Internal']/../preceding-sibling::span//input");
    private final By categoryInputOpenArrow =
            xpath("//*[text()='Questionnaire Category']/../../following-sibling::div//button[@title='Open']");
    private final By categoryInputCloseArrow =
            xpath("//*[text()='Questionnaire Category']/../../following-sibling::div//button[@title='Close']");
    private final By languageInputOpenCloseArrow =
            xpath("//*[text()='Language']/../../following-sibling::div//button[@title='Close' or @title='Open']");
    private final String languageRemoveIcon =
            "//*[text()='Language']/ancestor::label/following-sibling::div//span[text()='%s']/../../following-sibling::*[contains(@class, 'Svg')]";
    private final String languageButton =
            "//*[text()='Language']/ancestor::label/following-sibling::div//span[text()='%s']/../../..";
    private final String froalaButton = "//button[contains(@class, 'fr-') and @data-cmd='%s']";
    private final String froalaOption =
            "//a[@role='option' and contains(@data-cmd,'%s') and (text()='%s' or @title='%<s')]";
    private final By froalaCounter = className("fr-counter");
    private final String headerStrongText = "//*[@class='fr-wrapper']//strong[text()='%s']";
    private final String headerTextWithStyle = "//*[@class='fr-wrapper']//p[text()='%s' and @style='%s']";
    private final By quickInsertButton = xpath("//*[@class='fr-quick-insert fr-visible']");
    private final String quickInsertLink = "//div[@class='fr-qi-helper']/a[@title='%s']";
    private final String tableInsertButton = "//div[@class='fr-buttons']/button[@title='%s']";
    private final String headerContentElement = "//*[@class='fr-wrapper']//%s";
    private final String inputError = "//span[text()='%s']/ancestor::label//following-sibling::p";
    private final By setupInformationSection = xpath("//p[text()='Setup Information']");

    /**
     * View Information tab
     */
    private final By viewQuestionnaireCategory =
            xpath("//*[text()='Questionnaire Category']/../following-sibling::div | //*[text()='Questionnaire Category']/ancestor::label/following-sibling::div/input");
    private final By viewQuestionnaireDescription =
            xpath("//*[text()='Description']/../div | //*[text()='Description']/ancestor::label/following-sibling::div");
    private final By viewQuestionnaireLanguage =
            xpath(format(
                    "//*[text()=\"%s\"]/../following-sibling::div | //*[text()=\"%<s\"]/ancestor::label/following-sibling::div",
                    translator.getValue("questionnaire.language")));
    private final By viewQuestionAssigneeType = xpath("//*[contains(@class, 'Mui-checked')]/..//p");

    /**
     * Reviewers tab
     */
    private final By reviewerTab =
            xpath("//*[text()=\"" + translator.getValue("questionnaire.reviewersTab") + "\"]/parent::button");

    /**
     * Question tab
     */
    private final String tabNameTitle = "(//button[contains(@id,'-T')])[%d]//span/span";
    private final String tabWithName = "//*[text()='%s']/..";
    private final String questionnaireTabWithName = "//*[text()[contains(., '%s')]]/ancestor::button";
    private final String configButtonForQuestion =
            "(//*[@title='Configuration' or contains(@aria-label, 'configure-question')])[%d]";
    private final String questionTabPanel =
            "(//button[@tabindex='0' and @role])[2]/ancestor::div[contains(@class, 'MuiTabs')]/../../following-sibling::div//*[@data-rbd-droppable-id]";
    private final String configButtonForQuestionWithName =
            questionTabPanel +
                    "//*[text()='%s']/../preceding-sibling::div//button[@title='Configuration' or contains(@aria-label, 'configure-question')]";
    private final By addedQuestion = xpath(questionTabPanel + "/div/div[@data-rbd-draggable-context-id]");
    private final By questionTabPanelMessage = xpath(questionTabPanel + "//p");
    private final By questionTabPanelAdditionalMessage = xpath(questionTabPanel + "//span/span");
    private final String questionTab = "//button[@aria-label='question-tab-%s']";
    private final String questionTabName = questionTab + "/span//span/span";
    private final String deleteTabButton = questionTab + "//button[contains(@aria-label, 'delete-question-tab')]";
    private final String editTabButton = questionTab + "//button[not(contains(@aria-label, 'delete-question-tab'))]";
    private final String tabCounter = questionTab + "/span/div/div[1]";
    private final By tabNameInput = xpath("//*[contains(@id, '-T')]//*[@type='text']");
    private final String plusTabIcon =
            "//p[contains(@class, 'MuiTypography')]/..//button[contains(@class, 'MuiIconButton-colorSecondary')]";
    private final By plusTabIconCounter = xpath(plusTabIcon + "/../../p");
    private final String createTabModalHeader = "//*[@role='dialog']//h2[text()='Create Tab']";
    private final String createTabButton = createTabModalHeader + "/../..//span[text()='%s']/ancestor::button";
    private final By createTabRadioButtons =
            xpath(createTabModalHeader + "/../..//input/../../following-sibling::span");
    private final String createTabRadioButton = "//text()[contains(., '%s')]/ancestor::label//input";
    private final String questionType = "//*[text()='%s']/parent::*";
    private final By helpTextFieldInput = xpath("//*[text()='Help Text']/../../following-sibling::div/textarea");
    private final By questionFroalaInput = cssSelector(".fr-element");
    private final String toggle = "//*[text()='%s']//preceding-sibling::*//input";
    private final String toggleDropDown =
            "//*[text()='%s']/ancestor::label/following-sibling::div//span[text()='%s']/ancestor::label/following-sibling::div//input";
    private final By warningMessage = xpath("//*[contains(@class, 'MuiDialogTitle')]/following-sibling::div");
    private final By cancelWarningButton = xpath("//button[@id='simpleModalCancelButton']");
    private final By proceedWarningButton = xpath("//button[@id='simpleModalSuccessButton']");
    private final By questionTypeList = xpath("//*[@data-rbd-droppable-id='pickers']/div");
    private final By questionTabList = xpath("//*[contains(@id,'-T') and @type='button']");
    private final By informationContentQuestionTabList =
            xpath("//*[contains(@id, 'question')]//*[@role='tablist']//button");
    private final By droppedQuestionsList =
            xpath("//*[contains(@id,'-T')]/ancestor::div[contains(@class, 'MuiTabs')]/../..//*[@data-rbd-draggable-id]");
    private final By attachmentLabel = xpath("//*[text()='Attachment']");
    private final By choicesSection = xpath("//*[contains(@class,'qsstStyleContainer MuiGrid-item')]");
    private final By statusCheckbox = xpath("//*[@name='checkbox']");
    private final By mandatoryCheckbox =
            xpath("//label[not(@title) and contains(@class, 'labelPlacementStart')]//*[@name='mandatory']");
    private final By attachmentCheckbox = xpath("//*[@name='attachment']");
    private final By calculateHighestScoreOnlyCheckbox = xpath("//*[@name='isComputeHighScore']");
    private final By approveEditButton = xpath("//*[@title='Save']");
    private final String tabButton = "(//*[contains(@id, 'question')]//*[@role='tablist']//button)[%d]";
    private final String redFlagToggle =
            "//text()[contains(., '%s')]/ancestor-or-self::label/../../following-sibling::div[2]//input[@type='checkbox']";
    private final String choice = "//span[contains(.,'%s')]/ancestor::div[@role='button']";
    private final String choiceNameInput = "//span[contains(.,'%s')]/ancestor::label/following-sibling::div//input";
    private final String choiceNameInputView = "//span[contains(.,'%s')]/ancestor::label/following-sibling::div//span";
    private final String choiceAddButton =
            choiceNameInput +
                    "/../../../..//button[@title='Add' or not(@title='Delete' or @title='Open' or @title='Close')]";
    private final String choiceDeleteButton =
            choiceNameInput +
                    "/../../../..//button[@title='Delete' or not(@title='Add' or @title='Open' or @title='Close')]";
    private final String branchLabel = "//label//span[text()='If Choice Is']";
    private final String ifChoiceIsValue =
            "//span[text()='If Choice Is']/ancestor::label/following-sibling::div//span[text()='%s']";
    private final String branchTabName = ifChoiceIsValue + "/../../../../following-sibling::div[1]//input";
    private final String branchQuestion = ifChoiceIsValue + "/../../../../following-sibling::div[2]//input";
    private final String branchQuestionTabName =
            "//*[@value='%s']/../preceding-sibling::label//text()[contains(., 'If Choice Is')]" +
                    "/ancestor-or-self::label/../../following-sibling::div[1]//input";
    private final String branchQuestionName =
            "//*[@value='%s']/../preceding-sibling::label//text()[contains(., 'If Choice Is')]" +
                    "/ancestor-or-self::label/../../following-sibling::div[2]//input";
    private final By mappingButton =
            xpath("//button[@title='Mapping' or contains(@aria-label, 'map-question')]");
    private final By groupsField = xpath("//span[text()='Groups']/ancestor::label/following-sibling::div/input " +
                                                 "| //*[@id='QuestionDataMapping-GroupSelectInput']");
    private final String scoreInput = "//span[contains(.,'%s')]/ancestor::label/../../..//input[@name='score']";
    private final String typeInput =
            "//span[contains(.,'%s')]/ancestor::label/../../..//input[@aria-autocomplete='list']";
    private final String typeInputView =
            "//span[contains(.,'%s')]/ancestor::label/../../following-sibling::div//p/span";
    private final String qID = "(//p[contains(text(), 'QID')])[%s]";
    private final String questionMainArea = "//*[@role='tabpanel']//*[contains(text(), 'QID')]/../../..";
    private final String questionConfigArea = questionMainArea + "/following-sibling::div";
    private final By questionConfigAreaChoicesText = xpath(questionConfigArea + "/p");
    private final String questionConfigAreaSubQuestionValues = questionConfigArea + "/p";
    private final String questionConfigAreaChoicesButton = questionConfigArea + "/span[text()='%s']";
    private final String questionButton = questionMainArea + "//span[text()='%s']";
    private final String questionName = "(" + questionMainArea + "/div/p)[%s]";
    private final By questionOptions = xpath(questionMainArea + "//*[contains(@class, 'Svg')]/following-sibling::p");
    private final By questionFields =
            xpath(questionMainArea + "//div/*[@type='text' or @data-cid='TextEllipsis-root']/span");
    private final By questionConfigFields = xpath(questionMainArea + "//span[@type='text']/span");
    private final By questionConfigTitle = xpath(questionConfigArea + "//p");
    private final String deleteButtonForQuestion =
            "(" + questionMainArea + "//*[@title='Delete' or contains(@aria-label, 'delete-question')])[%d]";
    private final String mappingButtonForQuestion =
            "(" + questionMainArea + "//*[@title='Mapping' or contains(@aria-label, 'map-question')])[%d]";
    private final By choicesLabel = xpath("//*[@name='value' or @name='title']/../../label");
    private final By addButton = xpath("(//button[@title='Add'])[last()]");
    private final String addBulkChoicesModal = "//h2[contains(text(), 'Bulk Choices')]/ancestor::div[@role='dialog']";
    private final By addBulkChoicesModalHeader = xpath(addBulkChoicesModal + "//h2");
    private final By addBulkChoicesModalInstruction =
            xpath(addBulkChoicesModal + "//div[contains(@class, 'MuiDialogContent')]");
    private final String addBulkChoicesButton = addBulkChoicesModal + "//span[text()='%s']/ancestor::button";
    private final By addBulkChoicesInput = xpath(addBulkChoicesModal + "//textarea");
    private final By useType = xpath("//*[@role='tabpanel']/div/div/span");
    private final By clearMappingButton = cssSelector("[aria-label='clear-mapping']");
    private final String qidLabel = "//p[contains(text(), 'QID')]/following-sibling::div/span[text()='%s']";
    private final By mappingDataSections = xpath("//p[text()='Map To']/..//p");
    private final By mapToSection = xpath("//*[text()='Map To']/ancestor::label/following-sibling::div");
    private final By mappingQuestionTitle =
            xpath("//*[@name='title'] | //p/parent::div[contains(@class, 'MuiGrid')]/parent::*//span[@type='text']");
    private final String mappingQuestionTitlesForPartType =
            "//*[text()[contains(., '%s')]]/ancestor::div[contains(@class, 'MuiGrid-container') " +
                    "and not(contains(@class, 'spacing'))]//p/parent::div[contains(@class, 'MuiGrid')]/parent::*//span[@type='text']";
    private final String mappingConfigSubQuestionsPartType = "//*[text()='%s']/parent::*//input[@name='title']";
    private final By reviewMappingRequired = cssSelector("[name='reviewMappingRequired']");
    private final String mappingField = "//*[@value='%s']/../../../following-sibling::div//span[text()='%<s']";
    private final By autoScreenToggle = cssSelector("[name='autoScreen']");
    private final By currencyTextField = xpath(format(dropDownWithLabel, "Currency") +
                                                       "/../../../..//span[text()='']/ancestor::label/following-sibling::div/span");
    private final By questionCounter = xpath(questionMainArea + "/p[contains(@class, 'paragraph')]");
    private final By selectedTabQuestionCounter = xpath("//button[@aria-selected='true']/span/div/div[1]");
    private final String addFieldModalCheckbox = "//div[@role='dialog']//*[text()='%s']/ancestor::label//input";
    private final String addFieldModalButton = "//div[@role='dialog']//*[text()='%s']/ancestor::button";
    private final By modalHeader = xpath("//div[@role='dialog']//h2");
    private final String partTypeCheckbox = questionConfigArea + "//span[text()='%s']/preceding-sibling::span";
    private final String addFieldForPartType = "//*[text()[contains(., '%s')]]/ancestor::div[contains(@class," +
            " 'MuiGrid-container') and not(contains(@class, 'spacing'))]//span[text()='Add field']/..";
    private final String addSubQuestionForPartTypeIcon = "//*[text()='%s']/parent::*//*[text()='%s']" +
            "/ancestor::*[@role='button']//button[contains(@class, 'MuiIconButton-colorSecondary')]";

    /**
     * Scoring tab
     */
    private final By scoringTab = xpath("//*[text()='Scoring']/parent::button");
    private final String scoreRowWithName = "//*[contains(@id,'scoring')]//td//*[text()='%s']";
    private final String scoreRowWithNameRiskScore =
            "//*[contains(@id,'scoring')]//td//*[text()='%s']/../../following-sibling::td";
    private final By scoringMessage = xpath("//*[contains(@id,'scoring')]//p");
    private final By scoringRangeMessage = xpath("//*[contains(@id,'scoring')]//div[contains(@class, 'MuiBox')][2]");
    private final String deleteScoreButton = "//button[@title='Delete'][%s] | (//tr[%<s]//button)[2]";
    private final String editScoreButton = "//button[@title='Edit'][%s] | (//tr[%<s]//button)[1]";
    private final By scoringNameInput = xpath("//input[@name='scoreName']");
    private final By scoringMinRange = xpath("//input[@name='minScore']");
    private final By scoringMaxRange = xpath("//input[@name='maxScore']");
    private final By levelOfReviewer = xpath("//input[@name='levelOfReviewer']");
    private final By scoringLevelOfReviewer = xpath("//*[@aria-label='scoring-level-of-reviewer']");
    private final By addScoringButton = xpath("//*[text()='Add Scoring Scheme']/parent::button");
    private final By scoreName = xpath("td[1]");
    private final By scoreRange = xpath("td[2]");
    private final By scoreLevel = xpath("td[3]");

    public QuestionnairePO(WebDriver driver, LanguageConfig translator) {
        super(driver, translator);
    }

}
