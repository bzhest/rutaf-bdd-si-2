@ui @sanity @suppliers @multilanguage
Feature: Edit Third-Party Information

  As a  user,
  I want a feature where I can alter the detail values of a third-party,
  So that I can correct invalid data, add supporting details, complete the third-party profile information

  @C32988220
  @RMS-28297
  Scenario: C32988220: Third Party Information - Edit Third Party Information
    Given User logs into RDDC as "Admin"
    When User sets up language via API
    And User creates third-party "with random ID name"
    And User clicks General and Other Information section "Edit" button
#   TODO update method implementation when RMS-28297 will be fixed
    And User updates General Information section with values
      | Reference No. | Name                         | Company Type | Organisation Size | Date of Incorporation | Responsible Party             | Division   | Workflow Group      | Currency         | Industry Type               | Business Category    | Revenue      | Liquidation Date | Affiliation     |
      | toBeReplaced  | AUTO_TEST_EDITED_THIRD_PARTY | Company      | 11-50 employees   | TODAY                 | Assignee_AT_FN Assignee_AT_LN | Operations | Auto Workflow Group | ALL Albanian lek | Accident & Health Insurance | Property & Structure | toBeReplaced | TODAY            | Publicly Traded |
    And User clicks General and Other Information section "Save" button
    Then Third-party Information tab is loaded
    And General Information section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Third-party Segmentation section with values
      | Spend Category          | Design Agreement                 | Relationship Visibility                 | Commodity Type | Sourcing Method                                               | Sourcing Type  | Product Impact       |
      | Regularly sourcing from | Products purchased off the shelf | Little to no visibility of relationship | toBeReplaced   | Purchased through distribution or agent from multiple sources | Single sourced | Critical to business |
    And User clicks General and Other Information section "Save" button
    Then Third-party Segmentation section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Bank Details on position 1 with values
      | Bank Name      | Account No.      | Branch Name      | Bank Address Line | Bank City | Bank Country |
      | Edit Bank Name | Edit Account No. | Edit Branch Name | Edit Address Line | Edit City | Afghanistan  |
    And User clicks General and Other Information section "Save" button
    Then Bank Details section details are displayed with populated data on position 1
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks General and Other Information section "Save" button
    Then Address section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Contact section with values
      | Phone Number | Fax      | Website    | Email Address      |
      | 000000000000 | Edit Fax | google.com | editEmail@test.com |
    And User clicks General and Other Information section "Save" button
    Then Contact section details are displayed with populated data
    When User clicks General and Other Information section "Edit" button
    And User updates Description section with text "Some text"
    And User clicks General and Other Information section "Save" button
    Then Description section details are displayed with populated data
    When User navigates to Third-party page
    Then User searches third-party with name "AUTO_TEST_EDITED_THIRD_PARTY"
    Then Third-party with name "AUTO_TEST_EDITED_THIRD_PARTY" is displayed in Third-party overview table
