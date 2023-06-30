@ui @full_regression @email_management @deactivate_email
Feature: Deactivating an Email Template

  As a RDDC Administrator
  I want to be able to disable an email sending
  So that manage the details stop being sent to the recipient of the email

  Background:
    Given User logs into RDDC as "Admin"
    When User navigates to Email Management page
    Then Email Management page is opened
    When User selects "50" items per page

  @C41144336
  @onlySingleThread
  @email
  Scenario: C41144336: Deactivating an Email Template - Activity Assigned
    When User clicks Edit button for "Activity Assigned" template row
    And User saves initial "Activity Assigned" template data
    Then "Activity Assigned" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire with Approver user"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Email notification "Refinitiv Due Diligence Centre - Activity: Auto Activity has been assigned to you" is not received by "Approver" user

  @C41143991
  @onlySingleThread
  @email
  Scenario: C41143991: Deactivating an Email Template - Activity Completed
    When User clicks Edit button for "Activity Completed" template row
    And User saves initial "Activity Completed" template data
    Then "Activity Completed" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates "Activity Type" "without assessment" via API
    And User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Email notification "Activity Completed" with following values is not received by "Admin" user
      | <Activity_Name> | AUTO_TEST_ACTIVITY_NAME |

  @C41144223
  @onlySingleThread
  @email
  Scenario: C41144223: Deactivating an Email Template - Activity Reactivated
    When User clicks Edit button for "Activity Reactivated" template row
    And User saves initial "Activity Reactivated" template data
    Then "Activity Reactivated" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User updates Activity Type "Assign Questionnaire" with following assessments via API
      | first  |
      | second |
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" with "Assign Questionnaire" data
    And User adds new Activity "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_2" with "Assessment One Field Custom Activity" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User clicks 'Save' activity button
    And User clicks "Proceed" Alert dialog button
    Then Email notification "Activity Reactivated" with following values is not received by "Assignee" user
      | <Activity_Name> | AUTO_TEST_QUESTIONNAIRE_ONBOARDING_1_1 |

  @C41144311
  @onlySingleThread
  @email
  Scenario: C41144311: Deactivating an Email Template - Activity Recalled
    When User clicks Edit button for "Activity Recalled" template row
    And User saves initial "Activity Recalled" template data
    Then "Activity Recalled" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates "Activity Type" "without assessment" via API
    And User creates "Activity Type" "with 1 assessment fields" via API
    And User creates "Activity Type" "with 3 assessment fields" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_1_1" with "Assessment Three Field Custom Activity" data
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_1_2" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_1_3" with "Assessment One Field Custom Activity" data
    And User clicks Add Wizard Component button
    And User updates Component Name "Group_2"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_2_1" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_2_2" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_2_3" with "Simple Custom Activity" data
    And User adds new Activity "AUTO_TEST_CUSTOM_ONBOARDING_2_4" with "Simple Custom Activity" data
    And User clicks workflow button "GROUPING"
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 0
    And User ticks checkbox for activity on position 1
    And User ticks checkbox for activity on position 2
    And User selects "Group 1" transfer to option
    And User clicks "Apply" grouping button
    And User clicks "Add" grouping button
    And User ticks checkbox for activity on position 3
    And User ticks checkbox for activity on position 4
    And User ticks checkbox for activity on position 5
    And User ticks checkbox for activity on position 6
    And User selects "Group 2" transfer to option
    And User clicks "Apply" grouping button
    And User clicks workflow button "Done"
    And User clicks workflow button "BRANCHING"
    And User clicks on "AUTO_TEST_CUSTOM_ONBOARDING_1_1" branching modal activity
    And User selects "AUTO_TEST_CUSTOM_ONBOARDING_2_1" for "first" drop-down
    And User selects "AUTO_TEST_CUSTOM_ONBOARDING_2_2" for "second" drop-down
    And User clicks workflow button "Apply"
    And User clicks on "AUTO_TEST_CUSTOM_ONBOARDING_1_3" branching modal activity
    And User selects "AUTO_TEST_CUSTOM_ONBOARDING_2_3" for "first" drop-down
    And User clicks workflow button "Apply"
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_CUSTOM_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_CUSTOM_ONBOARDING_1_2" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_CUSTOM_ONBOARDING_1_3" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity Assessment "first"
    And User clicks 'Save' activity button
    And User clicks on "AUTO_TEST_CUSTOM_ONBOARDING_1_1" activity
    And User clicks Edit button for Activity
    And User selects activity status "In Progress"
    And User clicks 'Save' activity button
    And User clicks "Proceed" Alert dialog button
    Then Email notification "Activity Recalled" with following values is not received by "Admin" user
      | <Activity_Name> | AUTO_TEST_CUSTOM_ONBOARDING_2_1 |

  @C41144318
  @onlySingleThread
  @email
  Scenario: C41144318: Deactivating an Email Template - Approval Rejected
    When User clicks Edit button for "Approval Rejected" template row
    And User saves initial "Approval Rejected" template data
    Then "Approval Rejected" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks "Reject" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Email notification "Approval Rejected" with following values is not received by "Admin" user
      | <Activity_Name>    | OrderDueDiligenceReport |
      | <Third_Party_Name> | OrderDueDiligenceReport |

  @C41144322
  @onlySingleThread
  @email
  Scenario: C41144322: Deactivating an Email Template - Order Request For Approval
    When User clicks Edit button for "Order Request For Approval" template row
    And User saves initial "Order Request For Approval" template data
    Then "Order Request For Approval" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "with random ID name"
    And User clicks on Create Order under Due Diligence Order section
    Then Create Due Diligence Order page is opened
    When Create Due Diligence Order page should be shown with default values for "Organisation" order type
    And User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    And Email notification "Order Request For Approval" with following values is not received by "Admin" user
      | <Approver_FirstName> | <Approver_FirstName> |

  @C41144341
  @onlySingleThread
  @email
  Scenario: C41144341: Deactivating an Email Template - Order Request Placed
    When User clicks Edit button for "Order Request Placed" template row
    And User saves initial "Order Request Placed" template data
    Then "Order Request Placed" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    When User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And User clicks "Approve" approve action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    When User clicks Create Order button
    Then Due Diligence Order form is opened
    When User fills in Po No.
    And User clicks "Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    And Email notification "Order Request Placed" with following values is not received by "Admin" user
      | <Requestor_FirstName> | <Requestor_FirstName> |

  @C41144347
  @onlySingleThread
  @email
  Scenario: C41144347: Deactivating an Email Template - Order Request Rejected
    When User clicks Edit button for "Order Request Rejected" template row
    And User saves initial "Order Request Rejected" template data
    Then "Order Request Rejected" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User sets up Due Diligence Order Approval Responsible Party Default Approver via API
    And User creates third-party "workflowGroupUkraineOrganizationWithApprover"
    And User clicks Start Onboarding for third-party
    And User clicks on "OrderDueDiligenceReport" activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks Edit button for Activity
    Then Create Order button is displayed
    When User clicks Create Order button
    And User clicks none selected scope
    And User fills in Po No.
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User clicks Order Details button
    And User clicks "Decline Order" button on Due Diligence Order page
    Then Modal window with text 'Are you sure you want to decline? This change cannot be undone.' appears
    When User clicks on Proceed button on Due Diligence Order page
    Then Activity Information page is displayed
    And Email notification "Order Request Rejected" with following values is not received by "Admin" user
      | <Approver_FirstName> | <Approver_FirstName> |

  @C41144355
  @onlySingleThread
  @email @WSO2email
  Scenario: C41144355: Deactivating an Email Template - Questionnaire Assigned
    When User clicks Edit button for "Questionnaire Assigned" template row
    And User saves initial "Questionnaire Assigned" template data
    Then "Questionnaire Assigned" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    And User creates valid email
    And User creates Associated Party "for questionnaire activity"
    And User clicks Log Out button
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User logs into RDDC as "user created during test"
    And User clicks Log Out button
    And User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "External_First_Name" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    And Email notification "Questionnaire Assigned" with following values is not received by "current" user
      | <Activity_Name> | External Questionnaire for thirdPartyName |

  @C41144364
  @onlySingleThread
  @email
  Scenario: C41144364: Deactivating an Email Template - Questionnaire Cancelled
    When User clicks Edit button for "Questionnaire Cancelled" template row
    And User saves initial "Questionnaire Cancelled" template data
    Then "Questionnaire Cancelled" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - 'ONBOARDING'
    When User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Actions"
    And User clicks Actions 'Cancel' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks "Proceed" Alert dialog button
    Then Activity Information page is displayed
    And Email notification "Refinitiv Due Diligence Centre - %s has been cancelled" is not received by "Admin" user

  @C41144364
  @onlySingleThread
  @email
  Scenario: C41144364: Deactivating an Email Template - Questionnaire Cancelled - Renew
    When User clicks Edit button for "Questionnaire Cancelled" template row
    And User saves initial "Questionnaire Cancelled" template data
    Then "Questionnaire Cancelled" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Ukraine"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "Approve Onboarding Activity"
    And User adds new Activity "Assign Questionnaire"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group Ukraine"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "Auto_Component_1" tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User clicks "Auto_Component_1" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Actions"
    And User clicks Actions 'Cancel' button for Activity "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks "Proceed" Alert dialog button
    Then Activity Information page is displayed
    And Email notification "Refinitiv Due Diligence Centre - %s has been cancelled" is not received by "Admin" user

  @C41171605
  @onlySingleThread
  @email
  Scenario: C41171605: Deactivating an Email Template - Questionnaire Completed
    When User clicks Edit button for "Questionnaire Completed" template row
    And User saves initial "Questionnaire Completed" template data
    Then "Questionnaire Completed" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Internal Questionnaire for" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Questionnaire Overall Assessment button "Approve"
    Then Overall Assessment confirmation modal appears
    When User clicks Questionnaire Overall Assessment button "Confirm"
    Then Activity Information page is displayed
    And Email notification "Questionnaire Completed" with following values is not received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |

  @C41171749
  @onlySingleThread
  @email
  Scenario: C41171749: Deactivating an Email Template - Questionnaire Review
    When User clicks Edit button for "Questionnaire Review" template row
    And User saves initial "Questionnaire Review" template data
    Then "Questionnaire Review" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assign Questionnaire"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Auto Activity" activity
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Activity Information page is displayed
    When User logs into RDDC as "APPROVER"
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Due Date" dashboard table column header
    And User clicks on assigned activity for created third-party
    And User clicks Edit button for Activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    And Email notification "Questionnaire Review" with following values is not received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |

  @C41171750
  @onlySingleThread
  @email
  Scenario: C41171750: Deactivating an Email Template - Questionnaire Revision Request
    When User clicks Edit button for "Questionnaire Revision Request" template row
    And User saves initial "Questionnaire Revision Request" template data
    Then "Questionnaire Revision Request" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User clicks Edit button for Activity
    And Approver "Admin_AT_FN Admin_AT_LN" clicks "Approve" button
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Internal Questionnaire for" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks "Assign Questionnaire Component" tab
    And User clicks on "Assign Questionnaire" activity
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Review"
    And User clicks Comment questionnaire button
    And User fills in Comment text "test comment"
    And User clicks Send comment button
    And User clicks Done comment button
    And User clicks Questionnaire Overall Assessment button "Send to assignee"
    Then Activity Information page is displayed
    And Email notification "Questionnaire Revision Request" with following values is not received by "Admin" user
      | <Questionnaire_Name> | AUTO_TEST_INTERNAL_QUESTIONNAIRE |

  @C41171752
  @onlySingleThread
  @email
  Scenario: C41171752: Deactivating an Email Template - Request for Approval
    When User clicks Edit button for "Request for Approval" template row
    And User saves initial "Request for Approval" template data
    Then "Request for Approval" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User creates third-party "with questionnaire workflow"
    And User clicks Start Onboarding for third-party
    Then Email notification "Request for Approval" with following values is not received by "Admin" user
      | <Activity_Name> | Assign Questionnaire |

  @C41171773
  @onlySingleThread
  @email
  Scenario: C41171773: Deactivating an Email Template - Request for Review
    When User clicks Edit button for "Request for Review" template row
    And User saves initial "Request for Review" template data
    Then "Request for Review" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User logs into RDDC as "Assignee"
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    When User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Approver" tab
    And User clicks 'Add Existing Approval Process' button
    And User selects approval process with name "Automation Approval Process"
    And User click approval process button "Select"
    And User clicks Activity "Add Reviewer" tab
    And User selects "Assignee_AT_FN Assignee_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User approves all activities
    And User clicks Back button to return from Activity modal
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    Then Activity Information Reviewers section is not shown
    When User selects activity status "In Progress"
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    Then Activity Information Reviewers section is not shown
    When User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information Reviewers section is shown
    And Email notification "Request for Review" with following values is not received by "Assignee" user
      | <Activity_Name> | Request for Due Diligence |

  @C41171781
  @onlySingleThread
  @email
  Scenario: C41171781: Deactivating an Email Template - Review Rejected
    When User clicks Edit button for "Review Rejected" template row
    And User saves initial "Review Rejected" template data
    Then "Review Rejected" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    And User clicks Add Wizard Component button
    And User updates Component Name "Auto_Component_1"
    And User clicks Check button
    And User adds new Activity "World Check Ongoing Screening Update Activity"
    And User clicks +Add Activity button
    And User fills in Activity "Request for Due Diligence Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User selects "Admin_AT_FN Admin_AT_LN" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks "Auto_Component_1" component tab
    And User clicks on "Request for Due Diligence" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Request for Due Diligence" activity
    Then Activity Information page is displayed
    When User clicks "Reject" review action button for "Admin_AT_FN Admin_AT_LN" user
    And User clicks Reject button on confirmation window
    Then Confirmation window is disappeared
    And Email notification "Review Rejected" with following values is not received by "Assignee" user
      | <Activity_Name> | Request for Due Diligence |

  @C41171803
  @onlySingleThread
  @email
  Scenario: C41171803: Deactivating an Email Template - Screening Delegation
    When User clicks Edit button for "Screening Delegation" template row
    And User saves initial "Screening Delegation" template data
    Then "Screening Delegation" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_ONBOARDING_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on "AUTO_TEST_WC_ONBOARDING_IN_PROGRESS" activity
    And User clicks Actions button for 1 Review Task
    And User clicks "Revert to For Review" action option
    And User clicks "Proceed" Alert dialog button
    And User clicks Back button to return from Activity modal
    And User clicks on 1 number screening record
    Then Screening profile's Review Status is "For Review"
    And Email notification "Screening Delegation" with following values is not received by "Admin" user
      | <WC1_Record_Name> | 1 |

  @C41171885
  @onlySingleThread
  @email
  Scenario: C41171885: Deactivating an Email Template - Screening Delegation Completed
    When User clicks Edit button for "Screening Delegation Completed" template row
    And User saves initial "Screening Delegation Completed" template data
    Then "Screening Delegation Completed" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_ONBOARDING_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    When User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    Then Email notification "Screening Delegation Completed" with following values is not received by "Assignee" user
      | <WC1_Record_Name> | 1 |

  @C41171885
  @onlySingleThread
  @email
  Scenario: C41171885: Deactivating an Email Template - Screening Delegation Completed - Renew
    When User clicks Edit button for "Screening Delegation Completed" template row
    And User saves initial "Screening Delegation Completed" template data
    Then "Screening Delegation Completed" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Group_1"
    And User clicks Check button
    And User adds new Activity "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" with "World Check Screening Activity" data
    And User clicks Save button for Workflow
    And User creates third-party "with workflow group and assignee user responsible party"
    And User changes Search Criteria "Search Term" with value "Apple"
    And User clicks Start Onboarding for third-party
    And User clicks "Group_1" component tab
    And User clicks on "AUTO_TEST_WC_RENEWAL_IN_PROGRESS" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    And User clicks on 1 number screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    And User clicks on the 'Review' screening profile button
    And User clicks on the 'Screening Results' screening profile button
    Then Email notification "Screening Delegation Completed" with following values is not received by "Assignee" user
      | <WC1_Record_Name> | 1 |

  @C41173474
  @email
  Scenario: C41173474: Deactivating an Email Template - Third-party Pending for Renewal
    When User clicks Edit button for "Third-party Pending for Renewal" template row
    And User saves initial "Third-party Pending for Renewal" template data
    Then "Third-party Pending for Renewal" email template page is displayed
    And User makes sure that template Active checkbox is unchecked
    When User clicks Save template button
    And User navigates to Workflow Management Renewal Settings page
    And User clicks "Responsible Party" default assignee radio button
    And User clicks Renewal Settings Save button
    And User creates third-party "with renewal workflow Norway"
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And Email notification "Refinitiv Due Diligence Centre – Third-party Pending for Renewal" is not received by "Admin" user
