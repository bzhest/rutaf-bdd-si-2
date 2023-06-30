@ui @full_regression @user_management
Feature: Deactivate Role from Role List

  As a Supplier Integrity Administrator
  I want to be able to be able to deactivate Roles
  So that I can deactivate the Roles that are no longer needed or being used

  @C35728499
  Scenario: C35728499 User Management - Role - Deactivate Role from Role List (Deactivate role)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "User Role Full Details" data
    And User searches role by name
    And User selects role in roles list
    And User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | The selected role(s) will be deactivated |
      | Do you want to proceed?                  |
    When User clicks No button on confirmation window
    And User searches role by name
    Then Role status is "Active"
    When User clicks 'Deactivate' button
    And User clicks Yes button on confirmation window
    And User searches role by name
    Then Role status is "Inactive"

  @C35728499
  Scenario: C35728499 User Management - Role - Deactivate Role from Role List (Deactivate assigned to user role)
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    And Add Active role with "Default Role Details" data
    And User navigates 'Set Up' block 'User' section
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "AUTO TEST Last Name"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "toBeReplaced"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    And User navigates 'Set Up' block 'Role' section
    And User searches role by name
    And User selects role in roles list
    And User clicks 'Deactivate' button
    Then Message is displayed on confirmation window
      | This Role is currently in use and you cannot |
      | deactivate it                                |
    When User clicks Proceed button on confirmation window
    And User searches role by name
    Then Role status is "Active"