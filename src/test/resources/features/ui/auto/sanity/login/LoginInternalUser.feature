@ui @sanity @login @multilanguage
Feature: Login/Logout as Internal User

  As an user
  I want to be able to log into SI using my SI Username and Password
  So I can securely access my SI account

  @C32987400 @C35619948
  @core_regression @base_test
  Scenario: C32987400, C35619948: Login - Login as Internal User
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User "Admin" enters username and password
    And User accepts notice
    Then Home page is loaded

  @C32987535
  Scenario: C32987535: Logout - Internal User log out
    Given User launches RDDC Login page
    And User "Admin" enters username and password
    And User accepts notice
    And Home page is loaded
    When User clicks Log Out button
    Then Login page is loaded
    And Current URL contains Domain name

  @C32987288
  @WSO2email
  Scenario: C32987288: Login - Internal User - Set up password
    Given User creates valid email
    When User logs into RDDC as "Admin"
    And User sets up language via API
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    Then Add User page is loaded
    And User Type is "Internal"
    When User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User clicks Log Out button
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    And Email "Refinitiv Due Diligence Centre - Create Password for New Account" contains the following text
      | Dear userFirstName,                                                                          |
      | Welcome to Refinitiv Due Diligence Centre, your user name is:                                |
      | <b>%s</b>                                                                                    |
      | Please click the confirmation below to activate your Refinitiv Due Diligence Centre account. |
      | Create Password                                                                              |
      | For support, please visit                                                                    |
      | https://my.refinitiv.com                                                                     |
      | MyRefinitiv                                                                                  |
      | customer support portal.                                                                     |
      | To access the site, please go to:                                                            |
      | Best Regards,                                                                                |
      | Refinitiv Due Diligence Centre                                                               |
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account. |
    And Current URL contains Domain name
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
    When User logs into RDDC as "Admin"
    Then Home page is loaded

  @C32987365 @C35620345
  @core_regression
  @WSO2email
  Scenario: C32987365, C35620345: Login - Internal User - Forgot Password
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User clicks Forgot Password? button
    Then Page form is displayed with text
      | Forgot your password?                                                     |
      | Enter your email address and we'll send you a link to reset your password |
      | Back to Login                                                             |
    When User fills email for user "Forgot Password"
    And User clicks 'Reset' password button
    Then Info Modal is displayed with text
      | Check your inbox                                                                                                                   |
      | For registered email account in Refinitiv Due Diligence Centre, password recovery information has been sent to your email address. |
    When User clicks 'Ok' button
    Then Login page is displayed
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received

  @C32987366
  @WSO2email
  Scenario: C32987366: Login - Internal User - Reset Password
    Given User launches RDDC Login page
    And User clicks Forgot Password? button
    And User fills email for user "Reset Password User"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | Dear Auto_Internal_Reset,                                                                                               |
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
    And Current URL contains Domain name
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
