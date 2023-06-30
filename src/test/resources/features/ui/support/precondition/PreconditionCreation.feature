@ui @precondition
Feature: Auto-tests Precondition Creation

  @create_values
  Scenario Outline: 1: Create Value Management values for auto-test
    Given User logs into RDDC as "Admin"
    And Value Management does not contain "<valueType>" "<activityTypeReference>" value
    When User creates "<valueType>" "<activityTypeReference>" via API
    Then Value Management contains "<valueType>" "<activityTypeReference>" value
    Examples:
      | valueType              | activityTypeReference                     |
      | Activity Type          | without assessment                        |
      | Activity Type          | with 1 assessment fields                  |
      | Activity Type          | with 3 assessment fields                  |
      | Activity Type          | Assign Questionnaire                      |
      | Activity Type          | Assessment                                |
      | Activity Type          | Request for Due Diligence Activity        |
      | Activity Type          | Background Investigation Activity         |
      | Activity Type          | Auto Test Custom Activity                 |
      | Risk Scoring Range     | Medium Risk Scoring Range                 |
      | Risk Scoring Range     | Low Risk Scoring Range                    |
      | Questionnaire Category | AUTO_TEST_CATEGORY Questionnaire Category |

  @create_third_parties
  Scenario Outline: 1: Create Third-parties for auto-test
    Given User logs into RDDC as "Admin"
    And Third-party overview does not contain "<thirdPartyReference>" third-party
    When User creates third-party "<thirdPartyReference>" via API and open it
    Then Third-party overview contains "<thirdPartyReference>" third-party
    Examples:
      | thirdPartyReference                     |
      | Supplier_External_User DO NOT DELETE    |
      | Supplier_Internal_User DO NOT DELETE    |
      | SUPPLIER_FOR_EDIT_EXTERNAL_USER         |
      | THIRD_PARTY_WITH_USER_DO_NOT_DELETE     |
      | THIRD_PARTY_QUESTIONNAIRE_DO_NOT_DELETE |

  @create_organisations
  Scenario Outline: 1: Create Organizations for auto-test
    Given User logs into RDDC as "Admin"
    When User navigates to My Organisation page
    And User clicks My Organisation "<organizationTab>" tab
    And User selects "All" items per page
    Then My Organisation with provided "<organizationReference>" details is not created
    When User clicks My organisation Add New button
    And User populates Entity input fields "<organizationReference>"
    And User clicks My organisation page "Save" button
    And User selects "All" items per page
    Then My Organisation with provided "<organizationReference>" details is created
    Examples:
      | organizationTab       | organizationReference    |
      | Entity                | with MyEntity name       |
      | External Organisation | with MyOrganisation name |
      | Division              | with Empty Data name     |
      | Division              | with Operations name     |
      | Department            | with MyDepartment name   |

  @create_roles
  Scenario Outline: 1: Create User Role
    Given User logs into RDDC as "Admin"
    And Skip User Role "<roleReference>" creation if already exists
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When User clicks 'Add New Role' button
    And User fills User Role page header with "<roleReference>" data without context
    And User fills Third-party block with "<roleReference>" data
    And User fills reports block with "<roleReference>" data
    And User fills setUp block with "<roleReference>" data
    And User fills ddOrdering block with "<roleReference>" data
    And User fills Data Providers block with "<roleReference>" data
    And User clicks 'Submit' Role Management button
    Then Role saved with provided details
    Examples:
      | roleReference                                                |
      | AUTO TEST ROLE                                               |
      | lower case inactive auto test role                           |
      | AUTO TEST ROLE WITH RESTRICTIONS                             |
      | AUTO TEST ROLE EDIT WITH RESTRICTIONS                        |
      | AUTO_NO_ONBOARDING_RENEWAL                                   |
      | AUTO TEST ROLE WITH DOWNLOAD AND ADD FILES PERMISSION        |
      | AUTO TEST ROLE WITH ADD AND DELETE FILES PERMISSION          |
      | AUTO TEST ROLE WITH ADD FILES PERMISSION                     |
      | AUTO TEST ROLE WITH DOWNLOAD FILES PERMISSION                |
      | AUTO TEST ROLE WITH DELETE FILES AND EDIT COMMENT PERMISSION |
      | AUTO TEST ROLE WITH DISABLED SCREENING                       |
      | AUTO TEST MEDIACHECK PERMISSION ALL ON                       |
      | AUTO TEST MEDIACHECK PERMISSION ALL OFF                      |
      | AUTO TEST SCREENING PERMISSION ALL OFF                       |
      | AUTO TEST SCREENING PERMISSION ON                            |
      | AUTO ROLE WITH RESTRICTED REPORTS                            |
      | Full Permission Role                                         |
      | AUTO_READ_ONLY_ACTIVITY                                      |

  @create_workflow_groups
  Scenario Outline: 1: Create Workflow Groups
    Given User logs into RDDC as "Admin"
    And Skip Workflow Group "<workflowGroupReference>" creation if already exists
    When User creates workflow group "<workflowGroupReference>" via API without context
    Examples:
      | workflowGroupReference                         |
      | Auto Workflow Group                            |
      | Auto Workflow Group Individual                 |
      | Auto Workflow Group Individual with Approver   |
      | Auto Workflow Group Organisation with Approver |
      | Auto Questionnaire                             |
      | Auto_Workflow_Group_Dashboard                  |
      | Auto Workflow Renewal                          |

  @create_review_process
  Scenario: 2: Create Review Process for auto-test
    Given User logs into RDDC as "Admin"
    Then Review Process with "Auto Review Process" name is not created
    When User creates Review Process with "Auto Review Process" via API
    Then Review Process with "Auto Review Process" name is created

  @create_approval_process
  Scenario: 2: Create Approval Process for auto-test
    Given User logs into RDDC as "Admin"
    Then Approval Process with "Automation Approval Process" name is not created
    When User creates Approval Process with "Automation Approval Process" via API
    Then Approval Process with "Automation Approval Process" name is created

  @create_questionnaires
  Scenario Outline: 2: Create Questionnaires for auto-test
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "<questionnaireReference>" name is not created
    When User navigates to Questionnaire Management page
    And Questionnaire Overview page is displayed
    And User clicks Add Questionnaire button
    When User creates Questionnaire with "<questionnaireReference>" data with "Boolean" question
    Then Questionnaire with "<questionnaireReference>" name is created
    Examples:
      | questionnaireReference                                       |
      | AUTO_TEST_EXTERNAL_QUESTIONNAIRE                             |
      | AUTO_TEST_EXTERNAL_SECOND_QUESTIONNAIRE                      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE                             |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE_SECOND                      |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE_CONFIG                      |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_REVIEW              |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_2_IN_REVIEW   |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_LEVEL_3_IN_REVIEW   |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_EXTERNAL            |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_COMPLETED           |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_BRANCHING_QUESTIONS |
      | AUTO_TEST_QUESTIONNAIRE_RISK_REMEDIATION_MAPPED_ASSESSMENT   |

  @create_questionnaires_enhancedTextEntryPlus
  Scenario Outline: 2: Create Questionnaires EnhancedTextEntryPlus for auto-test
    Given User logs into RDDC as "Admin"
    Then Questionnaire with "<questionnaireReference>" name is not created
    When User navigates to Questionnaire Management page
    And Questionnaire Overview page is displayed
    And User clicks Add Questionnaire button
    When User creates Questionnaire with "<questionnaireReference>" data with "EnhancedTextEntryPlus" question
    Then Questionnaire with "<questionnaireReference>" name is created
    Examples:
      | questionnaireReference                           |
      | AUTO_TEST_QUESTIONNAIRE_ENHANCED_TEXT_ENTRY_PLUS |

  @update_admin_user
