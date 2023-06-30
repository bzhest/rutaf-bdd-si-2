@ui @robusta @business_overview
Feature: Business Overview

  As a RDDC User with right permissions
  I want to see Business Overview section under Data Provider tab
  So that I can view Business Overview information and do some other actions in the section

  Background:
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks on "Data Providers" tab on Third-party page

  @C49853278
  Scenario: C49853278 - Business Overview should be visible and can be accessed with User/Tenant configured with
  permission to Business Overview
    Then Business Overview Tab is displayed
