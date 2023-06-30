@ui @functional @user_management @roles
Feature: Role - Deactivate Role

  As a RDDC Administrator
  I want to be able to assign preconfigured access rights to the users of RDDC
  So that I can efficiently manage the access rights of each user

  @C44055494
  Scenario: C44055494: (Set Up/Role) - User can deactivate a role that is not in use
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "User Role Full Details" data
    And User searches role by name
    And User selects role in roles list
    Then Role #0 checkbox is checked in roles list
    And Deactivate button is displayed on Roles list page
    When User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | The selected role(s) will be deactivated |
      | Do you want to proceed?                  |
    When User clicks No button on confirmation window
    And User searches role by name
    Then Role status is "Active"
    When User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | The selected role(s) will be deactivated |
      | Do you want to proceed?                  |
    When User clicks Yes button on confirmation window
    Then Alert Icon is displayed with text
      | Success! Role(s) has been deactivated. |
    When User searches role by name
    Then Role status is "Inactive"

  @C44055495
  Scenario: C44055495: (Set Up/Role) - Role that is in use cannot be deactivated
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And Add Active role with "role mandatory fields" data
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "toBeReplaced"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User navigates 'Set Up' block 'Role' section
    And User waits for progress bar to disappear from page
    And User selects role in roles list
    And User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | This Role is currently in use and you cannot |
      | deactivate it                                |
    When User clicks Proceed button on confirmation window
    And User searches role by name
    Then Role status is "Active"