#    TODO run after @create_organisations
  Scenario: 3: Update Admin User data
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches user by "Admin_AT_FN" keyword
    And User clicks edit user button for user with First Name "Admin_AT_FN"
    And User selects in "External Organisation" Edit User value "MyOrganisation"
    And User selects in "Entity" Edit User value "MyEntity"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by "Admin_AT_FN" keyword
    And User clicks on user with First Name "Admin_AT_FN"
    Then Overview User modal is displayed
    And User overview is displayed with values
      | Entity   | External Organisation |
      | MyEntity | MyOrganisation        |

  @create_internal_users
    @WSO2email
#    TODO run after @create_organisations and @create_roles
  Scenario Outline: 3: Create Internal Users
    Given User logs into RDDC as "Admin"
    Then Internal user with "<userReference>" data is not created
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User creates internal user with data "<userReference>"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received by "<userReference>" user
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value for user "<userReference>"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    Examples:
      | userReference                                |
      | Forgot Password                              |
      | Assignee                                     |
      | Inactive User                                |
      | Internal User                                |
      | Approver                                     |
      | Restricted                                   |
      | Restricted with Edit permissions             |
      | Second with Edit permissions                 |
      | User Without Onboarding And Renewal Accesses |
      | Admin Double                                 |
      | Internal User For Editing                    |
      | Reset Password User                          |
      | Empty Metrics User                           |
      | Changing role user                           |
      | user screening permission off                |
      | user media check permission on               |
      | user media check permission off              |
      | user screening permission on                 |

  @create_internal_users
