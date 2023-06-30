@ui @core_regression @user_management
Feature: User Management - Edit User

  @C35814769
  Scenario: C35814769: SI Users - verify that existing user (Internal/External) can be edited in the System - Internal User
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    Then 'Edit' icon should be displayed for each user record
    When User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And Add User page is closed
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name           | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | AUTO TEST Last Name | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |
    When User clicks edit user button by name
    Then Edit User page is displayed
    When User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "AUTO TEST Edit Last Name"
    And User selects in "Role" Edit User value "AUTO TEST ROLE EDIT WITH RESTRICTIONS"
    And User selects in "Division" Edit User value "Operations"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name                | User Name    | User Type | Role                                  | Status | Single Sign On |
      | toBeReplaced | AUTO TEST Edit Last Name | toBeReplaced | Internal  | AUTO TEST ROLE EDIT WITH RESTRICTIONS | ACTIVE | No             |
    When User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name                | Email        | User Name    | User Type | Role                                  | Status | Organisation | Division   |
      | toBeReplaced | AUTO TEST Edit Last Name | toBeReplaced | toBeReplaced | Internal  | AUTO TEST ROLE EDIT WITH RESTRICTIONS | Active | RFG          | Operations |
    When User clicks User Overview Edit button
    Then Edit User page is displayed
    When User checks 'Enable Single Sign On' Edit User checkbox
    And User clicks Proceed button on confirmation window
    And User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "Edited Last Name"
    And User fills in "Position" Edit User value "Edited Position"
    And User selects in "Role" Edit User value "AUTO TEST ROLE WITH RESTRICTIONS"
    And User unchecks 'Active' Edit User checkbox
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User selects in "Superior" Edit User value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Language" Edit User value "French"
    And User selects in "Division" Edit User value "MyDivision"
    And User selects in "Entity" Edit User value "MyEntity"
    And User selects in "External Organisation" Edit User value "MyOrganisation"
    And User selects in "Department" Edit User value "MyDepartment"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name        | User Name    | User Type | Role                             | Status   | Single Sign On |
      | toBeReplaced | Edited Last Name | toBeReplaced | Internal  | AUTO TEST ROLE WITH RESTRICTIONS | INACTIVE | Yes            |
    When User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name        | Email        | User Name    | Position        | User Type | Role                             | Status   | Group      | Superior                | Language | Organisation | Division   | Entity   | External Organisation | Department   |
      | toBeReplaced | Edited Last Name | toBeReplaced | toBeReplaced | Edited Position | Internal  | AUTO TEST ROLE WITH RESTRICTIONS | Inactive | AUTO_GROUP | Admin_AT_FN Admin_AT_LN | French   | RFG          | MyDivision | MyEntity | MyOrganisation        | MyDepartment |

  @C35814769
  Scenario: C35814769: SI Users - verify that existing user (Internal/External) can be edited in the System - External User
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "Test_First_Name"
    And User clicks edit user button for user with First Name "Test_First_Name"
    Then Edit User page is displayed
    When User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "External AUTO TEST Edit Last Name"
    And User selects in "Third-party" Edit User value "Supplier_Internal_User DO NOT DELETE"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name                         | User Type | Status   | Single Sign On |
      | toBeReplaced | External AUTO TEST Edit Last Name | External  | INACTIVE | No             |
    When User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name                         | User Type | Status   | Third-party                          |
      | toBeReplaced | External AUTO TEST Edit Last Name | External  | Inactive | Supplier_Internal_User DO NOT DELETE |
    When User clicks User Overview Edit button
    Then Edit User page is displayed
    When User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "Edited Last Name"
    And User fills in "Position" Edit User value "Edited Position"
    And User checks 'Active' Edit User checkbox
    And User selects in "Third-party" Edit User value "Supplier_External_User DO NOT DELETE"
    And User selects in "Language" Edit User value "French"
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name        | User Type | Status | Single Sign On |
      | toBeReplaced | Edited Last Name | External  | ACTIVE | No             |
    When User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name        | Position        | User Type | Status | Third-party                          | Language |
      | toBeReplaced | Edited Last Name | Edited Position | External  | Active | Supplier_External_User DO NOT DELETE | French   |