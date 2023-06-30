@ui @smoke @login
Feature: Authentication/Login - Login/Logout as External User

  As an External user
  I want to be able to log into SI using my SI Username and Password
  So I can securely access my SI account

  @C44139316
  Scenario: C44139316: Login/Logout - External User
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User "External" enters username and password
    Then Home page is loaded
    When User clicks Log Out button
    Then Login page is loaded
    And Current URL contains Domain name