#    TODO run after @create_organisations and @create_roles
  Scenario: 3: Create Internal Users - OOO
#    OOO status will be "Yes" after nightly OOO status update job run
    Given User logs into RDDC as "Admin"
    Then Internal user with "OOO User" data is not created
    When User creates internal user with data "OOO User"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User clicks edit user button for user with First Name "OOO_USER_FN"
    And User clicks User form button "Out of Office"
    And User clicks User Overview Edit button
    And User fills in "From" Edit User value "TODAY-1"
    And User fills in "Delegate to" Edit User value "Admin_AT_FN Admin_AT_LN"
    And User fills in "Status" Edit User value "New"
    And User clicks User form button "Save"

  @create_external_users
    @WSO2email
#    TODO run after @create_third_parties
  Scenario Outline: 3: Create External Users
    Given User logs into RDDC as "Admin"
    Then External user with "<userReference>" data is not created
    When Creates "<userReference>" contact for "<thirdPartyName>" third-party via API
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received by "<userReference>" user
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value for user "<userReference>"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    Examples:
      | thirdPartyName                          | userReference                    |
      | Supplier_External_User DO NOT DELETE    | External                         |
      | Supplier_External_User DO NOT DELETE    | External Forgot Password         |
      | Supplier_External_User DO NOT DELETE    | External Inactive User           |
      | THIRD_PARTY_WITH_USER_DO_NOT_DELETE     | External User for Password Edit  |
      | THIRD_PARTY_WITH_USER_DO_NOT_DELETE     | External User With Similar Email |
      | THIRD_PARTY_QUESTIONNAIRE_DO_NOT_DELETE | External User for Questionnaire  |

  @create_assigned_activities
#    TODO run after @create_third_parties and @create_values
  Scenario: 3: Create Assigned Activities
    Given User logs into RDDC as "Admin"
    When Skip Assigned Activities creation if already exists
    And User navigates to Third-party page
    And User opens Third-party with name "Supplier_External_User DO NOT DELETE"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "Request for Due Diligence Activity"
    And User fills in "Activity Name" field with "Adhoc activity"
    And User fills in "Description" field with "Adhoc activity description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User navigates to Home page
    And User clicks 'Assigned Activities' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed

  @update_inactive_user
