@ui @core_regression @arabica

Feature: Third-party Other Names - Media check screening results

  As a RDDC user
  I want a new tab of media check screening
  So that I can see screening results of the media check records from WC1 in SI

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "Bank of China"

  @C37502784
  Scenario: C37502784: third-Party other names - Verify User should be redirected to the recently view article in the main screening page after navigating back from article detail page
    When User creates Other name "Bank of China"
    And User opens screening results for "Bank of China" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects "25" option from Rows Per Page dropdown list on Other Names
    Then Media Check Other Names Result Table should contain 25 records
    When User clicks on 13 number Media check other name screening record
    And User clicks on third-party other name back button
    Then Other Name dialog is loaded
    And Media Check Other Names Rows per page dropdown value should be "25"

  @C42712487
  Scenario: C42712487: third-Party other names - Verify the user should see X Items Selected articles when user navigate back from screening detail page
    When User creates Other name "Bank of China"
    And User opens screening results for "Bank of China" Other name
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
    When User selects Media Check Third-party Other Names screening record on position 1
    And User selects Media Check Third-party Other Names screening record on position 2
    And User selects Media Check Third-party Other Names screening record on position 3
    Then Media Check displays 3 items selected
    When User clicks on 3 items selected link
    Then Media Check items selected link Change to "Back to the full list" is displayed
    When User clicks on media check Other Names screening record on position 2
    And User clicks on third-party other name back button
    Then Screening results table is loaded
    And Media Check items selected link Change to "Back to the full list" is displayed
    And Media check Other Names screening record on position 1 is checked
    And Media check Other Names screening record on position 2 is checked
    And Media check Other Names screening record on position 3 is checked