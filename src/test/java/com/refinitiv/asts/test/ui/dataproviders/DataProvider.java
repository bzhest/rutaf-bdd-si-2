package com.refinitiv.asts.test.ui.dataproviders;

import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.CustomFieldData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.GroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MessageManagementData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MyOrganisation;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.QuestionnaireData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserRoleData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.countryChecklist.CountryChecklistData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessDataAPI;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowActivityData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowGroupData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement.WorkflowReviewerApproverData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.*;
import lombok.Getter;

@Getter
public enum DataProvider {

    THIRD_PARTY(ThirdPartyData.class, "ui/thirdParty/thirdParty.json"),
    REVIEW_PROCESS(ReviewProcessData.class, "ui/setUp/reviewProcess/reviewProcess.json"),
    REVIEW_PROCESS_API(ReviewProcessDataAPI.class, "ui/setUp/reviewProcess/reviewProcessAPI.json"),
    ASSOCIATED_PARTY_INDIVIDUAL(AssociatedPartyIndividualData.class, "ui/thirdParty/associatedPartyIndividual.json"),
    ASSOCIATED_PARTY_ORGANISATION(AssociatedPartyOrganisationData.class,
                                  "ui/thirdParty/associatedPartyOrganisation.json"),
    OTHER_NAME(OtherName.class, "ui/thirdParty/otherName.json"),
    KEY_PRINCIPLE(KeyPrincipleData.class, "ui/thirdParty/keyPrinciple.json"),
    WORKFLOW_GROUPS(WorkflowGroupData.class, "ui/setUp/workflowManagement/workflowGroups.json"),
    WORKFLOW_MANAGEMENT_WORKFLOW(WorkflowData.class, "ui/setUp/workflowManagement/workflow.json"),
    WORKFLOW_ACTIVITY(WorkflowActivityData.class, "ui/setUp/workflowManagement/workflowActivity.json"),
    WORKFLOW_REVIEWER(WorkflowReviewerApproverData.class, "ui/setUp/workflowManagement/workflowReviewer.json"),
    QUESTIONNAIRE(QuestionnaireData.class, "ui/setUp/questionnaireManagement/questionnaire.json"),
    QUESTION(QuestionData.class, "ui/setUp/questionnaireManagement/question.json"),
    MESSAGE_MANAGEMENT(MessageManagementData.class, "ui/setUp/messageManagement/messageManagement.json"),
    CUSTOM_FIELDS(CustomFieldData.class, "ui/setUp/customFields/customFields.json"),
    USER_GROUP(GroupData.class, "ui/setUp/userManagement/userGroup.json"),
    USER_ROLE(UserRoleData.class, "ui/setUp/userManagement/role.json"),
    USER(UserData.class, "ui/setUp/userManagement/user.json"),
    VALUE(Value.class, "ui/setUp/valueManagement/value.json"),
    COUNTRY_CHECKLIST(CountryChecklistData.class, "ui/setUp/countryChecklist/countryChecklist.json"),
    APPROVAL_PROCESS(ApprovalProcessData.class, "ui/setUp/approvalProcess/approvalProcess.json"),
    MY_ORGANISATION(MyOrganisation.class, "ui/setUp/myOrganisation/myOrganisation.json"),
    QUESTIONNAIRE_ANSWERS(QuestionnaireAnswersData.class, "ui/setUp/questionnaireManagement/questionnaireAnswers.json");

    private final Class<?> dataPayloadClass;
    private final String jsonDataFile;
    private final String JSON = ".json";

    DataProvider(Class<?> dataPayloadClass, String jsonDataFile) {
        this.dataPayloadClass = dataPayloadClass;
        this.jsonDataFile = jsonDataFile;
    }

    public Class<?> getDataPayloadClass() {
        return this.dataPayloadClass;
    }
}