#    TODO run after @create_internal_users and @create_external_users
  Scenario Outline: 4: Update Inactive User data
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches user by "<firstName>" keyword
    And User clicks edit user button for user with First Name "<firstName>"
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name  | User Type  | Status   |
      | <firstName> | <userType> | INACTIVE |
    Examples:
      | firstName              | userType |
      | Auto_External_Inactive | External |
      | Auto_Internal_Inactive | Internal |

  @create_groups
#    TODO run after @create_internal_users
  Scenario Outline: 4: Create user groups
    Given User logs into RDDC as "Admin"
    And Skip User Group "<groupName>" creation if already exists
    When User creates new User Group "<groupReference>" via API without context
    Then User group "<groupName>" is created
    Examples:
      | groupName              | groupReference            |
      | Assignee Group         | Assignee Group user group |
      | AUTO_GROUP             | AUTO_GROUP user group     |
      | Group With Multi Users | Group With Multi Users    |

  @create_workflows
# TODO run after @create_workflow_groups and @create_values(Scoring Range)
  Scenario Outline: 3: Create Workflow with Order Due Diligence Report activity
    Given User logs into RDDC as "Admin"
    And Skip Workflow "<workflowReference>" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "<workflowReference>"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User adds new Activity "<activityReference>"
    And User clicks Save button for Workflow without context
    Then Workflow "<workflowReference>" is created
    Examples:
      | workflowReference              | activityReference                                |
      | Automation Workflow            | Order Due Diligence Report Organisation Activity |
      | Automation Workflow Individual | Order Due Diligence Report Individual Activity   |

  @create_workflows_components
    # TODO run after @create_workflow_groups and @create_values(Scoring Range)
  Scenario: 3: Create Workflow with multiple Components
    Given User logs into RDDC as "Admin"
    And Skip Workflow "Automation Workflow Questionnaire" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Workflow Questionnaire"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Assign Questionnaire Component"
    And User clicks Check button
    And User adds new Activity "Assign Questionnaire with Assignee user role" with Approver "Admin_AT_FN"
    And User clicks Add Wizard Component button
    And User adds new Activity "Assign Questionnaire with Due In 2 days Activity"
    And User clicks Save button for Workflow without context
    Then Workflow "Automation Workflow Questionnaire" is created

  @create_workflows_individual
    # TODO run after @create_workflow_groups and @create_values(Scoring Range)
  Scenario: 3: Create Workflow with Individual Scope and Approver
    Given User logs into RDDC as "Admin"
    And Skip Workflow "Automation Workflow Individual with Approver" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Workflow Individual with Approver"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "Order Due Diligence Report Individual Activity" with Approver "Admin_AT_FN"
    And User clicks Save button for Workflow without context
    Then Workflow "Automation Workflow Individual with Approver" is created

  @create_workflows_dashboard
    # TODO run after @create_workflow_groups and @create_values(Scoring Range)
  Scenario: 3: Create Workflow for Dashboard
    Given User logs into RDDC as "Admin"
    And Skip Workflow "Automation_Workflow_Dashboard" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation_Workflow_Dashboard"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User adds new Activity "Order Due Diligence Report Organisation Activity" with Approver "Admin_AT_FN" and Reviewer "Admin_AT_FN"
    And User adds new Activity "Order Due Diligence Report Individual Activity"
    And User adds new Activity "World Check Ongoing Screening Update Activity with Assignee"
    And User clicks Save button for Workflow without context
    Then Workflow "Automation_Workflow_Dashboard" is created

  @create_workflows_renewal
    # TODO run after @create_workflow_groups and @create_values(Scoring Range)
  Scenario Outline: 3: Create Workflow for Renewal
    Given User logs into RDDC as "Admin"
    And Skip Workflow "<workflowName>" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "<workflowName>"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User updates Component Name "Custom Component"
    And User clicks Check button
    And User adds new Activity "Auto Test Custom Activity with Assessment"
    And User clicks Save button for Workflow without context
    Then Workflow "<workflowName>" is created
    Examples:
      | workflowName                                       |
      | Auto Workflow Renewal Workflow Low Risk            |
      | Auto Workflow Renewal Workflow Low Risk Onboarding |

  @create_workflows_approvers
    # TODO run after @create_workflow_groups and @create_values and @create_internal_users
  Scenario: 4: Create Workflow with multiple Approvers
    Given User logs into RDDC as "Admin"
    And Skip Workflow "Automation Workflow with several Approvers" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Workflow with several Approvers"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User fills new Activity "No Satisfied Approval Rule Activity" details
    And User clicks Activity "Approver" tab
    And User selects in Approval Process Default Approver dropdown value "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 1
    And User selects in Add Approver "Third-party Country" Value dropdown value "Bermuda" for rule with number 1
    And User selects in Add Approver Approver dropdown value "Autouser_With_Restrictions Autouser_With_Restrictions_Last_Name" for rule with number 1
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 2
    And User selects in Add Approver "Third-party Country" Value dropdown value "Aruba" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 2
    And User selects Add Approver Approver Method radio button "In Sequence" for rule with number 2
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Industry Type" for rule with number 3
    And User selects in Add Approver "Third-party Industry Type" Value dropdown value "Aerospace" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" for rule with number 3
    And User selects Add Approver Approver Method radio button "Any" for rule with number 3
    And User clicks Done button for Activity
    And User fills new Activity "Two Approval Rules Satisfied In Sequence Activity" details
    And User clicks Activity "Approver" tab
    And User selects in Approval Process Default Approver dropdown value "Admin_AT_FN Admin_AT_LN"
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 1
    And User selects in Add Approver "Third-party Country" Value dropdown value "Belize" for rule with number 1
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 1
    And User selects Add Approver Approver Method radio button "In Sequence" for rule with number 1
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Industry Type" for rule with number 2
    And User selects in Add Approver "Third-party Country" Value dropdown value "Aerospace" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Autouser_With_Restrictions Autouser_With_Restrictions_Last_Name" for rule with number 2
    And User selects Add Approver Approver Method radio button "In Sequence" for rule with number 2
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Industry Type" for rule with number 3
    And User selects in Add Approver "Third-party Industry Type" Value dropdown value "Human Resources" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" for rule with number 3
    And User selects Add Approver Approver Method radio button "All" for rule with number 3
    And User clicks Done button for Activity
    And User fills new Activity "One Satisfied Approval Rule Activity" details
    And User clicks Activity "Approver" tab
    And User selects in Approval Process Default Approver dropdown value "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 1
    And User selects in Add Approver "Third-party Country" Value dropdown value "Belize" for rule with number 1
    And User selects in Add Approver Approver dropdown value "Autouser_With_Restrictions Autouser_With_Restrictions_Last_Name" for rule with number 1
    And User selects Add Approver Approver Method radio button "All" for rule with number 1
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 2
    And User selects in Add Approver "Third-party Country" Value dropdown value "Aruba" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 2
    And User selects Add Approver Approver Method radio button "All" for rule with number 2
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 3
    And User selects in Add Approver "Third-party Country" Value dropdown value "Cape Verde" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Autouser_Edit_FN Autouser_Edit_LN" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" for rule with number 3
    And User selects Add Approver Approver Method radio button "All" for rule with number 3
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Country" for rule with number 4
    And User selects in Add Approver "Third-party Country" Value dropdown value "Fiji" for rule with number 4
    And User selects in Add Approver Approver dropdown value "Autouser_Edit_FN Autouser_Edit_LN" for rule with number 4
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 4
    And User selects Add Approver Approver Method radio button "All" for rule with number 4
    And User clicks Done button for Activity
    And User clicks Save button for Workflow without context
    Then Workflow "Automation Workflow with several Approvers" is created

  @create_workflows_approvers_org
    # TODO run after @create_workflow_groups and @create_values(Scoring Range) and @create_internal_users
  Scenario: 4: Create Workflow with Scope Organisation and multiple Approvers
    Given User logs into RDDC as "Admin"
    And Skip Workflow "Automation Workflow Organization with Approver" creation if already exists
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    Then Workflow Create Workflow page is displayed
    When User fills in workflow details data "Automation Workflow Organization with Approver"
    And User clicks workflow button "Next"
    Then Add Wizard page is displayed
    When User clicks Add Wizard Component button
    And User fills new Activity "Order Due Diligence Report Organisation Activity" details
    And User clicks Activity "Approver" tab
    And User selects in Approval Process Default Approver dropdown value "Admin_AT_FN Admin_AT_LN"
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Industry Type" for rule with number 1
    And User selects in Add Approver "Third-party Industry Type" Value dropdown value "Chemical Production" for rule with number 1
    And User selects in Add Approver Approver dropdown value "Admin_AT_FN Admin_AT_LN" for rule with number 1
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 1
    And User selects Add Approver Approver Method radio button "In Sequence" for rule with number 1
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party country" for rule with number 2
    And User selects in Add Approver "Third-party Country" Value dropdown value "Afghanistan" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 2
    And User selects in Add Approver Approver dropdown value "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN" for rule with number 2
    And User selects Add Approver Approver Method radio button "Any" for rule with number 2
    And User clicks Add approver button
    And User selects in Add Approver Add Rules For dropdown value "Third-party Industry Type" for rule with number 3
    And User selects in Add Approver "Third-party Industry Type" Value dropdown value "Biotechnology" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Autouser_Edit_FN Autouser_Edit_LN" for rule with number 3
    And User selects in Add Approver Approver dropdown value "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" for rule with number 3
    And User selects Add Approver Approver Method radio button "In Sequence" for rule with number 3
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party country" for rule with number 4
    And User selects in Add Approver "Third-party Country" Value dropdown value "Myanmar" for rule with number 4
    And User selects in Add Approver Approver dropdown value "Autouser_Edit_FN Autouser_Edit_LN" for rule with number 4
    And User selects in Add Approver Approver dropdown value "Autouser_Second_Edit_FN Autouser_Second_Edit_LN" for rule with number 4
    And User selects Add Approver Approver Method radio button "Any" for rule with number 4
    And User clicks Approval Process Add button
    And User selects in Add Approver Add Rules For dropdown value "Third-party country" for rule with number 5
    And User selects in Add Approver "Third-party Country" Value dropdown value "Thailand" for rule with number 5
    And User selects in Add Approver Approver dropdown value "Autouser_Edit_FN Autouser_Edit_LN" for rule with number 5
    And User selects in Add Approver Approver dropdown value "Assignee_AT_FN Assignee_AT_LN" for rule with number 5
    And User selects Add Approver Approver Method radio button "Any" for rule with number 5
    And User clicks Done button for Activity
    And User fills new Activity "Auto Test Custom Activity" details
    And User clicks Done button for Activity
    And User clicks Save button for Workflow without context
    Then Workflow "Automation Workflow Organization with Approver" is created

  @create_items_to_approve_and_items_to_review
