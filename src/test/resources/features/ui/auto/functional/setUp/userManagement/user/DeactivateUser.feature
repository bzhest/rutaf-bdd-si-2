@ui @functional @user_management
Feature: Set Up - User Management - Deactivate User

  As a RDDC user with appropriate permissions
  I want to be able to deactivate user accounts
  So that I can deactivate user accounts that should not be able to log into RDDC

  @C32909475 @C32909404 @C32909430 @C40208095 @C40304669
  @WSO2email
  Scenario: C32909475, C32909404, C32909430, C40208095, C40304669: [moved] User Management - Verify that user can select multiple active Internal/External users and deactivate them - Internal User
  Activate User- Verify that upon activating the deactivated/inactive user the email settings for that user should be automatically turned ON and should received Reset Password email notification
  Update User - Verify that activating inactive Internal/External user should received PASSWORD RESET email notification
  User Management - Verify RDDC email notification "Account Disabled" is sent for RDDC IdP User
  User Management - Verify RDDC email notification "Account Enabled" is sent for RDDC IdP User
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User creates valid email
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "AUTO_TEST_DEACTIVATE"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User creates valid email
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "AUTO_TEST_DEACTIVATE"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User navigates to Home page
    And User clicks Set Up option
    And User selects "Active" show option
    And User searches user by "AUTO_TEST_DEACTIVATE" keyword
    And User checks User table checkbox for row 1
    And User checks User table checkbox for row 2
    And User clicks User Management Deactivate button
    Then Message is displayed on confirmation window
      | The selected user(s) will be deactivated. Do you want to proceed? |
    And Confirmation button No should be displayed
    And Confirmation button Yes should be displayed
    When User clicks No button on confirmation window
    Then Confirmation window is disappeared
    When User clicks User Management Deactivate button
    And User clicks Yes button on confirmation window
    And User selects "Inactive" show option
    Then User table contains user with values
      | First Name           | Last Name    | User Name    | User Type | Role                 | Status   | Single Sign On |
      | AUTO_TEST_DEACTIVATE | toBeReplaced | toBeReplaced | Internal  | System Administrator | INACTIVE | No             |
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Disabled" is received
    When User searches user by "userLastName" keyword
    And User clicks edit user button for user with First Name "AUTO_TEST_DEACTIVATE"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    When User refreshes page
    Then User form "Active" is checked
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Enabled" is received
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button

  @C32909475 @C32909404 @C32909430 @C40208095 @C40304669
  @WSO2email
  Scenario: C32909475, C32909404, C32909430, C40208095, C40304669: [moved] User Management - Verify that user can select multiple active Internal/External users and deactivate them - External User
  Activate User- Verify that upon activating the deactivated/inactive user the email settings for that user should be automatically turned ON and should received Reset Password email notification
  Update User - Verify that activating inactive Internal/External user should received PASSWORD RESET email notification
  User Management - Verify RDDC email notification "Account Disabled" is sent for RDDC IdP User
  User Management - Verify RDDC email notification "Account Enabled" is sent for RDDC IdP User
    Given User logs into RDDC as "Admin"
    When User creates third-party "USG" via API and open it
    And User creates valid email
    And External user creates "AUTO_TEST_DEACTIVATE_EXTERNAL" contact for "USG" third-party via API
    And User creates valid email
    And External user creates "AUTO_TEST_DEACTIVATE_EXTERNAL" contact for "USG" third-party via API
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User navigates to Home page
    And User clicks Set Up option
    And User searches user by "AUTO_TEST_DEACTIVATE_EXTERNAL" keyword
    And User checks User table checkbox for row 1
    And User checks User table checkbox for row 2
    And User clicks User Management Deactivate button
    Then Message is displayed on confirmation window
      | The selected user(s) will be deactivated. Do you want to proceed? |
    And Confirmation button No should be displayed
    And Confirmation button Yes should be displayed
    When User clicks No button on confirmation window
    Then Confirmation window is disappeared
    When User clicks User Management Deactivate button
    And User clicks Yes button on confirmation window
    And User selects "Inactive" show option
    Then User table contains user with values
      | First Name                    | Last Name          | User Name | User Type | Status   | Single Sign On | Third-party |
      | AUTO_TEST_DEACTIVATE_EXTERNAL | userEditedLastName | email     | External  | INACTIVE | No             | USG         |
    And Email notification "Refinitiv Due Diligence Centre - Your Account has been Disabled" is received
    When User searches user by "userEditedLastName" keyword
    And User clicks edit user button for user with First Name "AUTO_TEST_DEACTIVATE_EXTERNAL"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    Then Alert Icon is displayed with text
      | Success! User has been updated. |
    And User form "Active" is checked
    Then Email notification "Refinitiv Due Diligence Centre - Your Account has been Enabled" is received
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button

  @C40202700
  @WSO2email
  Scenario: C40202700: User Management - Verify that deactivated user can not log in RDDC
    Given User logs into RDDC as "Admin"
    And User creates valid email
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    And User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    And User clicks Set Up option
    And User searches user by first name
    And User clicks edit user button by name
    And User unchecks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks on back User Management button from User page
    And User refreshes page
    Then Users table is displayed
    When User clicks Log Out button
    Then Login page is displayed
    When User fills email "email" from context
    And User fills "password" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |
    When User logs into RDDC as "Admin"

  @C40202704
  Scenario: C40202704: User Management - Verify that Inactive Internal User can not be deactivated
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User selects "Inactive" show option
    Then User table checkbox for row 1 is disabled
    When User hovers over User table checkbox for row 1
    Then Tooltip text is displayed
      | User cannot be deactivated due to inactive status |
