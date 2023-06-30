@ui @support
Feature: Login as Auto User

  As an auto-user
  I want to be able to log into RDCC using my RDDC Username and Password
  So I can securely access my RDDC account

  @auto_users
  Scenario Outline: Login to RDDC by auto-users
    Given User launches RDDC Login page
    Then Current URL contains Domain name
    When User "<User>" enters username and password
    And User accepts notice
    Then Home page is loaded
    Examples:
      | User                                         |
      | admin                                        |
      | external                                     |
      | restricted                                   |
      | restricted with edit permissions             |
      | assignee                                     |
      | approver                                     |
      | user without onboarding and renewal accesses |
      | admin double                                 |
      | external user for editing                    |
      | external user for password edit              |
      | internal user for editing                    |
      | internal user                                |
      | external user with similar email             |
      | forgot password                              |
      | external forgot password                     |
      | inactive user                                |
      | external inactive user                       |
      | reset password user                          |
      | empty metrics user                           |
      | user media check permission on               |
      | user media check permission off              |
      | user screening permission off                |
      | changing role user                           |

  @setUpDefaultLanguageToUsers
  Scenario: Set up default language for users
    Given User logs into RDDC as "Admin"
    When User sets up default language via API for users
      | admin                                        |
      | external                                     |
      | restricted                                   |
      | restricted with edit permissions             |
      | assignee                                     |
      | approver                                     |
      | user without onboarding and renewal accesses |
      | admin double                                 |
      | internal user                                |
      | empty metrics user                           |
      | user media check permission on               |
      | user media check permission off              |
      | user screening permission off                |
      | changing role user                           |