#    TODO run after @create_workflows_dashboard
  Scenario: 5: Create Items to Approve and Items to Review
    Given User logs into RDDC as "Admin"
    And Skip Items to Approve creation if already exists
    And User creates third-party "Auto_Third_party_Dashboard_Items" via API and open it
    And User clicks Start Onboarding for third-party
    And Remove Third-party from context
    And User navigates to Home page
    And User clicks 'Items To Approve' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed
    When User clicks 'Items To Review' widget
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed

  @create_order_to_approve_dashboard_items
#    TODO run after @create_workflows_dashboard
  Scenario: 5: Create Order to Approve Dashboard Items
    Given User logs into RDDC as "Admin"
    When Skip Orders to Approve creation if already exists
    And User creates third-party "Auto_Third_party_Dashboard_Orders_To_Approve" via API and open it
    And User clicks Start Onboarding for third-party
    And Remove Third-party from context
    And User clicks "New Component" component tab
    And User clicks on "Order Due Diligence Report" activity
    And User clicks Edit button for Activity
    And User approves all activities
    And User clicks Create Order button
    And User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    Then Pending Due Diligence Order is displayed in the list

  @create_dd_order_items
#    TODO run after @create_workflows_dashboard
  Scenario: 5: Create DD Order Items
    Given User logs into RDDC as "Admin"
    When Skip DD Orders creation if already exists
    And User creates third-party "Auto_Third_party_Dashboard_Orders" via API and open it
    And User clicks Start Onboarding for third-party
    And Remove Third-party from context
    And User clicks "New Component" component tab
    And User clicks on "Order Due Diligence Report" activity
    And User clicks Edit button for Activity
    And User approves all activities
    And User clicks Create Order button
    And User clicks none selected scope
    And User fills in Po No.
    And User gets OrderId from Due Diligence Order page URL
    And User clicks "Send for Approval" button on Due Diligence Order page
    Then Activity Information page is displayed
    When User navigates to Home page
    And User clicks 'Pending Orders For Approval' widget
    And User clicks Activity from 'Pending Order for Approval' table
    And User clicks "Approve and Place Order" button on Due Diligence Order page
    And User on confirmation block clicks "proceed"
    Then "ORDER SUCCESSFULLY SUBMITTED" message for Due Diligence Order is displayed
    When User navigates to Home page
    And User clicks 'Due Diligence Orders' widget
    Then Due Diligence Order is displayed in the list

  @create_items_to_review_screening
