@ui @full_regression @risk_analyzer
Feature: Risk Analyzer

  As a Supplier Integrity User
  I want I want to see a visual representation of a Supplier's Risk Scores
  So that I can have an idea of the overall risk of the Supplier at a quick glance

  Background:
    Given User logs into RDDC as "Admin"

  @C36310141 @C47953920
  @core_regression
  Scenario: C36310141:	Risk Analyzer - check View Supplier: Risk Analyzer Section - Graph
    When User creates third-party "with random ID name and Zimbabwe country"
    Then Risk Analyzer section is displayed
    And Risk Analyzer section contains risk sections
      | ANTI TRUST & CORRUPTION             |
      | EMPLOYMENT, SAFETY & REPUTATION     |
      | CYBER SECURITY & BUSINESS STABILITY |
      | ENVIRONMENTAL & GOVERNANCE          |
    And Risk section bars "Zimbabwe" contains expected image
    When User hovers over Risk Analyzer tooltip icon
    Then "Risk Analyzer" Tooltip text is displayed "The Risk Analyzer assesses third party risk across all risk areas and adjusts with provided details. These individual risk area scores are used to provide the Overall Risk Score for the third party."

  @C36334378
  @core_regression
  Scenario: C36334378: Risk Analyzer - verify that contributing Risk Areas in RA Graph based on Overall Risk Score Configuration are highlighted
    When User creates third-party "with random ID name and Zimbabwe country"
    Then User refreshes page
    And User clicks Configure Risk Analyzer button
    Then Configure Overall Risk Score modal is displayed
    When User selects "Averaging All Risk Area" Overall Risk Score modal's radio button
    And User clicks Save Overall Risk Score modal's button
    And User clicks Configure Risk Analyzer button
    Then Configure Overall Risk Score modal is displayed
    When User selects "Averaging Selected Risk Area" Overall Risk Score modal's radio button
    And User selects "I.P. Infringement" Risk Area
    And User selects "Business Continuity" Risk Area
    And User selects "Product Regulations" Risk Area
    And User clicks Save Overall Risk Score modal's button
    Then Risk section bars "Highlighted" contains expected image

  @C36318544
  @core_regression
  Scenario: C36318544: Risk Analyzer - verify that Configure Overall Risk Score is disabled if Supplier Status Onboarding/Renewing
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User creates new Workflow "Automation Onboarding Workflow With Risk Scoring For Norway" with Activity "Approve Onboarding Activity"
    And User creates third-party "with workflow group"
    And User clicks Start Onboarding for third-party
    Then Third-party's status should be shown - "ONBOARDING"
    And Configure Risk Analyzer button is disabled
    When User clicks "NEW COMPONENT" tab
    And User clicks on "Approve Onboarding" activity
    And User clicks Edit button for Activity
    And User selects activity status "Done"
    And User clicks 'Save' activity button
    And User clicks Assessment edit button
    And User updates renewal date and waits for renewal process completion
    And Workflow "toBeReplaced" is updated with type "Renewal"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "Renew" for third-party
    Then Third-party's status should be shown - "RENEWING"
    And Configure Risk Analyzer button is disabled

  @C36315491
  @RMS-28297
  @core_regression
  #TODO - change first step third-party to "with Complete Details" and remove "with Complete Details without responsible party" from thirdParty.json
  Scenario: C36315491: Risk Analyzer - verify that Overall Risk Score calculated and Risk Tier displayed, when Supplier created
    #    TODO update step implementation when RMS-28297 will be fixed
    When User creates third-party "with Complete Details without responsible party"
    Then User refreshes page
    Then Overall Risk Score contains average score of all risks
    And Overall Risk Score meter is displayed
    And The Overall Risk Score meter is expected for risk score - "2.5"
    And Third-party's Risk Tier should be shown with expected risk score and expected color

  @C36315558
  @core_regression
  Scenario: C36315558: Risk Analyzer - verify that Overall Risk Score recalculated and corresponding Risk Tier displayed, when Supplier edited
    When User creates third-party "with random ID name and Zimbabwe country"
    Then User refreshes page
    And Overall Risk Score meter is displayed
    And Third-party's Overall Risk Score should be generated - "3.0"
    When User clicks General and Other Information section "Edit" button
    And User updates General Information section with values
      | Industry Type               | Business Category    | Revenue      | Affiliation     |
      | Accident & Health Insurance | Property & Structure | toBeReplaced | Publicly Traded |
    And User clicks General and Other Information section "Save" button
    Then Overall Risk Score contains average score of all risks
    When User clicks General and Other Information section "Edit" button
    And User updates Third-party Segmentation section with values
      | Spend Category          | Design Agreement                 | Relationship Visibility                 | Commodity Type | Sourcing Method                         | Sourcing Type  | Product Impact       |
      | Regularly sourcing from | Products purchased off the shelf | Little to no visibility of relationship | toBeReplaced   | Purchased through distribution or agent | Single sourced | Critical to business |
    And User clicks General and Other Information section "Save" button
    Then Overall Risk Score contains average score of all risks
    When User clicks General and Other Information section "Edit" button
    And User updates Address section with values
      | Address Line      | City      | Zip/Postal Code      | State/Province      | Region       | Country |
      | Edit Address Line | Edit City | Edit Zip/Postal Code | Edit State/Province | toBeReplaced |         |
    And User clicks General and Other Information section "Save" button
    Then Overall Risk Score contains average score of all risks
    And Third-party's Risk Tier should be shown with expected risk score and expected color
    And Risk section bars "Updated" contains expected image

  @C36315559
  @core_regression
  Scenario: C36315559: Risk Analyzer - verify that Overall Risk Score and Risk Tier are displayed, when viewing Supplier
    When User creates third-party "with random ID name and Zimbabwe country"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Overall Risk Score contains average score of all risks
    And Overall Risk Score meter is displayed
    And The Overall Risk Score meter is expected for risk score - "3.0"
    And Third-party's Risk Tier should be shown with expected risk score and expected color
    When User hovers Risk Tier tooltip icon
    Then "Risk Tier" Tooltip text is displayed "Risk Tiers allow segmentation of Third-party to support a risk based approach to compliance and integrity risk management"

  @C36315525
  @core_regression
  @onlySingleThread
  Scenario: C36315525: Risk Analyzer - verify that Risk Tier column is displayed in the Supplier Overview list
    When User navigates to Third-party page
    Then Third-party Table Column "Risk Tier" is displayed
    And Third-party Table Column "Risk Tier" is between "Risk Model" and "Date Created" columns
    And The Risk Tier column displays the Risk Tier of each third-party
    When Users clicks "Risk Tier" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Risk Tier" in "ASC" order
    When Users clicks "Risk Tier" column in Third-party Overview table header
    Then Third-party Overview table displays 10 third-parties sorted by "Risk Tier" in "DESC" order

  @C36198337
  Scenario: C36198337: Risk Analyzer - verify that only user with proper permission can configure Overall Risk Score
    When User navigates 'Set Up' block 'Role' section
    And User searches role by "AUTO TEST ROLE WITH RESTRICTIONS" keyword
    And User clicks 'Edit' button on searched role "AUTO TEST ROLE WITH RESTRICTIONS"
    And User fills Third-party block with "enable Configure Overall Risk" data
    And User clicks 'Submit' Role Management button
    And User creates third-party "with workflow group"
    And User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Configure Risk Analyzer button is enabled
    When User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'Role' section
    And User searches role by "AUTO TEST ROLE WITH RESTRICTIONS" keyword
    And User clicks 'Edit' button on searched role "AUTO TEST ROLE WITH RESTRICTIONS"
    And User fills Third-party block with "disable Configure Overall Risk" data
    And User clicks 'Submit' Role Management button
    And User creates third-party "with workflow group"
    And User logs into RDDC as "Restricted"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    Then Third-party Information details are displayed with populated data
    And Configure Risk Analyzer button is disabled

  @C36199221
  Scenario: C36199221: Risk Analyzer - check Configure Overall Risk Score: Averaging All Risk Area
    When User creates third-party "with workflow group"
    Then Third-party Information details are displayed with populated data
    And Configure Risk Analyzer button is displayed
    When User clicks Configure Risk Analyzer button
    Then Configure Overall Risk Score modal is displayed
    And Averaging All Risk Area input value - "2.4"
    And Configure Overall Risk Score default modal elements should be displayed
    When User clicks Configure Overall Risk Score Cancel button
    Then Configure Overall Risk Score modal is not displayed

  @C36199523
  Scenario: C36199523: Risk Analyzer - check Configure Overall Risk Score: Averaging Selected Risk Area
    When User creates third-party "with workflow group"
    Then Third-party Information details are displayed with populated data
    When User clicks Configure Risk Analyzer button
    Then Configure Overall Risk Score modal is displayed
    And Configure Overall Risk Score default modal elements should be displayed
    When User selects "Averaging Selected Risk Area" Overall Risk Score modal's radio button
    Then Multi-select dropdown field is displayed containing all risk areas
    When User selects "Business Continuity" Risk Area
    And User selects "Product Regulations" Risk Area
    And User clicks Configure Overall Risk Score Cancel button
    Then Configure Overall Risk Score modal is not displayed
    When User clicks Configure Risk Analyzer button
    Then Configure Overall Risk Score modal is displayed
    And Configure Overall Risk Score default modal elements should be displayed
    When User selects "Averaging Selected Risk Area" Overall Risk Score modal's radio button
    And Multi-select dropdown field is empty
    And User selects "Business Continuity" Risk Area
    And User selects "Product Regulations" Risk Area
    And User clicks Save Overall Risk Score modal's button
    Then Overall Risk Score meter is displayed
    And The Overall Risk Score meter should be - "1.0"
