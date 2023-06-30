@ui @other_names @alamid @full_regression

Feature: Third-party Other Name Screening

  As a user,
  I want to add third-party Other Names
  So that I can see the results from all names

  @C44905439
  Scenario: C44905439: Third-party Other Name - Screening - Send WC Groups to WC
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name"
    And User fills in Name field value "Japan"
    And User selects Name type "Other Name"
    And User selects other name group 2
    And User clicks on "Add button"
    And Other name "Japan" is created
    When User opens screening results for "Japan" Other name
    Then Other Name dialog is loaded
    When User clicks on "CUSTOM WATCHLIST" other name screening tab
    Then Other Name dialog is loaded
    When User clicks on "MEDIA CHECK" other name screening tab
    Then Other Name dialog is loaded
