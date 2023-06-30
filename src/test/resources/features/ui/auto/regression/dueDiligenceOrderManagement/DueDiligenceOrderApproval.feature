@ui @full_regression @ordering
Feature: Due Diligence Report Ordering - Approval Settings

  As an Admin or Internal User that has access rights
  I want to allow users to configure default approver for DD Approver
  So That Client has an option to include approver for DD request

  Background:
    Given User logs into RDDC as "Admin"
    When User opens Due Diligence Order Approval page
    Then Due Diligence Order Approval page should be opened
    And Default Approver radio buttons should be displayed
      | User | User Group | Responsible Party |

  @C36332673 @C37447490
  @core_regression
  @onlySingleThread
  Scenario: C36332673, C37447490 - Due Diligence Report Order Approval Settings - Setting Default Approvers for Due Diligence Report Orders
    When User clicks "User" DD Order default approver radio button
    Then Default Approver should have link Advanced Search "enabled"
    And DDO default approver drop-down contains only active users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" in DD order Default approver dropdown
    Then Clear Default approver button is displayed
    When User clicks DDO Approval Save button
    Then Alert Icon is displayed with text
      | Success!                                        |
      | Due Diligence Approval process has been updated |
    When User clicks "User Group" DD Order default approver radio button
    Then Default Approver should have link Advanced Search "enabled"
    And Default DD order Approver drop-down contains all active user groups
    When User selects "AUTO_GROUP" in DD order Default approver dropdown
    Then Clear Default approver button is displayed
    When User clicks DDO Approval Save button
    Then Alert Icon is displayed with text
      | Success!                                        |
      | Due Diligence Approval process has been updated |
    When User clicks "Responsible Party" DD Order default approver radio button
    Then Default Approver should have link Advanced Search "disabled"
    When User clicks DDO Approval Save button
    Then Alert Icon is displayed with text
      | Success!                                        |
      | Due Diligence Approval process has been updated |

  @C36333109 @C37447491
    @core_regression
    @onlySingleThread
  Scenario Outline: C36333109, C37447491(1) - Setting Approvers for Due Diligence Report Orders based on rules
    When User deletes all rules except default on DDO Approval page
    And User deletes values for rule 1 on DDO Approver page
    Then DDO Approver rule 1 should have options
      | Third-party Commodity Type | Third-party Region | Third-party Country | Third-party Workflow Group |
    When User for DDO Approval selects for rule 1 type "<rule>"
    Then DDO Approval should have link Add Rules "disabled"
    When User clicks DDO Approval Save button
    Then Alert Icon is displayed with text
      | Cannot Save                            |
      | Please complete the required field(s). |
    And Under "<rule>" dropdown there is an error message: "This field is required"
    When User selects values for DDO Approval rule 1 dropdown "<values>"
    And User clicks "user" for DDO Approval rule 1 radio button
    Then DDO approver drop-down for rule 1 contains only active users
    When User selects "Admin_double_AT_FN Admin_double_AT_LN" for "user" in DDO Approval Approver dropdown for rule 1
    Then DDO Approval should have link Add Rules "enabled"
    And DDO Approver rule 1 should have link Advanced Search "enabled"
    When User clicks "userGroup" for DDO Approval rule 1 radio button
    Then DD Order Approver drop-down contains all active user groups in rule 1
    When User selects "AUTO_GROUP" for "userGroup" in DDO Approval Approver dropdown for rule 1
    Then DDO Approval should have link Add Rules "enabled"
    And DDO Approver rule 1 should have link Advanced Search "enabled"
    And DD Order Approver drop-down contains all active user groups in rule 1
    When User clicks "responsibleParty" for DDO Approval rule 1 radio button
    Then DDO Approver rule 1 should have link Advanced Search "disabled"
    And User clicks DDO Approval Save button
    Examples:
      | rule                       | values                       |
      | Third-party Commodity Type | Electricity,Cleaning,Housing |
      | Third-party Region         | Americas,Asia,Oceania        |
      | Third-party Country        | Ukraine,Norway,Brazil        |
      | Third-party Workflow Group | WorkflowGroup                |

  @C36333109 @C37447491
  @core_regression
  @onlySingleThread
  Scenario: C36333109, C37447491(2) - Setting Approvers for Due Diligence Report Orders based on multiple rules
    When User deletes all rules except default on DDO Approval page
    And User deletes values for rule 1 on DDO Approver page
    And User clicks DDO Approval Save button
    And User creates 5 rules for DDO Approval
    Then DDO Approver rule 5 should have link Advanced Search "enabled"
    When User clicks Reset button on DDO Approval page
    And User deletes values for rule 1 on DDO Approver page
    Then DDO Approver rule 1 should have link Advanced Search "disabled"

  @C36337796
  @onlySingleThread
  Scenario: C36337796: Due Diligence Report Order Approval Settings - View Approval Process - Removing Due Diligence Report Order Approver Rules
    When User deletes all rules except default on DDO Approval page
    And User deletes values for rule 1 on DDO Approver page
    And User for DDO Approval selects for rule 1 type "Third-party Country"
    And User selects values for DDO Approval rule 1 dropdown "Ukraine"
    And User clicks "user" for DDO Approval rule 1 radio button
    And User selects "Admin_AT_FN Admin_AT_LN" for "user" in DDO Approval Approver dropdown for rule 1
    And User creates 2 rules for DDO Approval
    Then Approver Rules contains 3 rules
    When User deletes all rules except default on DDO Approval page
    Then Delete button is not displayed for default approval rule
    When User deletes values for rule 1 on DDO Approver page
    Then Delete button is not displayed for default approval rule

  @C36337895 @C37447492
  Scenario: C36337895, C37447492: Due Diligence Report Order Approval Settings - Advance Search
    When User clicks "User Group" DD Order default approver radio button
    Then Default Approver should have link Advanced Search "enabled"
    When User clicks Default Approver Advanced Search
    Then Advanced search form "ADVANCED SEARCH - USERS GROUP" appears
    When User fills in Default Approver Advanced search "Group Name" input "Assignee Group"
    And User clicks DD Order Approval Advanced search "Search" button
    Then Default Approver Advanced search table contains sortable columns
      | GROUP NAME |
    And Default Approver Advanced search contains results
      | Group          |
      | Assignee Group |
    When User selects Default Approver Advanced search result "Assignee Group"
    And User clicks DD Order Approval Advanced search "Add" button
    Then Default Approver "Assignee Group" for DD order is selected
    When User clicks Default Approver Advanced Search
    Then Advanced search form "ADVANCED SEARCH - USERS GROUP" appears
    When User fills in Default Approver Advanced search "Group Name" input "Nonexistence Group"
    And User clicks DD Order Approval Advanced search "Search" button
    Then Default Approver Advanced search "NO MATCH FOUND" is displayed
    When User clicks DD Order Approval Advanced search "Cancel" button
    And User clicks DD Order Approval Advanced search "Cancel" button
    When User clicks "User" DD Order default approver radio button
    Then Default Approver should have link Advanced Search "enabled"
    When User clicks Default Approver Advanced Search
    Then Advanced search form "ADVANCED SEARCH - USERS" appears
    When User fills in Default Approver Advanced search "First Name" input "Autouser_With_Restrictions"
    And User clicks DD Order Approval Advanced search "Search" button
    Then Default Approver Advanced search table contains sortable columns
      | FIRST NAME |
      | LAST NAME  |
      | ROLE       |
    And Default Approver Advanced search contains results
      | First Name                 | Last Name                            | Role                             |
      | Autouser_With_Restrictions | Autouser_With_Restrictions_Last_Name | AUTO TEST ROLE WITH RESTRICTIONS |
    And Results that match the search request are shown
    When User selects Default Approver Advanced search result "Autouser_With_Restrictions"
    And User clicks DD Order Approval Advanced search "Add" button
    Then Default Approver "Autouser_With_Restrictions Autouser_With_Restrictions_Last_Name" for DD order is selected
    When User clicks Default Approver Advanced Search
    Then Advanced search form "ADVANCED SEARCH - USERS" appears
    When User fills in Default Approver Advanced search "Last Name" input "Assignee_AT_LN"
    And User clicks DD Order Approval Advanced search "Search" button
    Then Default Approver Advanced search contains results
      | First Name     | Last Name      | Role                 |
      | Assignee_AT_FN | Assignee_AT_LN | System Administrator |
    And Results that match the search request are shown
    When User selects Default Approver Advanced search result "Assignee_AT_FN"
    And User clicks DD Order Approval Advanced search "Add" button
    Then Default Approver "Assignee_AT_FN Assignee_AT_LN" for DD order is selected
    When User clicks Default Approver Advanced Search
    Then Advanced search form "ADVANCED SEARCH - USERS" appears
    When User fills in Default Approver Advanced search "First Name" input "Admin_AT_FN"
    And User fills in Default Approver Advanced search "Last Name" input "Admin_AT_LN"
    And User clicks DD Order Approval Advanced search "Search" button
    Then Default Approver Advanced search contains results
      | First Name  | Last Name   | Role                 |
      | Admin_AT_FN | Admin_AT_LN | System Administrator |
    And Results that match the search request are shown
    When User selects Default Approver Advanced search result "Admin_AT_FN"
    And User clicks DD Order Approval Advanced search "Add" button
    Then Default Approver "Admin_AT_FN Admin_AT_LN" for DD order is selected
    And User clicks Default Approver Advanced Search
    And User fills in Default Approver Advanced search "First Name" input "test"
    And User clicks DD Order Approval Advanced search "Search" button
    Then Pagination buttons should be visible
      | first | previous | next | last |
    When User clicks pagination drop-down
    And Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