#    TODO run after @create_workflows_dashboard
  Scenario: 5: Create Items to Review (Screening)
    Given User logs into RDDC as "Admin"
    And Skip Screening items to review creation if already exists
    And User creates third-party "Auto_Third_party_Dashboard_Items_To_Review_Screening" via API and open it
    And Remove Third-party from context
    And User creates Associated Party "Barac Obama"
    And User creates Other name "Barac Obama" for Associated Party
    Then Other Name dialog is loaded
    And User clicks on 1 number Other name screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" Ad Hoc reviewer due to today date
    And User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Screening
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed

  @create_items_to_review_questionnaire
#    TODO run after @create_workflows_dashboard
  Scenario: 5: Create Items to Review (Questionnaire)
    Given User logs into RDDC as "Admin"
    And Skip Questionnaire items to review creation if already exists
    And User creates third-party "Auto_Third_party_Dashboard_Items_To_Review_Questionnaire" via API and open it
    And Remove Third-party from context
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN Admin_AT_LN" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User refreshes page
    And User clicks Notification Bell
    Then "Questionnaire has been Assigned" notification displayed with text
      | Internal Questionnaire for |
      | thirdPartyName             |
    When User clicks "Questionnaire has been Assigned" "Internal Questionnaire for thirdPartyName" notification
    And User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    Then Questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" status should be "Submitted"
    When User navigates to Home page
    And User clicks 'Items To Review' widget
    And User selects Items to Review Questionnaire
    And Users clicks "Third-party Name" dashboard table column header
    And User selects "50" items per page
    Then Assigned Activity for third-party is displayed

  @create_third_party_for_renewal
#    TODO run after @create_workflows_renewal
  Scenario: 6: Create Third-party for Renewal
    Given User logs into RDDC as "Admin"
    When Skip Third-party for Renewal creation if already exists
    And User creates third-party "Auto_Third_party_for_Renewal_Dashboard" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "Custom Component" component tab
    And User clicks on "Custom Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And User opens previously created Third-party
    Then Third-party's element "Renew" should be shown
    And Assessment section field "Next Renewal Date" is not displayed
    And Remove Third-party from context
    When User navigates to Home page
    And User clicks 'Third-party for Renewal' widget
    Then Assigned Activity for third-party is displayed