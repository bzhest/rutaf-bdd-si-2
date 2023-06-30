@ui @functional @review_process
Feature: Set Up - Review Process - Permissions

  As a RDDC System Administrator
  I want to be able to limit the access to the Review Process setup module
  So that only the authorized users will be able to configure the Review Processes in the system


  @C45149797
  Scenario: C45149797: (Set Up/Review Process) - "Review Process" option is not displayed in the left-side navigation menu for users who do not have access to this functionality
    Given User logs into RDDC as "Restricted"
    When User clicks Set Up option
    Then Setup navigation option "Review Process" is not displayed

  @C45149798
  Scenario: C45149798: (Set Up/Review Process) - "403 FORBIDDEN" screen is displayed for users who do not have access to this functionality
    Given User logs into RDDC as "Admin"
    When User creates 1 Review Processes with "Review Process with Activity owner" via API
    And User clicks Log Out button
    And User logs into RDDC as "Restricted"
    And User clicks Set Up option
    When User navigates to Review Process page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to Review Process Add page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "" existing Review Process page
    Then Current URL contains "/forbidden" endpoint
    When User navigates to open "/edit" existing Review Process page
    Then Current URL contains "/forbidden" endpoint
