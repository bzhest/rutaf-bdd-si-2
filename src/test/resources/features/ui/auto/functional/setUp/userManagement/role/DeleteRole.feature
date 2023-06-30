@ui @functional @user_management @roles
Feature: Role - Delete Role

  As a RDDC Administrator
  I want to be able to see all the Roles of RDDC
  So that I can manage the Roles and their access as necessary

  @C32909907 @C44056293
  Scenario: C32909907, C44056293: Role Setup - Verify that prompt message - 'This role is currently in use and you will not be able to delete it.' will display when deleting role that is currently in use
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
    And User searches role by name
    And User selects role in roles list
    Then Role #0 checkbox is checked in roles list
    When User hovers over Role 'Delete' button
    Then Delete button color is changed to red
    And Tooltip text is displayed
      | Delete |
    When User clicks 'Delete' button
    Then Message is displayed on confirmation window
      | This role is currently in use         |
      | and you will not be able to delete it |
    And Confirmation button Proceed should be displayed
    When User clicks Proceed button on confirmation window
    And User searches role by name
    Then Role is displayed in roles list
    And Role status is "Active"

  @C32909911 @C32909943 @C44056292
  Scenario: C32909911, C32909943, C44056292: Role Setup - Verify that user can select existing roles and hit delete icon
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    Then Button 'Add New Role' should be displayed
    When Add Active role with "role mandatory fields" data
    And User selects role in roles list
    Then Role #0 checkbox is checked in roles list
    When User hovers over Role 'Delete' button
    Then Tooltip text is displayed
      | Delete |
    When User clicks 'Delete' button
    Then Message is displayed on confirmation window
      | Are you sure you want to delete this role? |
      | This change cannot be undone.              |
    And Confirmation button Proceed should be displayed
    And Confirmation button Cancel should be displayed
    When User clicks Cancel button on confirmation window
    Then Role is displayed in roles list
    When User clicks 'Delete' button
    And User clicks Proceed button on confirmation window
    Then Alert Icon is displayed with text
      | Success               |
      | Role has been deleted |