@ui @full_regression @supplier_renewal
Feature: Third-party Information - Third-party Renewal with rules

  As a Supplier Integrity User
  I want the system to change the status of Suppliers that are for Renewal with certain rules
  So that their Renewal process can be started accordingly to the rules

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks Workflow Management Renewal Settings submenu in Set Up menu
    Then Renewal Settings page is displayed
    When User deletes previously created rule "2"
    And User clicks "User" default assignee radio button
    And User selects "Assignee_AT_FN Assignee_AT_LN" for "User" in Default Assignee dropdown
    And User deletes values for rule "0"
    And User selects rule "Third-party Country"

  @C35929424
  @email
  Scenario: C35929424(1) Supplier Renewal - Renewal Assignee based on rules - Supplier satisfies a Renewal Assignee Rule
    When User selects for rule "1" value "Norway"
    And User selects Assignee Rule "User" radio button of last added rule
    And User selects for rule "1" assignee "Admin_AT_FN Admin_AT_LN"
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
    Then Email notification for template "Third-party Pending for Renewal" is received by "Admin" user
    And Email received by "Admin" user with template "Third-party Pending for Renewal" contains created today third party in For Renewal status
    And Email received by "Admin" user with template "Third-party Pending for Renewal" contains links to Third-parties profiles

  @C35929424
  @onlySingleThread
  @email
  Scenario: C35929424(2) Supplier Renewal - Renewal Assignee based on rules - Supplier satisfies more than one Renewal Assignee Rule
    When User selects for rule "1" value "Norway"
    And User selects Assignee Rule "User" radio button of last added rule
    And User selects for rule "1" assignee "Admin_AT_FN Admin_AT_LN"
    And User makes sure that Assignee Rule with default setup is added
    And User selects rule "Third-party Workflow Group"
    And User selects for rule "2" value "Auto Workflow Renewal"
    And User selects Assignee Rule "User Group" radio button of last added rule
    And User selects for rule "2" assignee "AUTO_GROUP"
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
    Then Email notification for template "Third-party Pending for Renewal" is received by "Admin" user
    And Email received by "Admin" user with template "Third-party Pending for Renewal" contains created today third party in For Renewal status
    And Email received by "Admin" user with template "Third-party Pending for Renewal" contains links to Third-parties profiles

  @C35929424
  @email
  Scenario: C35929424(3) Supplier Renewal - Renewal Assignee based on rules - Supplier does not satisfy a Renewal Assignee Rule
    When User selects for rule "1" value "Ukraine"
    And User selects Assignee Rule "Responsible Party" radio button of last added rule
    And User selects for rule "1" assignee "not applicable"
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
    And User refreshes page
    Then Third-party's status should be shown - "FOR RENEWAL"
    And Email notification for template "Third-party Pending for Renewal" is received by "Assignee" user
    And Email received by "Assignee" user with template "Third-party Pending for Renewal" contains created today third party in For Renewal status
    And Email received by "Assignee" user with template "Third-party Pending for Renewal" contains links to Third-parties profiles
