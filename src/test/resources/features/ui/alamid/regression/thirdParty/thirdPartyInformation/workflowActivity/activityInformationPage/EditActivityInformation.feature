@ui @core_regression @suppliers @alamid @activity_information
Feature: Edit Activity Information

  Background:
    Given User logs into RDDC as "Admin"

  @C54258455
  Scenario: C54258455 : Activity Information Page - Onboarding - Display Approve Onboarding Activity assessment on Assessment dropdown when available
    When User updates Activity Type "Approve Onboarding" with following assessments via API
      | Approved with Conditions_2 |
    And User creates new Workflow "Onboarding Workflow Medium" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Approve Onboarding" activity row button
    Then Activity Assessment drop-down contains all "Approve Onboarding" activity assessments
    When User selects activity Assessment "Approved with Conditions_2"
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Third-party's status should be shown - "ONBOARDED"

  @C54258456
  Scenario: C54258456 : Activity Information Page - Onboarding - Display Decline Onboarding Activity assessment on Assessment dropdown when available
    When User updates Activity Type "Decline Onboarding" with following assessments via API
      | Insufficient Requirements_2 |
    And User creates new Workflow "Onboarding Workflow Medium" with Activity "Decline Onboarding Activity"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Decline Onboarding" activity row button
    Then Activity Assessment drop-down contains all "Decline Onboarding" activity assessments
    When User selects activity Assessment "Insufficient Requirements_2"
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Third-party's status should be shown - "ONBOARDING DENIED"

  @C54527734
  Scenario: C54527734 : Activity Information Page - Onboarding - Approve Onboarding Activity Assessment is not mandatory when saving to Done when assessment is available
    When User updates Activity Type "Approve Onboarding" with following assessments via API
      | Approved with Conditions_3 |
    And User creates new Workflow "Onboarding Workflow Medium" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Approve Onboarding" activity row button
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Third-party's status should be shown - "ONBOARDED"

  @C54527735
  Scenario: C54527735 : Activity Information Page - Onboarding - Decline Onboarding Activity Assessment is not mandatory when saving to Done when assessment is available
    When User updates Activity Type "Decline Onboarding" with following assessments via API
      | Insufficient Requirements_3 |
    And User creates new Workflow "Onboarding Workflow Medium" with Activity "Decline Onboarding Activity"
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Decline Onboarding" activity row button
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Third-party's status should be shown - "ONBOARDING DENIED"

  @C54527729
  Scenario: C54527729 : Activity Information Page - Onboarding - Newly added Approve Onboarding assessments are displayed on Activity Information page when the workflow has been commited with new version.
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Approve Onboarding Activity"
    And User updates Activity Type "Approve Onboarding" with following assessments via API
      | Approved with Conditions_4 |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Approve Onboarding" activity row button
    Then Activity Assessment drop-down does not contains all "Approve Onboarding" activity assessments
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User navigates to Third-party page
    Then Third-party with name "toBeReplaced" is displayed in Third-party overview table
    When User clicks on created third-party
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Approve Onboarding" activity row button
    Then Activity Assessment drop-down contains all "Approve Onboarding" activity assessments
    When User selects activity assessment
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Third-party's status should be shown - "ONBOARDED"

  @C54527730
  Scenario: C54527730 : Activity Information Page - Onboarding - Newly added Decline Onboarding assessments are displayed on Activity Information page when the workflow has been commited with new version.
    When User creates new Workflow "Onboarding Workflow Medium" with Activity "Decline Onboarding Activity"
    And User updates Activity Type "Decline Onboarding" with following assessments via API
      | Insufficient Requirements_4 |
    And User creates third-party "with workflow group Ukraine" via API and open it
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Decline Onboarding" activity row button
    Then Activity Assessment drop-down does not contains all "Decline Onboarding" activity assessments
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User clicks 'Edit' button for created Workflow
    And User clicks workflow button "Next"
    And User clicks workflow button Commit New Version
    And User clicks Ok button on confirmation window
    Then Workflow Table is displayed
    When User navigates to Third-party page
    Then Third-party with name "toBeReplaced" is displayed in Third-party overview table
    When User clicks on created third-party
    And User clicks "Stop Onboarding" third-party button
    And User clicks Yes button on confirmation window
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    When User clicks edit "Decline Onboarding" activity row button
    Then Activity Assessment drop-down contains all "Decline Onboarding" activity assessments
    When User selects activity assessment
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    Then Alert Icon is displayed with text
      | Success! Activity has been updated. |
    And Third-party's status should be shown - "ONBOARDING DENIED"