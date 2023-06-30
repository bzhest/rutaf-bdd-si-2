@ui @functional @user_management
Feature: Set Up - User Management - Edit User

  @C40224147 @C32909428
  Scenario: C40224147, C32909428: Edit User - Internal - Verify fields values - Billing Entity is set as required
  Admin/Internal User- User Management - Edit Internal User - Verify that user should not be able to change user type
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User navigates 'Set Up' block 'User' section
    And User searches User by name "AUTO TEST Last Name"
    And User clicks edit user button for user with First Name "AUTO TEST Last Name"
    Then Edit User page is displayed
    And User form "Organisation information" section is displayed
    And User form button "Submit" is displayed
    And User form button "Cancel" is displayed
    And User "Role" drop-down contains expected values
    And User "Group" drop-down contains expected values
    And User "Superior" drop-down contains expected values
    And User Type is "Internal"
    And User Type is not editable
    And Username is not editable
    And User creation form contains required indicator for fields
      | First Name |
      | Last Name  |
      | Email      |
      | Username   |
      | User Type  |
      | Role       |
      | Division   |
    And User creation form doesn't contain required indicator for fields
      | Enable Single Sign On |
      | Position              |
      | Active                |
      | Group                 |
      | Superior              |
    And User form text fields max length is "64" symbols
      | First Name |
      | Last Name  |
      | Position   |
    And User form organisation not editable
    And User "Division" drop-down contains expected values
    And User "Entity" drop-down contains expected values
    And User "External Organisation" drop-down contains expected values
    And User "Department" drop-down contains expected values
    And User "Default Billing Entity" drop-down contains expected values
    And User "Other Billing Entity" drop-down contains expected values
    And User creation form doesn't contain required indicator for fields
      | Default Billing Entity |
      | Other Billing Entity   |

  @C40246239
  @onlySingleThread
  Scenario: C40246239: Edit User - Internal - Verify fields values - Billing Entity is set as NOT required
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as not required via API
    And User navigates 'Set Up' block 'User' section
    And User searches User by name "AUTO TEST Last Name"
    And User clicks edit user button for user with First Name "AUTO TEST Last Name"
    Then Edit User page is displayed
    And User form "Organisation information" section is displayed
    And User form button "Submit" is displayed
    And User form button "Cancel" is displayed
    And User "Role" drop-down contains expected values
    And User "Group" drop-down contains expected values
    And User "Superior" drop-down contains expected values
    And User Type is "Internal"
    And User Type is not editable
    And Username is not editable
    And User creation form contains required indicator for fields
      | First Name |
      | Last Name  |
      | Email      |
      | Username   |
      | User Type  |
      | Role       |
      | Division   |
    And User creation form doesn't contain required indicator for fields
      | Enable Single Sign On |
      | Position              |
      | Active                |
      | Group                 |
      | Superior              |
    And User form text fields max length is "64" symbols
      | First Name |
      | Last Name  |
      | Position   |
    And User form organisation not editable
    And User "Division" drop-down contains expected values
    And User "Entity" drop-down contains expected values
    And User form "Billing information" section is not displayed

  @C40230662
  Scenario: C40230662: Edit User - Internal - Save with only required fields
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User navigates 'Set Up' block 'User' section
    And User searches User by name "AUTO TEST Last Name"
    And User clicks edit user button for user with First Name "AUTO TEST Last Name"
    And User fills in "Position" Add User value "Test position"
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User selects in "Superior" Edit User value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Language" Edit User value "French"
    And User selects in "Division" Edit User value "MyDivision"
    And User selects in "Entity" Edit User value "MyEntity"
    And User selects in "External Organisation" Edit User value "MyOrganisation"
    And User selects in "Department" Edit User value "MyDepartment"
    And User clicks 'Submit' button on User Page
    And User clears User form fields
      | Position              |
      | Group                 |
      | Superior              |
      | Language              |
      | Entity                |
      | External Organisation |
      | Department            |
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    And Edit User page is displayed

  @C40230746 @C32909456 @C32909470
  Scenario: C40230746, C32909456, C32909470: Edit User - Internal - Save with all filled fields
  Update User - Verify that user should be able to edit the First Name and Last Name on edit user profile modal and save changes (SI IDP)
  User Group - Add/Edit User: Verify that user should be able to select from Active Group and user profile should be successfully updated (SIDEV-11453, SISPT-290)
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User navigates 'Set Up' block 'User' section
    And User searches User by name "AUTO TEST Last Name"
    And User clicks edit user button for user with First Name "AUTO TEST Last Name"
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Position" Add User value "Test position"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User selects in "Superior" Edit User value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Language" Edit User value "French"
    And User selects in "Division" Edit User value "MyDivision"
    And User selects in "Entity" Edit User value "MyEntity"
    And User selects in "External Organisation" Edit User value "MyOrganisation"
    And User selects in "Department" Edit User value "MyDepartment"
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    And Edit User page is displayed

  @C40230749
  Scenario: C40230749: Edit User - Internal - Cancel changes
    Given User logs into RDDC as "Admin"
    When User makes sure that Custom field "Billing Entity" is set as required via API
    And User navigates 'Set Up' block 'User' section
    And User searches User by name "AUTO TEST Last Name"
    And User clicks edit user button for user with First Name "AUTO TEST Last Name"
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Position" Add User value "Test position"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User selects in "Superior" Edit User value "Admin_AT_FN Admin_AT_LN"
    And User selects in "Language" Edit User value "French"
    And User selects in "Division" Edit User value "MyDivision"
    And User selects in "Entity" Edit User value "MyEntity"
    And User selects in "External Organisation" Edit User value "MyOrganisation"
    And User selects in "Department" Edit User value "MyDepartment"
    And User clicks 'Cancel' button on User Page
    Then Users table is displayed

  @C40230627
  Scenario: C40230627: Edit User - Internal - Verify required fields validation
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "User_No_Onboarding_AT_FN"
    And User clicks edit user button for user with First Name "User_No_Onboarding_AT_FN"
    And User clears User form fields
      | First Name |
      | Last Name  |
      | Role       |
      | Division   |
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields |
    And Under User Form "First Name" field there is an error message: "This field is required"
    And Under User Form "Last Name" field there is an error message: "This field is required"
    And Under User Form "Role" field there is an error message: "This field is required"
    And Under User Form "Division" field there is an error message: "This field is required"

  @C40245880 @C32909480
  @WSO2email
  Scenario: C40245880, C32909480: Edit User - Internal - Verify enabling/disabling SSO
  User Management - Verify that Admin should be able to change the setting "Enable Single Sign On" for Internal Users only by check and uncheck the checkbox
    Given User logs into RDDC as "Admin"
    When User creates valid email
    And User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User clicks edit user button by name
    And User checks 'Enable Single Sign On' Edit User checkbox
    Then Message is displayed on confirmation window
      | Are you sure you want to enable SSO? |
    And Confirmation button Cancel should be displayed
    And Confirmation button Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Edit User page is displayed
    And User form "Enable Single Sign-on" is unchecked
    When User checks 'Enable Single Sign On' Edit User checkbox
    And User clicks Proceed button on confirmation window
    Then User form "Enable Single Sign-on" is checked
    When User unchecks 'Enable Single Sign On' Edit User checkbox
    Then Message is displayed on confirmation window
      | Are you sure you want to disable SSO? |
    And Confirmation button Cancel should be displayed
    And Confirmation button Proceed should be displayed
    When User clicks Cancel button on confirmation window
    Then Confirmation window is disappeared
    And Edit User page is displayed
    And User form "Enable Single Sign-on" is checked
    When User unchecks 'Enable Single Sign On' Edit User checkbox
    And User clicks Proceed button on confirmation window
    Then User form "Enable Single Sign-on" is unchecked
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received

  @C40219580
  Scenario: C40219580: Edit External User: Verify that some fields will be editable and some should be in read only mode in the Edit User form
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_AT_FN"
    And User clicks edit user button for user with First Name "External_AT_FN"
    Then Edit User page is displayed
    And User form button "Submit" is displayed
    And User form button "Cancel" is displayed
    And User creation form fields are editable
      | First Name  |
      | Last Name   |
      | Position    |
      | Active      |
      | Third-party |
    And User creation form fields are not editable
      | Email     |
      | Username  |
      | User Type |
      | Role      |
      | Group     |
      | Superior  |
    And User creation form contains required indicator for fields
      | First Name  |
      | Last Name   |
      | Email       |
      | Username    |
      | User Type   |
      | Third-party |
    And User creation form doesn't contain required indicator for fields
      | Position |
      | Role     |
      | Active   |
      | Group    |
      | Superior |
    And User clicks 'Cancel' button on User Page
    Then Users table is displayed
    When User clicks on user with First Name "External_AT_FN"
    Then Overview User modal is displayed
    When User clicks User Overview Edit button
    Then Edit User page is displayed
    And User form button "Submit" is displayed
    And User form button "Cancel" is displayed
    And User creation form fields are editable
      | First Name  |
      | Last Name   |
      | Position    |
      | Active      |
      | Third-party |
    And User creation form fields are not editable
      | Email     |
      | Username  |
      | User Type |
      | Role      |
      | Group     |
      | Superior  |
    And User creation form contains required indicator for fields
      | First Name  |
      | Last Name   |
      | Email       |
      | Username    |
      | User Type   |
      | Third-party |
    And User creation form doesn't contain required indicator for fields
      | Position |
      | Role     |
      | Active   |
      | Group    |
      | Superior |

  @C40230312
  Scenario: C40230312: Edit External User: Verify the validation of the required fields
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_AT_FN"
    And User clicks edit user button for user with First Name "External_AT_FN"
    Then Edit User page is displayed
    When User clears User form fields
      | First Name |
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields |
    And Under User Form "First Name" field there is an error message: "This field is required"
    When User clears User form fields
      | Last Name |
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields |
    And Under User Form "Last Name" field there is an error message: "This field is required"
    When User clears User form fields
      | Third-party |
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Cannot save. Please complete the required fields |
    And Under User Form "Third-party" field there is an error message: "This field is required"

  @C40230661 @C32909423
  Scenario: C40230661, C32909423: Edit External User: Verify the User form can be submitted when all permitted fields are edited
  Edit External User - Verify User was able to edit Supplier Contact's Information in User Management (SI IdP)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "Test_First_Name"
    And User clicks edit user button for user with First Name "Test_First_Name"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "External AUTO TEST Edit Last Name"
    And User fills in "Position" Edit User value "External user position"
    And User selects in "Third-party" Edit User value "Supplier_Internal_User DO NOT DELETE"
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    And Edit User page is displayed
    When User clicks on back User Management button from User page
    And User searches user by first name
    Then First fined user is displayed with values
      | First Name   | Last Name                         | User Type | Status   |
      | toBeReplaced | External AUTO TEST Edit Last Name | External  | INACTIVE |

  @C40230753 @C32909498
  Scenario: C40230753, C32909498: Edit External User: Verify changes can be canceled
  Edit External User - Verify user was able to update Supplier Contact or External User status from "Inactive" to "Active" status in User popup of User Management
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "Test_First_Name"
    And User clicks edit user button for user with First Name "Test_First_Name"
    And User fills in "First Name" Edit User value "AUTO_TEST_EXTERNAL_EDIT"
    And User fills in "Last Name" Edit User value "Last Name"
    And User fills in "Position" Edit User value "External user position"
    And User selects in "Third-party" Edit User value "Supplier_Internal_User DO NOT DELETE"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    When User fills in "First Name" Edit User value "Test Edit And Cancel Name"
    And User fills in "Last Name" Edit User value "External AUTO TEST Edit Last Name"
    And User fills in "Position" Edit User value "External user position edit"
    And User selects in "Third-party" Edit User value "Supplier_Internal_User DO NOT DELETE"
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Cancel' button on User Page
    When User searches user by "AUTO_TEST_EXTERNAL_EDIT" keyword
    Then First fined user is displayed with values
      | First Name              | Last Name | User Type | Status |
      | AUTO_TEST_EXTERNAL_EDIT | Last Name | External  | ACTIVE |

  @C40332442
  Scenario: C40332442: Edit External User: Verify that changes in First Name, Last Name are reflected in Contacts section of corresponding Third Party
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by user reference "External User for Editing"
    And Users clicks on 1 users table row
    And User clicks User Overview Edit button
    And User fills in "First Name" Edit User value "toBeReplaced"
    And User fills in "Last Name" Edit User value "External AUTO TEST Edit Last Name"
    And User clicks 'Submit' button on User Page
    Then Edit User page is displayed
    When User navigates to Third-party page
    And User searches third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | First Name    | Last Name    | Status |
      | false         | userFirstName | userLastName | Active |

  @C40332506 @C32909478
  Scenario: C40332506, C32909478: Edit External User: Verify that when a new Third Party is selected from the dropdown, the external user is displayed in the "Contacts" section of the corresponding Third Party
  Verify that user should be able to edit existing external user and should be able update supplier field and should be able to reassign external user to different supplier from the list and save it (#9193)
    Given User logs into RDDC as "Admin"
    And User creates valid email
    And User creates third-party "USG" via API and open it
    And External user creates "with valid email enabled as user" contact for "USG" third-party via API
    And User creates third-party "PETROCHINA HONG KONG LTD" via API and open it
    When User navigates 'Set Up' block 'User' section
    And User searches user by "userEditedFirstName" keyword
    And Users clicks on 1 users table row
    And User clicks User Overview Edit button
    And User selects in "Third-party" Edit User value "PETROCHINA HONG KONG LTD"
    And User clicks 'Submit' button on User Page
    Then Edit User page is displayed
    When User navigates to Third-party page
    And User searches third-party with name "USG"
    And User clicks third-party with name "USG"
    And User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party "with random name and valid email" does not appear in the Associated Parties table
    When User navigates to Third-party page
    And User searches third-party with name "PETROCHINA HONG KONG LTD"
    And User clicks third-party with name "PETROCHINA HONG KONG LTD"
    And User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | First Name          | Last Name          | Status |
      | false         | userEditedFirstName | userEditedLastName | Active |

  @C32909476
  @WSO2email
  Scenario: C32909476: Update User - Verify that internal user status should be updated and toast message 'Success User has been updated.' upon deactivating active user on EDIT modal
    Given User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    Then Users table is displayed
    When User searches user by "Internal_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    When User clicks on back User Management button from User page
    Then First fined user is displayed with values
      | First Name                | User Type | Status   |
      | Internal_User_For_Editing | Internal  | INACTIVE |
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User" user

  @C32909490
  Scenario: C32909490: Admin/Internal User- User Management - Edit External User - Verify that user type should not be able to change and not editable
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_AT_FN"
    And User clicks edit user button for user with First Name "External_AT_FN"
    Then User Type is not editable

  @C33504515
  Scenario: C33504515: User Management- Assign to multiple groups- Edit user- Verify that admin can assign internal user to multiple groups (SIDEV-11259)
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User creates valid email
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User clicks 'Cancel' button on User Page
    Then Users table is displayed
    And User table doesn't contain user with values
      | First Name   | Last Name    | User Name    | User Type | Role                 | Status | Single Sign On |
      | toBeReplaced | toBeReplaced | toBeReplaced | Internal  | System Administrator | ACTIVE | No             |
    When User searches User by user reference "Internal User for Editing"
    And Users clicks on 1 users table row
    And User clicks User Overview Edit button
    And User clears User form fields
      | Group |
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User searches User by user reference "Internal User for Editing"
    And Users clicks on 1 users table row
    Then User Overview "Group" field is displayed with ""
    When User clicks User Overview Edit button
    And User selects in "Group" Edit User value "AUTO_GROUP"
    And User clicks 'Cancel' button on User Page
    And User searches User by user reference "Internal User for Editing"
    And Users clicks on 1 users table row
    Then User Overview "Group" field is displayed with ""
