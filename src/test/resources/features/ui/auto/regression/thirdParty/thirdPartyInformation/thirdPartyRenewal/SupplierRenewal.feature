@ui @supplier_renewal
Feature: Third-party Information - Third-party Renewal

  As a Supplier Integrity User
  I want the system to change the status of Suppliers that are for Renewal
  So that their Renewal process can be started accordingly

  Background:
    Given User logs into RDDC as "Admin"

  @C35916043
  @core_regression
  Scenario: C35916043: Supplier Renewal - check 'Next Renewal Date' field
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "New Component" component tab
    And User clicks on "Approve Onboarding" activity
    Then Activity Information page is displayed
    When User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    And Next Renewal Date should be EMPTY
    When User clicks Assessment Details section "Edit" button
    When User updates Renewal Cycle with value "1"
    And User clicks Assessment Details section "Save" button
    Then Next Renewal Date should be TODAY+1

  @C35929825
  @full_regression
  Scenario: C35929825: Supplier Renewal - check the Renewal Start Date/Next Renewal Date fields date format of the Renewing/For Renewal and Onboarded Suppliers
    When User navigates to Preferences page
    Then System Setting Date Format is "Month Day Year"
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Workflow Table is displayed
    When User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks "New Component" component tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    When User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    Then Onboarding Start Date should be TODAY+0
    When User clicks "Renew" for third-party
    Then Renewal Start Date field should be shown
    And Renewal Start Date should be TODAY+0
    When User clicks "New Component" component tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Third-party's element "Offboard" should be shown
    And Onboarding Start Date field should be shown
    And Onboarding Start Date should be TODAY+0
    And Next Renewal Date should be TODAY+0

  @C35929772
  @full_regression @core_regression
  Scenario: C35929772 [Supplier Renewal] - check the trigger of Renewal Workflow - with Workflow
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
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
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    And Third-party's onboarding workflow should be shown - "Auto Workflow Renewal Workflow Low Risk"
    And Third-party's onboarding workflow description should be shown - "Renewal Workflow for automation test with For Renewal status"

  @C35929528
  @full_regression
  Scenario: C35929528 [Supplier Renewal] - verify that user without proper permission cannot Start/Stop/Decline renewal process
    When User creates third-party "with renewal workflow Norway" via API and open it
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
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Home page
    And User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "User without Onboarding and Renewal accesses"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    Then Renew button should be invisible
    When User navigates to Home page
    And User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    And User navigates to Home page
    And User clicks Log Out button
    Then Login page is loaded
    When User logs into RDDC as "User without Onboarding and Renewal accesses"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "RENEWING"
    When User clicks on created third-party
    Then Third-party's status should be shown - "RENEWING"
    And Decline Renewal button should be invisible
    And Stop Renewal button should be invisible

  @C35927885
  @full_regression
  Scenario: C35927885: Supplier Renewal - check the start/stop/decline of the Renewal Process
    When User creates third-party "with renewal workflow Norway" via API and open it
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "NEW"
    When User clicks on created third-party
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
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    Then Third-party's element "Renew" should be shown
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    And "Renew" button should disappear
    And Button "Decline Renewal" should be displayed and active on Third-party page
    And Button "Stop Renewal" should be displayed and active on Third-party page
    And Renewal Start Date field should be shown
    And Renewal Start Date should be TODAY+0
    And Onboarded Decision Date field should be hidden
    When User clicks "Stop Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to stop the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Renewal Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "FOR RENEWAL"
    And Renewal Start Date field should be hidden
    And "Stop Renewal" button should disappear
    And "Decline Renewal" button should disappear
    Then Third-party's element "Renew" should be shown
    And Onboarding Activities section is not displayed
    When User clicks "Renew" for third-party
    And User clicks "Decline Renewal" for third-party
    Then Message is displayed on confirmation window
      | Are you sure you want to decline the Renewal Process?                           |
      | This cannot be undone and you will have to restart the Onboarding Process again |
    When User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "RENEWAL DENIED"
    And Onboarded Decision Date field should be hidden
    And Renewal Denied Date should be TODAY+0
    And "Stop Renewal" button should disappear
    And "Decline Renewal" button should disappear
    And Third-party's element "Start Onboarding" should be shown
    And Onboarding Activities section is not displayed

  @C35929368
    @full_regression
    @onlySingleThread
    @email
  Scenario Outline: C35929368 Supplier Renewal - Default Renewal Assignee - check Email Notification for Supplier(s) that is pending for renewal - Default assignee
    When User clicks Set Up option
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    Then Renewal Settings page is displayed
    When User clicks "<assigneeType>" default assignee radio button
    And User selects "<assigneeValue>" for "<assigneeType>" in Default Assignee dropdown
    And User clicks Renewal Settings Save button
    Then Alert Icon is displayed with text
      | Success!                       |
      | Renewal Setup has been updated |
    When User creates third-party "with renewal workflow Norway" via API and open it
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
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    And Email notification for template "Third-party Pending for Renewal" is received by "Admin" user
    And Email received by "Admin" user with template "Third-party Pending for Renewal" contains created today third party in For Renewal status
    And Email received by "Admin" user with template "Third-party Pending for Renewal" contains links to Third-parties profiles
    Examples:
      | assigneeType | assigneeValue           |
      | User         | Admin_AT_FN Admin_AT_LN |
      | User Group   | AUTO_GROUP              |

  @C35927838
  @full_regression
  Scenario: C35927838: Supplier Renewal - verify update of the Supplier Status to 'For Renewal'
  If Workflow Renewal Trigger Setup is set by 'Next Renewal Date'
    When User creates third-party "with renewal workflow Norway" via API and open it
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
    And User navigates to Third-party page
    And User searches created third-party
    Then Third-party should have status "FOR RENEWAL"
    When User clicks on created third-party
    Then Third-party's element "Renew" should be shown
    And Assessment section field "Next Renewal Date" is not displayed

  @C37590756
  @full_regression
  Scenario: C37590756: Supplier - Dashboard - View Third-party for Renewal Widget and Bell Notification
    When User creates third-party "with renewal workflow Norway" via API and open it
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
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    Then Email notification for template "Third-party Pending for Renewal" is received by "Admin" user
    When User navigates to Home page
    Then Home page is loaded
    When User clicks 'Third-party for Renewal' widget
    Then Dashboard Third-party for Renewal table is displayed with column names
      | THIRD-PARTY NAME | STATUS | RESPONSIBLE PARTY | RENEWAL ASSIGNEE | RENEWAL DATE |
    When Users clicks "Renewal Date" dashboard table column header
    Then "Third-party for Renewal" table displays records sorted by "Renewal Date" in "DESC" order
    And Third-party for Renewal table contains third-party
      | THIRD-PARTY NAME | STATUS      | RESPONSIBLE PARTY       | RENEWAL ASSIGNEE        | RENEWAL DATE |
      | toBeReplaced     | FOR RENEWAL | Admin_AT_FN Admin_AT_LN | Admin_AT_FN Admin_AT_LN | TODAY+0      |
    When User clicks Notification Bell
    Then The list with notifications is shown
    When User clicks "Third-party Pending for Renewal" "thirdPartyName" notification
    Then Third-party Information tab is loaded

  @C37821372
  @full_regression
  Scenario: C37821372: Third-party Renewal - check the trigger of Renewal Workflow
    When User creates third-party "with renewal workflow Norway" via API and open it
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
    And Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    And Third-party's onboarding workflow should be shown - "Auto Workflow Renewal Workflow Low Risk"
    And Third-party's onboarding workflow description should be shown - "Renewal Workflow for automation test with For Renewal status"
    And Button "Decline Renewal" should be displayed and active on Third-party page
    When User clicks "Stop Renewal" for third-party
    And User clicks Yes button on confirmation window
    Then Confirmation window is disappeared
    And Third-party's status should be shown - "FOR RENEWAL"
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Country |
      | China   |
    And User clicks General and Other Information section "Save" button
    And User waits for progress bar to disappear from page
    And User clicks "Renew" for third-party
    Then Alert Icon is displayed with text
      | There is no workflow available. Please contact your administrator. |