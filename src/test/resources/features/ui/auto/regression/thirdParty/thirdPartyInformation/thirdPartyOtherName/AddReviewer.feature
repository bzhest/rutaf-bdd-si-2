@ui @full_regression @core_regression @react @third_party_other_names
Feature: Third-party Other Names -Screening - World-Check tab - Add Reviewer


  @C39382218
  Scenario: C39382218: Third-party Other Name Record - Add Reviewer - Assign to User - Assign to existing World Check Screening Ad hoc activity
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on Third-party Information tab
    Then Third-party Information tab is loaded
    When User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" reviewer due to today date
    Then Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"

  @C39382219
  Scenario: C39382219: Third-party Other Name Record - Add Reviewer - Assign to User Group - Assign to existing World Check Screening Ad hoc activity
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name"
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Activity Type" drop-down with "World Check Screening"
    And User fills in "Activity Name" field with "World Check Screening"
    And User fills in "Description" field with "World Check Screening Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in "Status" drop-down with "Not Started"
    And User fills in Assignee drop-down with "Admin_AT_FN Admin_AT_LN"
    And User clicks Ad Hoc Activity "Save" button
    And User clicks on Third-party Information tab
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    And User adds screening record "User Group" "Assignee Group" reviewer due to today date
    Then Alert Icon is displayed with text
      | Success! Reviewer has been added. |
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee Group"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"

  @C39382224
  Scenario: C39382224: Third-party Other Name Record - Add Reviewer - Assign to User - Create Ad hoc Activity
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    And User adds screening record "User" "Assignee_AT_FN Assignee_AT_LN" Ad Hoc reviewer due to today date
    Then Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee_AT_FN Assignee_AT_LN"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"

  @C39382225
  Scenario: C39382225: Third-party Other Name Record - Add Reviewer - Assign to User Group - Create Ad hoc Activity
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "with random ID name"
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    And User adds screening record "User Group" "Assignee Group" Ad Hoc reviewer due to today date
    Then Alert Icon is displayed with text
      | Success! Reviewer has been added. |
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Assignee Group"
    And Screening profile's Reviewer Assigned By is "Admin_AT_FN Admin_AT_LN"

  @C39770904
  Scenario: C39770904: Third-party Other Name Record - Add Reviewer - Assign to User - Assign to existing World Check Screening Onboarding activity
    Given User logs into RDDC as "Admin"
    And User sets up default Screening Management parameters via API
    When User creates third-party "belizeWithApprover"
    And User clicks Start Onboarding for third-party
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    And User adds screening record "User" "Admin_AT_FN Admin_AT_LN" reviewer due to today date
    Then Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "Admin_AT_FN Admin_AT_LN"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"

  @C39770905
  Scenario: C39770905: Third-party Other Name Record - Add Reviewer - Assign to User Group - Assign to existing World Check Screening Onboarding activity
    Given User logs into RDDC as "Assignee"
    And User sets up default Screening Management parameters via API
    When User creates third-party "belizeWithApprover" via API and open it
    And User clicks Start Onboarding for third-party
    And User creates Other name "ROSHEN"
    And User opens screening results for "ROSHEN" Other name
    Then Other Name dialog is loaded
    When User clicks on 1 number Other name screening record
    And User adds screening record "User Group" "AUTO_GROUP" reviewer due to today date
    Then Alert Icon is displayed with text
      | Success! Reviewer has been added. |
    And Screening profile's Resolution is displayed
    And Screening profile's Tags is displayed
    And Screening profile's Review Status is "For Review"
    And Screening profile's Reviewer is "AUTO_GROUP"
    And Screening profile's Reviewer Assigned By is "Assignee_AT_FN Assignee_AT_LN"
