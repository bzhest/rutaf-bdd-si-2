@ui @full_regression @wcScreening
Feature: Associated Individual Other Name Screening Results

  As a SI user,
  I want an ability to change the resolution type.
  So that I can manage the results.

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "Individual" "with mandatory fields" via API and open it
    And User creates Other name "Barac Obama" for Associated Party
    Then Sorted search "World-Check" results for "Barac Obama" "contact" appear in other names screening table for current page

  @C37072692
  Scenario Outline: C37072692: Associated Individual Other Name [2 cases] - Screening Result - Mark record as False -With Comment
    When User clicks resolve Other Name screening record for "contact" under number 1 as "FALSE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | FALSE           |
      | Comment         |
      | Tag As Red Flag |
    And Add Comment modal "Cancel" button is displayed
    And Add Comment modal "Save" button is displayed
    And User fills in comment "<comment>"
    And User turns <turnOption> 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Add Comment modal is disappeared
    And Other name screening record under number 1 appears in the other name screening table with "FALSE" resolution
    When User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table
    Examples:
      | comment                      | turnOption |
      | Mark record as FALSE comment | on         |
      |                              | off        |

  @C37072695
  Scenario: C37072695: Associated Individual Other Name - Screening Result - Select Record - Mark as Positive - With Comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSITIVE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSITIVE        |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    And User fills in comment "Mark record from profile as POSITIVE comment"
    And User turns on 'Tag as red flag'
    And User selects "High" Risk Level
    And User selects "Full Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Comment profile section contains expected text "Mark record from profile as POSITIVE comment"
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSITIVE" resolution

  @C37072696
  Scenario: C37072696: Associated Individual Other Name - Screening Result - Select Record -Mark as Possible - With Comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "POSSIBLE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | POSSIBLE        |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    And User fills in comment "Mark record from profile as POSSIBLE comment"
    And User turns on 'Tag as red flag'
    And User selects "Medium" Risk Level
    And User selects "Partial Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Comment profile section contains expected text "Mark record from profile as POSSIBLE comment"
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 appears in the main screening table with "POSSIBLE" resolution

  @C37072697
  Scenario: C37072697: Associated Individual Other Name - Screening Result - Select Record - Mark as False - With Comment
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User clicks resolve screening profile under number 1 record as "FALSE"
    Then Add Comment modal is displayed
    And Add Comment modal is displayed with text
      | RESOLUTION      |
      | FALSE           |
      | Comment         |
      | Tag As Red Flag |
    And Profile Add Comment modal "Cancel" button is displayed
    And Profile Add Comment modal "Add Reviewer" button is displayed
    And Profile Add Comment modal "Save" button is displayed
    And User fills in comment "Mark record from profile as FALSE comment"
    And User turns on 'Tag as red flag'
    And User selects "Unknown" Risk Level
    And User selects "No Match" Reason
    When User clicks "Save" Add Comment modal button
    Then Comment profile section contains expected text "Mark record from profile as FALSE comment"
    When User clicks on the "Back To Screening Results Button" screening profile
    And User clicks Close Other Name Results button
    Then Screening record under number 1 does not appear in the main screening table