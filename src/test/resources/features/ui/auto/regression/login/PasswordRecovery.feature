@ui @login
Feature: Authentication/Login - Password Recovery Flow

  As a RDDC Administrator
  I want to be able to be able to activate Third-party Contacts So that
  I can manage which contacts should have access to RDDC for Onboarding Activities

  Background:
    Given User logs into RDDC as "Admin"

  @C36136340
  @core_regression
  @onlySingleThread
  @WSO2email
  Scenario: C36136340: Password recovery flow - Third-party Contacts (External user) - check Account Enabled Password Reset Instructions
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_For_Edit_External_User"
    And User clicks third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on Associated Party with name "External_User_For_Editing"
    And User unchecks 'Enabled as User' checkbox on contact screen
    And User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name                | Last Name                           | Country | Status   |
      | false         |       | External_User_For_Editing | External_User_For_Editing_Last_Name |         | Inactive |
    When User clicks on Associated Party with name "External_User_For_Editing"
    Then Contact status control is set to "Disable" position
    When User checks 'Enabled as User' checkbox on contact screen
    Then Contact status control is set to "Enable" position
    When User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name                | Last Name                           | Country | Status |
      | false         |       | External_User_For_Editing | External_User_For_Editing_Last_Name |         | Active |
    When User clicks Log Out button
    Then Email notification "Refinitiv Due Diligence Centre - Your Account has been Enabled" is received by "External User for Password Edit" user
    And Email "Refinitiv Due Diligence Centre - Your Account has been Enabled" contains the following text
      | Account Enabled                                            |
      | Hi External_User_For_Editing,                              |
      | Please note that the account registered with the user name |
      | has been enabled.                                          |
      | Thanks,                                                    |
      | Refinitiv Due Diligence Centre                             |
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User for Password Edit" user
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | Dear External_User_For_Editing,                                                                                         |
      | A request to change your account password has been received. Please click on the following link to change you password. |
      | Reset Password                                                                                                          |
      | For support, please visit                                                                                               |
      | https://my.refinitiv.com                                                                                                |
      | MyRefinitiv                                                                                                             |
      | customer support portal.                                                                                                |
      | To access the site, please go to:                                                                                       |
      | Best Regards,                                                                                                           |
      | Refinitiv Due Diligence Centre                                                                                          |
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    And Login input field with text "Enter New Password" is displayed
    And Login input field with text "Confirm password" is displayed
    When User clicks Save Password button
    Then "Enter New Password" fields contains validation message "Please fill out this field."
    When User fills 'Enter New Password' field with value "A-Za-z0-9!@#$%&*"
    And User clicks Save Password button
    Then "Confirm password" fields contains validation message "Please fill out this field."
    When User fills 'Confirm password' field with value "incorrect"
    And User clicks Save Password button
    Then Error message is displayed with error text
      | Passwords did not match. Please try again. |
    When User fills 'Enter New Password' field with value "12345678"
    And User fills 'Confirm password' field with value "12345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "l2345678"
    And User fills 'Confirm password' field with value "l2345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "lL345678"
    And User fills 'Confirm password' field with value "lL345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
    When User fills email for user "External User for Password Edit"
    And User fills "password" Password
    And User clicks Sign In button
    Then Home page is loaded

  @C36136911
  @full_regression
  @onlySingleThread
  @WSO2email
  Scenario: C36136911: Password recovery flow - Supplier Contacts (External user) - check View External User : Reset Password
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_For_Edit_External_User"
    And User clicks third-party with name "SUPPLIER_FOR_EDIT_EXTERNAL_USER"
    And User clicks on "Associated Parties" tab on Third-party page
    And User clicks on Associated Party with name "External_User_For_Editing"
    And User checks 'Enabled as User' checkbox on contact screen
    And User clicks Associated Party Overview contact button
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name                | Last Name                           | Country | Status |
      | false         |       | External_User_For_Editing | External_User_For_Editing_Last_Name |         | Active |
    When User clicks on Associated Party with name "External_User_For_Editing"
    And User clicks View External User
    Then External User modal is displayed with data
      | First Name                | Email                                        | Position | Last Name                           | User Name                                    | User Type | Third-party                     |
      | External_User_For_Editing | user.external.for.password.recovery.username |          | External_User_For_Editing_Last_Name | user.external.for.password.recovery.username | External  | SUPPLIER_FOR_EDIT_EXTERNAL_USER |
    When User clicks Reset Password User modal button
    Then Alert Icon is displayed with text
      | Success!                    |
      | Reset Password Successfully |
    When User clicks Log Out button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User for Password Edit" user
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | Dear External_User_For_Editing,                                                                                         |
      | A request to change your account password has been received. Please click on the following link to change you password. |
      | Reset Password                                                                                                          |
      | For support, please visit                                                                                               |
      | https://my.refinitiv.com                                                                                                |
      | MyRefinitiv                                                                                                             |
      | customer support portal.                                                                                                |
      | To access the site, please go to:                                                                                       |
      | Best Regards,                                                                                                           |
      | Refinitiv Due Diligence Centre                                                                                          |
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    And Login input field with text "Enter New Password" is displayed
    And Login input field with text "Confirm password" is displayed
    When User clicks Save Password button
    Then "Enter New Password" fields contains validation message "Please fill out this field."
    When User fills 'Enter New Password' field with value "A-Za-z0-9!@#$%&*"
    And User clicks Save Password button
    Then "Confirm password" fields contains validation message "Please fill out this field."
    When User fills 'Confirm password' field with value "incorrect"
    And User clicks Save Password button
    Then Error message is displayed with error text
      | Passwords did not match. Please try again. |
    When User fills 'Enter New Password' field with value "12345678"
    And User fills 'Confirm password' field with value "12345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "l2345678"
    And User fills 'Confirm password' field with value "l2345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "lL345678"
    And User fills 'Confirm password' field with value "lL345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
    When User fills email for user "External User for Password Edit"
    And User fills "password" Password
    And User clicks Sign In button
    Then Home page is loaded

  @C36155944
  @full_regression
  @onlySingleThread
  @WSO2email
  Scenario: C36155944: Password recovery flow - Internal user - check 'Forgot password?' flow
    When User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "Internal_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "Internal_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks Log Out button
    And User clicks Forgot Password? button
    Then Page form is displayed with text
      | Forgot your password?                                                     |
      | Enter your email address and we'll send you a link to reset your password |
      | Back to Login                                                             |
    When User fills email for user "Internal User"
    And User clicks 'Reset' password button
    Then Info Modal is displayed with text
      | Check your inbox                                                                                                                   |
      | For registered email account in Refinitiv Due Diligence Centre, password recovery information has been sent to your email address. |
    When User clicks 'Ok' button
    Then Login page is displayed
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User" user
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | Dear Internal_User_For_Editing,                                                                                         |
      | A request to change your account password has been received. Please click on the following link to change you password. |
      | Reset Password                                                                                                          |
      | For support, please visit                                                                                               |
      | https://my.refinitiv.com                                                                                                |
      | MyRefinitiv                                                                                                             |
      | customer support portal.                                                                                                |
      | To access the site, please go to:                                                                                       |
      | Best Regards,                                                                                                           |
      | Refinitiv Due Diligence Centre                                                                                          |
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    And Login input field with text "Enter New Password" is displayed
    And Login input field with text "Confirm password" is displayed
    When User clicks Save Password button
    Then "Enter New Password" fields contains validation message "Please fill out this field."
    When User fills 'Enter New Password' field with value "A-Za-z0-9!@#$%&*"
    And User clicks Save Password button
    Then "Confirm password" fields contains validation message "Please fill out this field."
    When User fills 'Confirm password' field with value "incorrect"
    And User clicks Save Password button
    Then Error message is displayed with error text
      | Passwords did not match. Please try again. |
    When User fills 'Enter New Password' field with value "12345678"
    And User fills 'Confirm password' field with value "12345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "l2345678"
    And User fills 'Confirm password' field with value "l2345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "lL345678"
    And User fills 'Confirm password' field with value "lL345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
    When User fills email for user "Internal User"
    And User fills "password" Password
    And User clicks Sign In button
    And User accepts notice
    Then Home page is loaded

  @C36155945
  @full_regression
  @onlySingleThread
  @WSO2email
  Scenario: C36155945: Password recovery flow - External user - check 'Forgot password'
    When User navigates 'Set Up' block 'User' section
    And Users table is displayed
    And User searches user by "External_User_For_Editing" keyword
    And User clicks edit user button for user with First Name "External_User_For_Editing"
    And User checks 'Active' Edit User checkbox
    And User clicks 'Submit' button on User Page
    And User clicks Log Out button
    And User clicks Forgot Password? button
    Then Page form is displayed with text
      | Forgot your password?                                                     |
      | Enter your email address and we'll send you a link to reset your password |
      | Back to Login                                                             |
    When User fills email for user "External User for Password Edit"
    And User clicks 'Reset' password button
    Then Info Modal is displayed with text
      | Check your inbox                                                                                                                   |
      | For registered email account in Refinitiv Due Diligence Centre, password recovery information has been sent to your email address. |
    When User clicks 'Ok' button
    Then Login page is displayed
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User for Password Edit" user
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | Dear External_User_For_Editing,                                                                                         |
      | A request to change your account password has been received. Please click on the following link to change you password. |
      | Reset Password                                                                                                          |
      | For support, please visit                                                                                               |
      | https://my.refinitiv.com                                                                                                |
      | MyRefinitiv                                                                                                             |
      | customer support portal.                                                                                                |
      | To access the site, please go to:                                                                                       |
      | Best Regards,                                                                                                           |
      | Refinitiv Due Diligence Centre                                                                                          |
    When User opens "Refinitiv Due Diligence Centre - Password Reset" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    And Login input field with text "Enter New Password" is displayed
    And Login input field with text "Confirm password" is displayed
    When User clicks Save Password button
    Then "Enter New Password" fields contains validation message "Please fill out this field."
    When User fills 'Enter New Password' field with value "A-Za-z0-9!@#$%&*"
    And User clicks Save Password button
    Then "Confirm password" fields contains validation message "Please fill out this field."
    When User fills 'Confirm password' field with value "incorrect"
    And User clicks Save Password button
    Then Error message is displayed with error text
      | Passwords did not match. Please try again. |
    When User fills 'Enter New Password' field with value "12345678"
    And User fills 'Confirm password' field with value "12345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "l2345678"
    And User fills 'Confirm password' field with value "l2345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills 'Enter New Password' field with value "lL345678"
    And User fills 'Confirm password' field with value "lL345678"
    And User clicks Save Password button
    Then Error message should appear "Your password should contain at least 8 characters with lower case letters (i.e. a-z), upper case letters (i.e. A-Z), numbers (i.e. 0-9), special characters (!@#$%&*)"
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
    When User fills email for user "External User for Password Edit"
    And User fills "password" Password
    And User clicks Sign In button
    Then Home page is loaded

