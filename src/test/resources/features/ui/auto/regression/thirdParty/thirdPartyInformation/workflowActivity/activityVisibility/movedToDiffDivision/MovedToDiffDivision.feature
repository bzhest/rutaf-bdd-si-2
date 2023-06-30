@ui @core_regression @activity_details
Feature: Third-party Information - Workflow Activity - Activity Visibility - Move to Different Division

  As a user
  I want to see a warning message when the assignee of the activity become inactive.
  So that I can reassign an activity to other active internal user.

  Background:
    Given User logs into RDDC as "Assignee"
    When User makes sure that Custom field "Billing Entity" is set as required via API


  @C43411770
  Scenario: C43411770: Activity Information Page - Activity with Approver - Activity Approver moved to different division from TP division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
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
    And User updates user "userFirstName" Division with value "MyDivision" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    And Toast message is not displayed
    And Activity Information Invalid label is displayed for user "userFirstName"

  @C43958691
  Scenario Outline: C43958691: Activity Information Page - Activity with Multiple Reviewer - Activity Reviewer moved to different division from TP division: Method 'All' or 'Any'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | <approverMethod> |
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
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
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    Examples:
      | approverMethod                                                |
      | Activity Owner Division Operations Multiple created users ALL |
      | Activity Owner Division Operations Multiple created users ANY |

  @C50861757
  Scenario: C50861757: Activity Information Page - Activity with Multiple Reviewer - Activity Reviewer moved to different division from TP division: Method 'In Sequence'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Ukraine" with Activity "Assessment Activity" with Reviewer "" with Reviewer rules
      | Activity Owner Division Multiple created users IN SEQUENCE |
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
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

  @C50872858
  Scenario: C50872858: Activity Information Page - Activity with Approver - Both Activity Assignee and Approver moved to different division from TP division
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
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
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "World Check Ongoing Screening Update" activity
    Then Alert Icons are displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43411762
  Scenario: C43411762: Activity Information Page - Activity Assignee - Activity Assignee moved to different division from TP division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
    And User fills in "First Name" Add User value "toBeReplaced"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "World Check Ongoing Screening Update Activity with created user assignee"
    And User updates user "userFirstName" Division with value "MyDivision" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "World Check Ongoing Screening Update" activity
    Then Alert Icon is displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
    And Toast message is not displayed

  @C43411765
  Scenario: C43411765: Activity Information Page - Activity with Reviewer - Both Activity Assignee and Reviewer moved to different division from TP division
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
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
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User creates third-party "with workflow group" via API and open it
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

  @C43411766
  Scenario: C43411766: Activity Information Page - Activity with Reviewer - Activity Reviewer moved to different division from TP division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Assessment Activity With Assignee User" with Reviewer "userFirstName"
    And User updates user "userFirstName" Division with value "MyDivision" via API
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

  @C43411771
  Scenario: C43411771: Activity Information Page - Activity with Reviewer - Ad hoc - Both Activity Assignee and Reviewer moved to a different Division from TP division
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User creates third-party "with random ID name" via API and open it
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
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Alert Icons are displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43503634
  Scenario: C43503634: Activity Information Page - Activity Assignee - Ad hoc - Activity Assignee becomes moved to a different Division from TP division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
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
    And User updates user "userFirstName" Division with value "MyDivision" via API
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Alert Icon is displayed with text
      | Either the assignee does not have the same division as the third party or the assignee is not set to active. Please update and try again. |
    And Toast message is not displayed

  @C43503638
  Scenario: C43503638: Activity Information Page - Activity with Reviewer - Ad Hoc - Activity Reviewer moved to a different Division from TP division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
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
    And User fills in Assignee drop-down with "Assignee_AT_FN Assignee_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User fills in "Reviewer" drop-down with "userFirstName"
    And User clicks Done button in Activity Reviewers section
    And User clicks Back button to return from Activity modal
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User updates user "userFirstName" Division with value "MyDivision" via API
    And User clicks on added Ad Hoc Activity in Ad Hoc Activity table
    Then Alert Icons are displayed with text
      | Either the reviewer does not have the same division as the third party or the reviewer is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed

  @C43905282
  Scenario Outline: C43905282: Activity Information Page - Activity with Multiple Approver - Activity Approver moved to different division from TP division: Method 'All' or 'Any'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity With Assignee User" details
    And User clicks Activity "Add Approver" tab
    And User fills "<approverMethod>" in Approver details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    And Toast message is not displayed
    And Activity Information Invalid label is displayed for user "Internal Active User First"
    And Activity Information Invalid label is displayed for user "Internal Active User Second"
    Examples:
      | approverMethod                                                |
      | Activity Owner Division Operations Multiple created users ALL |
      | Activity Owner Division Operations Multiple created users ANY |

  @C50858542
  Scenario: C50858542: Activity Information Page - Activity with Multiple Approver - Activity Approver moved to different division from TP division: Method 'In Sequence'
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks Add Workflow button
    And User fills in workflow details data "Automation Onboarding Workflow With Risk Scoring For Norway"
    And User clicks workflow button "Next"
    And User clicks Add Wizard Component button
    And User clicks +Add Activity button
    And User fills in Activity "Assessment Activity With Assignee User" details
    And User clicks Activity "Add Approver" tab
    And User fills "Activity Owner Division Multiple created users IN SEQUENCE" in Approver details for 1 rule section
    And User clicks workflow button "Done"
    And User clicks Save button for Workflow
    And User updates user "Internal Active User First" Division with value "MyDivision" via API
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assessment Activity" activity
    Then Alert Icon is displayed with text
      | Either the approver does not have the same division as the third party or the approver is not set to active. Please update and try again. |
    When User clicks all Close alert icon buttons
    Then Toast message is not displayed
    And Activity Information Invalid label is displayed for user "Internal Active User First"
    And Activity Information Invalid label is not displayed for user "Internal Active User Second"

  @C43691701
  Scenario: C43691701: Assign Questionnaire - Onboarding - Reviewer Questionnaire Page - Assigned reviewer moved to different division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
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
    And User selects "Assignee_AT_FN Assignee_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userFirstName" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User updates user "userFirstName" Division with value "MyDivision" via API
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
    And User selects reviewer "Assignee_AT_FN Assignee_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                      | Reviewer                      | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Assignee_AT_FN Assignee_AT_LN | Assignee_AT_FN Assignee_AT_LN | 0     |

  @C44062453
  Scenario: C44062453: Assign Questionnaire - Ad Hoc - Reviewer Questionnaire Page - Assigned reviewer moved to different division
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "Operations"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "Assignee_AT_FN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userFirstName" overall reviewer
    And User clicks "Finish" Assign Questionnaire dialog button
    And User updates user "userFirstName" Division with value "MyDivision" via API
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
    And User selects reviewer "Assignee_AT_FN Assignee_AT_LN" for Reviewer Flow for level "1"
    And User clicks button Save on Questionnaire tab for Reviewer Flow
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name               | Status    | Assignee                      | Reviewer                      | Score |
      | AUTO_TEST_INTERNAL_QUESTIONNAIRE | Submitted | Assignee_AT_FN Assignee_AT_LN | Assignee_AT_FN Assignee_AT_LN | 0     |

  @C44938259
  Scenario: C44938259: Assign Questionnaire - Onboarding - Reviewer Questionnaire Page - Member of the User Group moved to different division
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User navigates to Group Management page
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
    And User selects "Assignee_AT_FN Assignee_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User clicks Back button to return from Activity modal
    And User clicks on "Questionnaire Assigned" activity
    And User clicks "Answer" button for Activity "toBeReplaced" in Questionnaire Details table
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on "Assign Questionnaire" activity
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status    | Assignee                      | Reviewer     | Score |
      | questionnaireNameContext | Submitted | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | 0     |
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
      | Questionnaire Name       | Status    | Assignee                      | Reviewer                   | Score |
      | questionnaireNameContext | Submitted | Assignee_AT_FN Assignee_AT_LN | Internal Active User First | 0     |

  @C44938576
  Scenario: C44938576: Assign Questionnaire - Ad Hoc - Reviewer Questionnaire Page - Member of the User Group moved to different division
    When User creates internal user with data "Internal Active User First"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User creates internal user with data "Internal Active User Second"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User updates user "Internal Active User First" Division with value "Operations" via API
    And User updates user "Internal Active User Second" Division with value "Operations" via API
    And User navigates to Group Management page
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
    And User selects "Assignee_AT_FN Assignee_AT_LN" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    And User updates user "Internal Active User Second" Division with value "MyDivision" via API
    And User clicks on the newly created Ad Hoc Activity with name "Internal Questionnaire for"
    Then Activity Information page is displayed
    When User for questionnaire "questionnaireNameContext" clicks link "Answer"
    And User clicks on "Submit" button while giving an answer on Questionnaire form page
    And User clicks Back button to return from Activity modal
    And User clicks on the newly created Ad Hoc Activity with name "Assign Questionnaire"
    Then Questionnaire Details table should contain following questionnaires
      | Questionnaire Name       | Status    | Assignee                      | Reviewer     | Score |
      | questionnaireNameContext | Submitted | Assignee_AT_FN Assignee_AT_LN | toBeReplaced | 0     |
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
      | Questionnaire Name       | Status    | Assignee                      | Reviewer                   | Score |
      | questionnaireNameContext | Submitted | Assignee_AT_FN Assignee_AT_LN | Internal Active User First | 0     |
