@ui @core_regression @activity_details
Feature: Third-party Information - Workflow Activity - Activity Visibility - Inactive User

  As a user
  I want to see a warning message when the assignee of the activity become inactive.
  So that I can reassign an activity to other active internal user.

  Background:
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as required via API

  @C43411761
  Scenario: C43411761: Activity Information Page - Activity Assignee - Activity Assignee becomes inactive
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "World Check Ongoing Screening Update Activity with created user assignee"
    And User deactivates users records with name reference "userFirstName" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "World Check Ongoing Screening Update" activity
    Then Alert Icon is displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
    And Toast message is not displayed

  @C43411764
  Scenario: C43411764: Activity Information Page - Activity with Reviewer - Activity Reviewer becomes inactive
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity" with Reviewer "userFirstName"
    And User deactivates users records with name reference "userFirstName" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Toast message is not displayed
    And Activity Information Invalid label is displayed for user "userFirstName"

  @C43411767
  Scenario: C43411767: Activity Information Page - Activity with Approver - Both Activity Assignee and Approver becomes inactive
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "World Check Ongoing Screening Update Activity with created user assignee" details
    And User selects Workflow Assignee(s) as "Internal Active User First"
    And User clicks Activity "Add Approver" tab
    And User selects "Internal Active User Second" value for Default Approver
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks on "World Check Ongoing Screening Update" activity
    Then Alert Icons are displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43411768
  Scenario: C43411768: Activity Information Page - Activity with Approver - Activity Approver becomes inactive
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User fills in "First Name" Add User value "toBeReplaced"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User adds new Activity "Assessment Activity" with Approver "userFirstName"
    And User clicks Save button for Workflow
    And User deactivates users records with name reference "userFirstName" via API
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    And Toast message is not displayed
    And Activity Information Invalid label is displayed for user "userFirstName"

  @C50872863
  Scenario: C50872863: Activity Information Page - Activity with Reviewer - Both Activity Assignee and Reviewer becomes inactive
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "World Check Ongoing Screening Update Activity with created user assignee" details
    And User selects Workflow Assignee(s) as "Internal Active User First"
    And User clicks Activity "Add Reviewer" tab
    And User selects "Internal Active User Second" value for Default Reviewer
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks on "World Check Ongoing Screening Update" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "World Check Ongoing Screening Update" activity
    Then Alert Icons are displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43905281
  Scenario Outline: C43905281: Activity Information Page - Activity with Multiple Approver - Activity Approver becomes inactive: Method 'All' or 'Any'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Approver" tab
    And User fills "<approverMethod>" in Approver details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    And Toast message is not displayed
    And Activity Information Invalid label is displayed for user "Internal Active User First"
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    Examples:
      | approverMethod                                     |
      | Activity Owner Division Multiple created users ALL |
      | Activity Owner Division Multiple created users ANY |

  @C43691405
  Scenario: C43691405: Assign Questionnaire - Onboarding - Reviewer Questionnaire Page - Assigned reviewer becomes Inactive user
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userFirstName" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User deactivates users records with name reference "userFirstName" via API
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Toast message is not displayed
    When User clicks 'Change Reviewer' link
    And User selects reviewer "Admin_AT_FN Admin_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C43958690
  Scenario Outline: C43958690: Activity Information Page - Activity with Multiple Reviewer - Activity Reviewer becomes inactive: Method 'All' or 'Any'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Reviewer" tab
    And User fills "<approverMethod>" in Reviewer details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Toast message is not displayed
    And Activity Information Invalid label is displayed for user "Internal Active User First"
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    Examples:
      | approverMethod                                     |
      | Activity Owner Division Multiple created users ALL |
      | Activity Owner Division Multiple created users ANY |

  @C44062452
  Scenario: C44062452: Assign Questionnaire - Ad Hoc - Reviewer Questionnaire Page - Assigned reviewer becomes Inactive user
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userFirstName" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User deactivates users records with name reference "userFirstName" via API
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Activity Information page is displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    And User clicks "Review" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Toast message is not displayed
    When User clicks 'Change Reviewer' link
    And User selects reviewer "Admin_AT_FN Admin_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                | Reviewer                | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | 0     |

  @C44065026
  Scenario: C44065026: Questionnaire Assigned - Onboarding - No warning message of Inactive User/Different Division for Reviewer is displayed
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userFirstName" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User deactivates users records with name reference "userFirstName" via API
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    Then Toast message is not displayed
    When User clicks "Answer" button for Activity "AUTO_TEST_INTERNAL_QUESTIONNAIRE" in Questionnaire Details table
    Then Toast message is not displayed

  @C44065308
  Scenario: C44065308: Questionnaire Assigned - Ad Hoc - No warning message of Inactive User/Different Division for Reviewer is displayed
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with workflow group" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userFirstName" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User deactivates users records with name reference "userFirstName" via API
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Toast message is not displayed
    When User for questionnaire "AUTO_TEST_INTERNAL_QUESTIONNAIRE" clicks link "Answer"
    Then Toast message is not displayed

  @C44938577
  Scenario: C44938577: Assign Questionnaire - Onboarding - Reviewer Questionnaire Page - Member of the User Group becomes Inactive User
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to Group Management page
    And User creates new User Group "active user group" via API
    And User refreshes page
    And User clicks "Edit" icon for the created User Group
    And User clicks cross control button for User Group member "Admin_AT_FN Admin_AT_LN"
    And User selects in "Members" User Group value "Internal Active User First"
    And User selects in "Members" User Group value "Internal Active User Second"
    And User clicks "Save" Group form page button
    And User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User fills "toBeReplaced" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User clicks 'Assign Questionnaire' Activity Information button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status    | Assignee                | Reviewer     | Score |
      | questionnaireNameContext | Submitted | Admin_AT_FN Admin_AT_LN | toBeReplaced | 0     |
    When User clicks "Review" button for Activity "toBeReplaced" in Questionnaire Details table
    Then Toast message is not displayed
    When User clicks 'Change Reviewer' link
    And User selects reviewer "Internal Active User Second" for Reviewer Flow for level "1"
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Toast message is not displayed
    When User selects reviewer "Internal Active User First" for Reviewer Flow for level "1"
    Then Toast message is not displayed
    When User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status    | Assignee                | Reviewer                   | Score |
      | questionnaireNameContext | Submitted | Admin_AT_FN Admin_AT_LN | Internal Active User First | 0     |

  @C44938580
  Scenario: C44938580: Assign Questionnaire - Ad Hoc - Reviewer Questionnaire Page - Member of the User Group becomes Inactive User
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to Group Management page
    And User creates new User Group "active user group" via API
    And User refreshes page
    And User clicks "Edit" icon for the created User Group
    And User clicks cross control button for User Group member "Admin_AT_FN Admin_AT_LN"
    And User selects in "Members" User Group value "Internal Active User First"
    And User selects in "Members" User Group value "Internal Active User Second"
    And User clicks "Save" Group form page button
    And User navigates to Add Questionnaire Management page
    And User fills "with only random name" required questionnaire setup information
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Reviewers "Rules" tab
    And User selects "User Group" as Main Reviewer
    And User fills "toBeReplaced" value as Main Reviewer
    And User clicks Questionnaire Setup button "Next"
    And User adds question with type "Boolean" to active tab
    And User clicks Questionnaire Setup button "Next"
    And User clicks Questionnaire Setup button "Save"
    And User creates third-party "with questionnaire workflow" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "toBeReplaced" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Admin_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Activity Information page is displayed
    When User for questionnaire "questionnaireNameContext" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status    | Assignee                | Reviewer     | Score |
      | questionnaireNameContext | Submitted | Admin_AT_FN Admin_AT_LN | toBeReplaced | 0     |
    When User clicks "Review" button for Activity "toBeReplaced" in Questionnaire Details table
    Then Toast message is not displayed
    When User clicks 'Change Reviewer' link
    And User selects reviewer "Internal Active User Second" for Reviewer Flow for level "1"
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    And Toast message is not displayed
    When User selects reviewer "Internal Active User First" for Reviewer Flow for level "1"
    Then Toast message is not displayed
    When User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status    | Assignee                | Reviewer                   | Score |
      | questionnaireNameContext | Submitted | Admin_AT_FN Admin_AT_LN | Internal Active User First | 0     |

  @C50858509
  Scenario: C50858509: Activity Information Page - Activity with Multiple Approver - Activity Approver becomes inactive: Method 'In Sequence'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity" details
    And User clicks Activity "Add Approver" tab
    And User fills "Activity Owner Division Multiple created users IN SEQUENCE" in Approver details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed
    And Activity Information Invalid label is displayed for user "Internal Active User First"
    And Activity Information Invalid label is not displayed for user "Internal Active User Second"

  @C50858576
  Scenario: C50858576: Activity Information Page - Activity with Multiple Reviewer - Activity Reviewer becomes inactive: Method 'In Sequence'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple created users IN SEQUENCE |
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed
    And Activity Information Invalid label is displayed for user "Internal Active User First"
    And Activity Information Invalid label is not displayed for user "Internal Active User Second"

  @C43503636
  Scenario: C43503636: Activity Information Page - Activity with Reviewer - Ad Hoc - Activity Reviewer becomes inactive
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User fills in "Reviewer" drop-down with "userFirstName"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User deactivates users records with name reference "userFirstName" via API
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Alert Icons are displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43503640
  Scenario: C43503640: Activity Information Page - Activity with Reviewer - Ad hoc - Both Activity Assignee and Reviewer becomes inactive
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Internal Active User First"
    And User clicks Ad Hoc Activity "Save" button
    And User fills in "Reviewer" drop-down with "Internal Active User Second"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User deactivates users records with name reference "Internal Active User First" via API
    And User deactivates users records with name reference "Internal Active User Second" via API
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Alert Icons are displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43503633
  Scenario: C43503633: Activity Information Page - Activity Assignee - Ad hoc - Activity Assignee becomes inactive
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "AUTO_TEST_SIMPLE_ACTIVITY_TYPE"
    And User fills in "Activity Name" field with "AUTO_TEST_ACTIVITY_NAME"
    And User fills in "Description" field with "AUTO_TEST_DESCRIPTION"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "userFirstName"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks Ad Hoc Activity "Back" button
    And User deactivates users records with name reference "userFirstName" via API
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Alert Icon is displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
    And Toast message is not displayed
