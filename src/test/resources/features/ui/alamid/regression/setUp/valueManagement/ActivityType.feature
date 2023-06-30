@ui @alamid @value_management @activity_type
Feature: Value Management - Activity Type

  As a RDDC Administrator
  I want see the Approve/Decline Onboarding Activity Type Configured in the system
  So that I can review the Activity Type when needed

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User opens Value Management page
    And User clicks "Activity Type" value
    And User selects "Max" items per page

  @C54121480
  @full_regression
  Scenario: C54121480: Value Management - Activity Type - Cancel Update on Approve Onboarding Activity Type
    When User clicks Edit button for "Approve Onboarding" Value Row
    And User clicks Add button for Value
    Then Value Management Assessment field contains close icon for 1 field
    And Value Management Add icon is disabled
    When User fills in Assessment field on position 1 value "Approve_Assessment_1"
    Then Value Management Add icon is enabled
    When User clicks Assessment field on position 1 close icon
    Then Value management Assessment field is invisible
    And Value Management Add icon is enabled
    When User adds 20 Assessment fields with name "Approve_Assessment_"
    Then Value Management Add icon is disabled
    When User clicks "Cancel" Value Management button
    Then Value Management "Activity Type" overview page is displayed

  @C54121479
  @core_regression
  Scenario: C54121479: Value Management - Activity Type - Allow user to add assessment in Approve Onboarding Activity
    When User clicks Edit button for "Approve Onboarding" Value Row
    Then Add Activity Type modal contains all expected elements
    And Activity Type Name field is disabled
    When User clicks Add button for Value
    And User fills in Assessment field on position 1 value "Approve_Assessment_1"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Activity Type has been updated |
    And Value Management "Activity Type" overview page is displayed

  @C54121484
  @full_regression
  Scenario: C54121484: Value Management - Activity Type - Cancel Update on Decline Onboarding Activity Type
    When User clicks Edit button for "Decline Onboarding" Value Row
    And User clicks Add button for Value
    Then Value Management Assessment field contains close icon for 1 field
    And Value Management Add icon is disabled
    When User fills in Assessment field on position 1 value "Decline_Assessment_1"
    Then Value Management Add icon is enabled
    When User clicks Assessment field on position 1 close icon
    Then Value management Assessment field is invisible
    And Value Management Add icon is enabled
    When User adds 20 Assessment fields with name "Decline_Assessment_"
    Then Value Management Add icon is disabled
    When User clicks "Cancel" Value Management button
    Then Value Management "Activity Type" overview page is displayed

  @C54121483
  @core_regression
  Scenario: C54121483: Value Management - Activity Type - Allow user to add assessment in Decline Onboarding Activity
    When User clicks Edit button for "Decline Onboarding" Value Row
    Then Add Activity Type modal contains all expected elements
    And Activity Type Name field is disabled
    When User clicks Add button for Value
    And User fills in Assessment field on position 1 value "Decline_Assessment_1"
    And User clicks "Save" Value Management button
    Then Alert Icon is displayed with text
      | Success! Activity Type has been updated |
    And Value Management "Activity Type" overview page is displayed