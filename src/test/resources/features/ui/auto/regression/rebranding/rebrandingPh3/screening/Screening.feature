@ui @full_regression @rebranding
Feature: Rebranding - Screening
  As a product owner
  I want to change supplier label in column type under the activity information modal for WC screening and Screening Items to Review Dashboard
  So that it is aligned with Refinitiv branding for marketing purposes.

  @C37472597
  Scenario: C37472597: WC Screening - Risk Management - Check url and domain when viewing Third-party Screening Result from Adhoc activity modal
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name" via API and open it
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(\w+)\/view" endpoint regex
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&otherName=Bank" endpoint regex
    When User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)#isScreeningSection" endpoint regex
