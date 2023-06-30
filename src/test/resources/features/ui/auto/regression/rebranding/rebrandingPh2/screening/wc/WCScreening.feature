@ui @full_regression @rebranding
Feature: Rebranding - Screening - WC

  As a product owner,
  I want to change domain name to the new one
  So that it is aligned with Refinitiv branding for marketing purposes.

  Background:
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API


  @C37107280
  Scenario: C37107280: WC Screening - Risk Management - Check url and domain when viewing Third-party Screening Result from Adhoc activity modal
    When User creates third-party "Bank of China" via API and open it
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(\w+)\/view" endpoint regex
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(\w+)\?resultId=(\w+)" endpoint regex
    When User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)#isScreeningSection" endpoint regex

  @C37107281
  Scenario: C37107281: WC Screening - Risk Management - Check url and domain when viewing Contact Screening Result from adhoc activity modal
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on Risk Management tab
    And User clicks on the newly created Ad Hoc Activity with name "World Check Screening"
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/risk-management\/adhoc-activity\/(\w+)\/view" endpoint regex
    When User clicks Actions button for 1 Review Task
    Then Screening result profile details is displayed
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties&type=individual" endpoint regex
    When User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/view\?type=individual#isScreeningSection" endpoint regex

  @C37107282
  Scenario: C37107282: WC Screening - Adhoc - Check url and domain when assigning a reviewer from Third-party Screening result
    When User creates third-party "Bank of China" via API and open it
    And User clicks on 1 number screening record
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/profile\/(\w+)\?resultId=(\w+)" endpoint regex
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)#isScreeningSection" endpoint regex

  @C37107283
  Scenario: C37107283: WC Screening - Adhoc - Check url and domain when assigning a reviewer from Third-party Other Name Screening Result
    When User creates third-party "with random ID name" via API and open it
    And User creates Other name "Bank"
    And User opens screening results for "Bank" Other name
    Then Sorted search "World-Check" results for "Bank" "supplier" appear in other names screening table for current page
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)" endpoint regex
    When User clicks on 1 number Other name screening record
    Then Other name screening result profile details is displayed
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\?isFromProfileDetails=true" endpoint regex
    When User clicks Close Other Name Results button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)" endpoint regex

  @C37107284
  Scenario: C37107284: WC Screening - Adhoc - Check url and domain when assigning a reviewer from Contacts Screening Result
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "John SMITH"
    And User clicks on 1 number screening record
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties&type=individual" endpoint regex
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/view\?type=individual#isScreeningSection" endpoint regex

  @C37107285
  Scenario: C37107285: WC Screening - Adhoc - Check url and domain when assigning a reviewer from Contacts Other Name Screening Result
    When User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "John SMITH"
    And User creates Other name "James" for Associated Party
    Then Sorted search "World-Check" results for "James" "contact" appear in other names screening table for current page
    And Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/view\?type=individual" endpoint regex
    When User clicks on 1 number screening record
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties&type=individual" endpoint regex
    When User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    And User clicks on the 'Screening Results' screening profile button
    And User clicks on 1 number screening record
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/profile\/(\w+)\?resultId=(\w+)&source=associated-parties&type=individual" endpoint regex
    When User clicks on the 'Screening Results' screening profile button
    Then Current URL matches ".+\/ui\/thirdparty\/(\w+)\/associated-parties\/(\w+)\/view\?type=individual#isScreeningSection" endpoint regex
