@ui @suppliers @robusta
Feature: Third-party Information - Edit Third-party

  As a Supplier Integrity User
  I want I want to be able to create new Suppliers
  So that I can process the Suppliers that need to be Onboarded for the Organisation

  Background:
    Given User logs into RDDC as "Admin"

  @C38363984
  @full_regression
  Scenario: C38363984: Third Party- Edit Third Party - General Information section -  Edit icon absent for "ONBOARDING" status
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed

  @C38363984
  @full_regression
  Scenario: C38363984: Third Party- Edit Third Party - General Information section -  Edit icon absent for "RENEWING" status
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
    Then Workflow "Auto Workflow Renewal Workflow Low Risk" is updated with type "Renewal"
    When User opens previously created Third-party
    Then Third-party's status should be shown - "FOR RENEWAL"
    When User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed
    When User navigates to Third-party page
    And User searches created third-party
    And User clicks 'Edit' button on created third-party
    Then General and Other Information section is not allowed for editing, as edit icon is disabled
    And General and Other Information button "Save" is not displayed
    And General and Other Information button "Cancel" is not displayed

  @C38363922
  @full_regression
  Scenario: C35619360: Third Party- Edit Third Party - General Information section - Validation for Reference Number
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User opens third-party creation form
    And User fills third-party creation form with third-party's test data "with Complete Details"
    And User submits Third-party creation form
    Then User verifies third-party is created
    When User navigates to Third-party page
    And User searches third-party by reference "workflowGroupUkraine"
    And User clicks third-party with reference "workflowGroupUkraine"
    And User clicks General and Other Information section "Edit" button
    And User fills in Reference No. existing data
    Then Error message "Reference No. already exists" in red color is displayed on Reference No. field
    And General and Other Information button "Save" is disabled
    And General and Other Information button "Cancel" is enabled

  @C38368254
  @full_regression
  Scenario: C38368254: Third Party - Edit Third Party - General Information section -  Edit icon absent if no permissions (status NEW)
    When User creates third-party "workflowGroupUkraine" via API and open it
    Then Third-party's status should be shown - "NEW"
    When User logs into RDDC as "restricted"
    And User opens previously created Third-party
    Then Third-party's status should be shown - "NEW"
    And General and Other Information section is not allowed for editing, as edit icon is disabled

  @C38368254
  @full_regression
  Scenario: C38368254: Third Party - Edit Third Party - General Information section -  Edit icon absent if no permissions (status ONBOARDING)
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User logs into RDDC as "restricted"
    And User opens previously created Third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And General and Other Information section is not allowed for editing, as edit icon is disabled

  @C38368254
  @full_regression
  Scenario: C38368254: Third Party - Edit Third Party - General Information section -  Edit icon absent if no permissions (status ONBOARDED)
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks on "Assign Questionnaire" activity
    And User approves all activities
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    And User waits for progress bar to disappear from page
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User selects activity assessment
    And User clicks 'Save' activity button
    Then Third-party's status should be shown - "ONBOARDED"
    When User logs into RDDC as "restricted"
    And User opens previously created Third-party
    Then Third-party's status should be shown - "ONBOARDED"
    And General and Other Information section is not allowed for editing, as edit icon is disabled

  @C38368254
  @full_regression
  Scenario: C38368254: Third Party - Edit Third Party - General Information section -  Edit icon absent if no permissions (status FOR RENEWAL)
    When User navigates to Workflow Management Renewal Settings page
    Then Renewal Settings page is displayed
    When User clicks "Responsible Party" default assignee radio button
    And User clicks Renewal Settings Save button
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "NEW COMPONENT" tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    Then Workflow "toBeReplaced" is updated with type "Renewal"
    When User opens previously created Third-party
    Then Third-party's status should be shown - "FOR RENEWAL"
    When User logs into RDDC as "restricted"
    And User opens previously created Third-party
    Then Third-party's status should be shown - "FOR RENEWAL"
    And General and Other Information section is not allowed for editing, as edit icon is disabled