@ui @login
Feature: Authentication/Login - Login Form

  @C35621430
  @full_regression
  Scenario: C35621430: Login - check 'Privacy Policy' link
    Given User launches RDDC Login page
    Then Login page footer displayed with text
      | Use of this website signifies your agreement to the Terms of Use and Online Privacy Policy |
    When User clicks on 'Privacy Policy' link
    Then User should be redirected to "https://www.refinitiv.com/en/policies/privacy-statement"

  @C35621606
  @core_regression
  Scenario: C35621606: Login - check validation for Username/Password correctness
    Given User launches RDDC Login page
    When User fills "Admin" Password
    And User clicks Sign In button
    Then Username fields contains validation message "Please fill out this field."
    When User fills email for user "Admin"
    And User fills "invalid" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |
    When User fills "supplierintegritysaINVALID@gmail.com" Username
    And User fills "Admin" Password
    And User clicks Sign In button
    Then Error message is displayed with error text
      | Login failed! Please recheck the username and password and try again. |
    When User "Admin" enters username and password
    Then Home page is loaded