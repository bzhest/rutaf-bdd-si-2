@ui @functional @user_management
Feature: Set Up - User Management - View User

  As a RDDC System Administrator
  I want to view the users of RDDC
  So that I can read the users data when necessary


  @C40210673
  Scenario: C40210673: View User - Verify user details - Internal User
    Given User logs into RDDC as "Admin"
    And User makes sure that Custom field "Billing Entity" is set as required via API
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "Admin_AT_FN"
    And User clicks on user with First Name "Admin_AT_FN"
    Then Overview User modal is displayed
    And User overview form fields are not editable
      | Enable Single Sign On  |
      | First Name             |
      | Last Name              |
      | Email                  |
      | Username               |
      | Position               |
      | User Type              |
      | Role                   |
      | Active                 |
      | Group                  |
      | Superior               |
      | Language               |
      | Organisation           |
      | Division               |
      | Entity                 |
      | External Organisation  |
      | Department             |
      | Default Billing Entity |
      | Other Billing Entity   |
    And User form "Organisation information" section is displayed
    And User form button "Reset Password" is displayed
    When User hovers over User overview Edit icon
    Then Tooltip text is displayed
      | Edit |
    When User clicks on back User Management button from User page
    Then Users table is displayed

  @C40210681
  Scenario: C40210681: View User - Verify user details - External User
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "External_AT_FN"
    And User clicks on user with First Name "External_AT_FN"
    Then Overview User modal is displayed
    And User overview form fields are not editable
      | First Name  |
      | Last Name   |
      | Email       |
      | Username    |
      | Position    |
      | User Type   |
      | Role        |
      | Active      |
      | Group       |
      | Superior    |
      | Third-party |
      | Language    |
    And User form button "Reset Password" is displayed
    When User hovers over User overview Edit icon
    Then Tooltip text is displayed
      | Edit |
    When User clicks on back User Management button from User page
    Then Users table is displayed

  @C32909413 @C32909479
  @WSO2email
  Scenario: C32909413, C32909479: View External User: Verify that user should be able to setup new password and should be able to login
  View External User : Verify that user should received email notification with reset password link
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "Auto_Admin_Similar"
    And User clicks on user with First Name "Auto_Admin_Similar"
    Then Overview User modal is displayed
    When User clicks User form button "Reset Password"
    Then Alert Icon is displayed with text
      | Success! The system will generate and automatically send email with reset password link |
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User with similar email" user

  @C32909436 @C32909443
  @WSO2email
  Scenario: C32909436, C32909443: View Internal User: Verify that toast message should display "Success! The system will generate and automatically send email with reset password link"
  User Management-Reset password in User Management
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches User by name "Assignee_AT_FN"
    And User clicks on user with First Name "Assignee_AT_FN"
    Then Overview User modal is displayed
    When User clicks User form button "Reset Password"
    Then Alert Icon is displayed with text
      | Success! The system will generate and automatically send email with reset password link |
    And Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Assignee" user
