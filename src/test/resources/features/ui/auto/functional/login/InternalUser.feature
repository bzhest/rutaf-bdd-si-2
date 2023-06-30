@ui @functional @login
Feature: Login - Internal User

  @C32926835 @C32926877
  Scenario: C32926835, C32926877: Internal User - Verify that upon login with INVALID PASSWORD for INTERNAL user in SI Idp should display VALIDATION message 'Login failed! Please recheck the username and password and try again.' w/o google authenticator
    Given User launches RDDC Login page
    When User fills email for user "Admin"
    And User fills "invalid" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |

  @C32926843
  Scenario: C32926843: Internal Login- Verify that user should be able to login with valid user name with combination of uppercase and lowercase letters
    Given User launches RDDC Login page
    When User fills email for user "Admin" with upper and lower case
    And User fills "Admin" Password
    And User clicks Sign In button
    Then Home page is loaded

  @C32926856 @C32926864
  Scenario: C32926856, C32926864: Internal User - Verify that internal user should be able to login successfully with VALID credentials using SI IDP without Google Authenticator
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User "Admin" enters username and password
    Then Home page is loaded

  @C35716912
  Scenario: C35716912: Login/logout as internal user - Verify that Home page is in React page
    Given User logs into RDDC as "Admin"
    When User clicks Log Out button
    And User opens a new tab and switches to new tab
    And User navigates to Home page
    Then Login page is displayed

  @C35936516
  Scenario: C35936516: Login Internal User on Error Page - Verify that user is redirected to MyRefinitiv support page
    Given User logs into RDDC as "Admin"
    When User navigates to error page
    Then Error page is displayed
    When User clicks Error page link
    Then User should be redirected to "https://my.refinitiv.com/content/mytr/en/signin.html"

  @C35936518
  Scenario: C35936518: Login Internal User on Error Page - Verify that the error message is correct and hyperlink is clickable
    Given User logs into RDDC as "Admin"
    When User navigates to error page
    Then Error page is displayed
    And Error page link is displayed
    And Error page message "Something went wrong. Please try again. For support, please visit MyRefinitiv customer support portal." is displayed
