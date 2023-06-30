@ui @full_regression @workflow_management
Feature: Workflow Management - Role Implementation

  As a Supplier Integrity Administrator
  I want to be able to limit the access to the Workflow Management Module
  So that only the authorized users will be able to manage the Workflow setups in the system

  @C35771742
  Scenario: C35771742: Workflow Management - Role Implementation
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User searches role by "AUTO TEST ROLE WITH RESTRICTIONS" keyword
    And User clicks 'Edit' button on searched role "AUTO TEST ROLE WITH RESTRICTIONS"
    And User fills setUp block with "disable workflow management" data
    And User clicks 'Submit' Role Management button
    And User logs into RDDC as "Restricted"
    And User clicks Set Up option
    Then Workflow Management module is hidden
    When User navigates to 'Workflow Management' block 'Workflow' section
    Then Current URL contains "/forbidden" endpoint
    When User navigates to 'Workflow Management' block 'Groups' section
    Then Current URL contains "/forbidden" endpoint
    When User navigates to Workflow Management Renewal Settings page
    Then Current URL contains "/forbidden" endpoint
    When User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'Role' section
    And User searches role by "AUTO TEST ROLE WITH RESTRICTIONS" keyword
    And User clicks 'Edit' button on searched role "AUTO TEST ROLE WITH RESTRICTIONS"
    And User fills setUp block with "enable workflow management" data
    And User clicks 'Submit' Role Management button
    And User logs into RDDC as "Restricted"
    And User clicks Set Up option
    Then Workflow Management module is displayed