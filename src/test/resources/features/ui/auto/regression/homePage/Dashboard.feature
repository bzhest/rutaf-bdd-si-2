@ui @full_regression @dashboard
Feature: Dashboard

  @C36068815
  Scenario: C36068815: Supplier - Dashboard - Check tabs on the Dashboard
    Given User logs into RDDC as "Internal User for Editing"
    Then Dashboard of Internal Users is displayed with the following tabs
      | MY TASKS            |
      | THIRD-PARTY METRICS |
      | ACTIVITY METRICS    |
    And My Tasks tabs is displayed with the following widget
      | ASSIGNED ACTIVITIES         |
      | ITEMS TO APPROVE            |
      | ITEMS TO REVIEW             |
      | THIRD-PARTY FOR RENEWAL     |
      | DUE DILIGENCE ORDERS        |
      | PENDING ORDERS FOR APPROVAL |
    And Dashboard "Items To Approve" widget is disabled
    And Dashboard "Assigned Activities" widget is enabled
