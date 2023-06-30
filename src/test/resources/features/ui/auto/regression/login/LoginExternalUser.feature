@ui @login
Feature: Authentication/Login - Login/Logout as External User

  As an External user
  I want to be able to log into SI using my SI Username and Password
  So I can securely access my SI account

  @C35633666
  @full_regression
  Scenario: C35633666: Login - External user - verify that inactive user cannot login to SI
    Given User launches RDDC Login page
    When User fills email for user "External Inactive User"
    And User fills "External Inactive User" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |

  @C35633667
  @core_regression
  @WSO2email
  Scenario: C35633667: Login - External user - check 'Forgot password?' functionality
    Given User launches RDDC Login page
    When User clicks Forgot Password? button
    Then Page form is displayed with text
      | Forgot your password?                                                     |
      | Enter your email address and we'll send you a link to reset your password |
      | Back to Login                                                             |
    When User fills email for user "External Forgot Password"
    And User clicks 'Reset' password button
    Then Info Modal is displayed with text
      | Check your inbox                                                                                                                   |
      | For registered email account in Refinitiv Due Diligence Centre, password recovery information has been sent to your email address. |
    When User clicks 'Ok' button
    Then Login page is displayed
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received

  @C35838082
  @full_regression
  Scenario: C35838082: External User- Verify if user with "Like" or similar email address to others is able to access the assigned profile upon login to SI
    Given User logs into RDDC as "External User with similar email"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User navigates to 'Workflow Management' block 'Workflow' section
    And User waits for progress bar to disappear from page
    Then Current URL contains "/forbidden" endpoint
    And The following error message is displayed
      | FORBIDDEN                                                       |
      | You do not have permission to view this directory or page using |
      | the credentials that you supplied.                              |
    And Back button is displayed
