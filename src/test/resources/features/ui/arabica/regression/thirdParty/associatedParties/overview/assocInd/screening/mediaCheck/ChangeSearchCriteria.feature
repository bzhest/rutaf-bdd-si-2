@ui @core_regression @arabica

Feature: Associated Individual - Change Search Criteria

  As a RDDC user
  I want Change Search Criteria button to be adjusted
  So that I can choose to screen for World-Check, Custom WatchList, Media Check results or all of them

  Background:
    Given User logs into RDDC as "Admin"
    And User creates third-party "Bank of China"

  @C40222017
  Scenario: C40222017: Associated Individual - Change Search Criteria - Verify Search Term display as the same value on the create TP step
    When User creates Associated Party "Barac Obama"
    Then Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "Barac Obama" value
    And Check Type is checked
      | World-Check      |
      | Custom WatchList |
      | Media Check      |
    And User clicks Cancel search criteria button
    When User clicks Associated Party's General Information section "Edit" button
    And User updates Associated Party's General Information section with values
      | First Name      | Last Name      |
      | Edit First Name | Edit Last Name |
    And User clicks Associated Party's General Information section "Save" button
    Then Associated Party's General Information section details are displayed with populated data
    And Screening results table is loaded
    When User clicks Change Search Criteria screening button
    Then Search criteria "Search Term" contains "Edit First Name Edit Last Name" value
    And User edits Search Term with value "AUTO_TESTTHIRD_PARTY_EDIT"
    And Associated Party's General Information section details are displayed with data
      | Title | First Name      | Last Name      | Middle Name |
      |       | Edit First Name | Edit Last Name |             |