@ui @full_regression @value_management @alamid
Feature: Value Management

  As a user
  I want to setup values
  So they can meet the requirements of the Organisation

  @C45550066
  Scenario: C45550066 - [Value Management Setup] Permissions
    Given User logs into RDDC as "Admin"
    When User saves Activity type id to context
    And User clicks Set Up option
    Then Setup navigation option "Value Management" is displayed
    When User logs into RDDC as "restricted"
    And User clicks Set Up option
    Then Setup navigation option "Value Management" is not displayed
    When User navigates to Value Management page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to 'Value Management' activity type
    Then Current URL contains "/forbidden" endpoint