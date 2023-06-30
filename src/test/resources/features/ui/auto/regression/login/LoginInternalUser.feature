@ui @full_regression @core_regression @login
Feature: Authentication/Login - Login/Logout as Internal User

  As an user
  I want to be able to log into SI using my SI Username and Password
  So I can securely access my SI account

  @C35633514 @C35814781
  Scenario: C35633514, C35814781: Login - Internal user - verify that inactive user cannot login to SI
    Given User launches RDDC Login page
    When User fills email for user "Inactive User"
    And User fills "Inactive User" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |
