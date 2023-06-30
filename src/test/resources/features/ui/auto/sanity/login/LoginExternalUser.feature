@ui @sanity @login @multilanguage
Feature: Login/Logout as External User

  As an External user
  I want to be able to log into SI using my SI Username and Password
  So I can securely access my SI account

  @C32987533 @C35633662
  @core_regression
  Scenario: C32987533, C35633662: Login - Login as External User
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User "External" enters username and password
    Then Home page is loaded

  @C32987536
  Scenario: C32987536: Logout - External User log out
    Given User launches RDDC Login page
    And User "External" enters username and password
    And Home page is loaded
    When User clicks Log Out button
    Then Login page is loaded
    And Current URL contains Domain name

  @C32987532
  @WSO2email
  Scenario: C32987532: Login - External User - Set up password
    Given User creates valid email
    When User logs into RDDC as "Admin"
    And User sets up language via API
    And User creates third-party "with random ID name" via API and open it
    And User creates Associated Party "with valid email"
    And User checks 'Enabled as User' checkbox on contact screen
    And User clicks Log Out button
    And Email notification "Refinitiv Due Diligence Centre - Create Password for New Account" is received
    And Email "Refinitiv Due Diligence Centre - Create Password for New Account" contains the following text
      | Dear contactTestData,                                                      |
      | Welcome to <Brand_Name>, your user name is:                                |
      | <b>%s</b>                                                                  |
      | Please click the confirmation below to activate your <Brand_Name> account. |
      | Create Password                                                            |
      | For support, please visit                                                  |
      | https://my.refinitiv.com                                                   |
      | MyRefinitiv                                                                |
      | customer support portal.                                                   |
      | To access the site, please go to:                                          |
      | Best Regards,                                                              |
      | <Signature>                                                                |
    When User opens "Refinitiv Due Diligence Centre - Create Password for New Account" email link
    Then Page form is displayed with text
      | Set your Password to better protect your account |
    And Current URL contains Domain name
    When User fills Enter New Password field with value "A-Za-z0-9!@#$%&*"
    And User fills 'Confirm password' field
    And User clicks Save Password button
    Then Message "Updated the password successfully" is shown
    When User clicks 'Ok' button
    Then Login page is displayed
    When User logs into RDDC as "Admin"
