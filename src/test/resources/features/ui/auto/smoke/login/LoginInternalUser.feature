@ui @smoke @login
Feature: Authentication/Login - Login/Logout as Internal User

  As an user
  I want to be able to log into SI using my SI Username and Password
  So I can securely access my SI account

  @C44131945
  Scenario: C44131945: Login/Logout - Internal User
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User "Admin" enters username and password
    And User accepts notice
    Then Home page is loaded
    When User clicks Log Out button
    Then Login page is loaded
    And Current URL contains Domain name

