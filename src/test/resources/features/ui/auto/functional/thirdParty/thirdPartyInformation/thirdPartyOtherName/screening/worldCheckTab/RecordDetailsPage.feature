@ui @functional @wc1 @other_names @screening_result
Feature: Third-party - Information - Other Name - World Check Tab - Screening - Record Details Page

  As a user,
  I want to see the supplier other name results from WC1.
  So that I can process the supplier other name information.

  Background:
    Given User logs into RDDC as "Admin"
    And  User sets up default Screening Management parameters via API
    And User creates third-party "with random ID name"


  @C33592816
  Scenario: C33592816: Supplier - Check WC1 profile details for added Other name
    When User fills in Name field value "PetroChina"
    And User selects Name type "Other Name"
    And User edits "Country of Registration" field with value "China"
    And User clicks on "Other Names Add|Save button"
    And User clicks on Screen Other Name Button for "PetroChina" name
    Then Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "supplier" profile Key Data tab displays correspond data
    And Screening result "supplier" profile Aliases tab displays correspond data
    And Screening result "supplier" profile Further Information tab displays correspond data
    And Screening result "supplier" profile Keywords tab displays correspond data
    And Screening result "supplier" profile Connections and Relationships tab displays correspond data
    And Screening result "supplier" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page
    When User clicks on 2 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "supplier" profile Key Data tab displays correspond data
    And Screening result "supplier" profile Aliases tab displays correspond data
    And Screening result "supplier" profile Further Information tab displays correspond data
    And Screening result "supplier" profile Keywords tab displays correspond data
    And Screening result "supplier" profile Connections and Relationships tab displays correspond data
    And Screening result "supplier" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page
    When User clicks on 3 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "supplier" profile Key Data tab displays correspond data
    And Screening result "supplier" profile Aliases tab displays correspond data
    And Screening result "supplier" profile Keywords tab displays correspond data
    And Screening result "supplier" profile Connections and Relationships tab displays correspond data
    And Screening result "supplier" profile Sources tab displays correspond data
    And Screening result "supplier" profile Further Information tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "PetroChina" "supplier" appear in other names screening table for current page

  @C33592817
  Scenario: C33592817: Supplier - Check WC1 profile details for edited Other name
    When User fills in Name field value "Test Other Name"
    And User selects Name type "Other Name"
    And User edits "Country of Registration" field with value "China"
    And User clicks on "Other Names Add|Save button"
    Then Edit Other Name button is displayed in the Other Names section after each record
    When User clicks on Edit Other Name Button for "Test Other Name" name
    And User fills in Name field value "China"
    And User selects Name type "Former Name"
    And User clicks on "Other Names Add|Save button"
    Then Alert Icon is displayed with text
      | Success!                          |
      | Other name China has been updated |
    When User clicks on Screen Other Name Button for "China" name
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "supplier" profile Key Data tab displays correspond data
    And Screening result "supplier" profile Aliases tab displays correspond data
    And Screening result "supplier" profile Further Information tab displays correspond data
    And Screening result "supplier" profile Keywords tab displays correspond data
    And Screening result "supplier" profile Connections and Relationships tab displays correspond data
    And Screening result "supplier" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    When User clicks on 2 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "supplier" profile Key Data tab displays correspond data
    And Screening result "supplier" profile Aliases tab displays correspond data
    And Screening result "supplier" profile Further Information tab displays correspond data
    And Screening result "supplier" profile Keywords tab displays correspond data
    And Screening result "supplier" profile Connections and Relationships tab displays correspond data
    And Screening result "supplier" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page
    When User clicks on 3 number Other name screening record
    Then Other name screening result profile details is displayed
    And Screening "supplier" profile header contains correspond data
    And Screening profiles Resolution Type contains correspond data
    And "Legal Notice" profile details is displayed
    And "Add Comment Button" profile details is displayed
    And Screening result "supplier" profile Key Data tab displays correspond data
    And Screening result "supplier" profile Aliases tab displays correspond data
    And Screening result "supplier" profile Further Information tab displays correspond data
    And Screening result "supplier" profile Keywords tab displays correspond data
    And Screening result "supplier" profile Connections and Relationships tab displays correspond data
    And Screening result "supplier" profile Sources tab displays correspond data
    When User clicks on the "Back To Screening Results Button" screening profile
    Then Sorted search "World-Check" results for "China" "supplier" appear in other names screening table for current page