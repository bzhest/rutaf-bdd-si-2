@ui @user_management
Feature: User Management - Supplier Integrity Administrator User

  @C35798822
  @full_regression
#  Pre-configured by the System System Administrator account - can be different on different environments
#  This test covers System Administrator account for qa-regression
  Scenario: C35798822: [SI Users] - SI Administrator user exists in the system
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And Users table is displayed
    When User searches user by "rddcentre.admin.np@refinitiv.com" keyword
    And User selects "25" items per page
    Then User table contains user with values
      | First Name | Last Name | User Name                        | User Type | Role                 | Status | Single Sign On |
      | RDD Centre | Admin     | rddcentre.admin.np@refinitiv.com | Internal  | System Administrator | ACTIVE | No             |
    When User clicks on user with User Name "rddcentre.admin.np@refinitiv.com"
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name | Last Name | Email                            | User Name                        | Position | User Type | Role                 | Status | Group | Superior | Entity | External Organisation | Department |
      | RDD Centre | Admin     | rddcentre.admin.np@refinitiv.com | rddcentre.admin.np@refinitiv.com |          | Internal  | System Administrator | Active |       |          |        |                       |            |

  @C35801398
  @core_regression
  @onlySingleThread
  Scenario: C35801398: [SI Users] - SI Administrator user can search for an user
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And Add User page is loaded
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Add User page is closed
    When User searches user by first name
    Then User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |
    When User searches user by "userLastName" keyword
    Then User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |
    When User searches user by "userFirstName userLastName" keyword
    Then User table contains user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |

