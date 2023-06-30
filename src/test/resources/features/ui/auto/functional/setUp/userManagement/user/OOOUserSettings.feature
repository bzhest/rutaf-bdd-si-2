@ui @functional @user_management
Feature: Set Up - User Management - Out of Office settings

  As a System Admin of SI,
  I want the system to have the record users who are currently out of office,
  So that I can see and edit OOO settings of all the internal users

  @C40532721
  Scenario: C40532721: [OOO] - Users - Validations - Assign to OOO user or assign to himself
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'User' section
    And User searches user by "Assignee_AT_FN" keyword
    And User clicks edit user button for user with First Name "Assignee_AT_FN"
    And User clicks User form button "Out of Office"
    And User fills in "From" Edit User value "TODAY-1"
    And User selects in "Delegate to" Edit User value "Assignee_AT_FN Assignee_AT_LN"
    Then Under User Form "Delegate to" field there is an error message: "You cannot delegate tasks to yourself or another user who is out of office. Please select another user for delegation."
    When User selects in "Delegate to" Edit User value "OOO_USER_FN OOO_USER_LN"
    Then Under User Form "Delegate to" field there is an error message: "You cannot delegate tasks to yourself or another user who is out of office. Please select another user for delegation."

  @C40652897
  Scenario: C40652897: [OOO] - Users- Verify page elements for Out of Office
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User searches user by "Assignee_AT_FN" keyword
    And User clicks edit user button for user with First Name "Assignee_AT_FN"
    And User clicks User form button "Out of Office"
    Then User form OOO notice is displayed
    And User form button "Back to office" is disabled
    And User form button "Save" is disabled
    And User form button "Cancel" is displayed
    And User creation form contains required indicator for fields
      | From |
    And User creation form doesn't contain required indicator for fields
      | To          |
      | Time        |
      | Delegate to |
      | Status      |
    And User form calendar button is displayed for fields
      | From |
      | To   |
    And User form timepicker button is displayed for Time fields
    And User form fields are empty
      | From        |
      | To          |
      | Time        |
      | Delegate to |
    And User "Delegate to" drop-down contains expected values
    And User form Status field is disabled
    When User selects in "Delegate to" Edit User value "Assignee_AT_FN Assignee_AT_LN"
    Then User form Status field is enabled
    And User "Status" drop-down contains expected values
    When User hovers User form status icon
    Then Tooltip text is displayed
      | Tasks\nNew Status\nOn-going Status\nOnboarding/Renewal\nActivities\nFor Approval, Not Started,\nFor Review\nIn progress, Waiting\nQuestionnaire\n(Responder/Reviewer)\nSubmitted, Level 0-5\nPending Review\nSaved as Draft, Level 0-5 In Review,\nRequires Revision, Revision in Draft\nDD Orders\nFor Approval\nNew, Pending, In Progress,\nOn-Hold (Only email notification)\nScreening (reviewer)\nFor Review\nFor Review\nThird-party for Renewal\nNew\nFor Renewal\nWorld-Check Screening OGS\nNew\nNew |

  @C40652900
  Scenario: C40652900: [OOO] - Users - Setup settings and click Cancel
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User searches user by "Assignee_AT_FN" keyword
    And User clicks edit user button for user with First Name "Assignee_AT_FN"
    And User clicks User form button "Out of Office"
    And User fills in "From" Edit User value "TODAY-1"
    And User selects in "Delegate to" Edit User value "Questionnaire_Approver_AT_FN Quest_Appr_AT_LN"
    And User selects in "Status" Edit User value "New"
    And User clicks 'Cancel' button on User Page
    Then User form fields are empty
      | From        |
      | To          |
      | Time        |
      | Delegate to |
    And User form OOO history message "NO AVAILABLE DATA" is displayed

  @C40602342
  Scenario: C40602342: [OOO] - View User - Verify page elements for Out of Office tab
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User searches user by "Assignee_AT_FN" keyword
    And User clicks on user with First Name "Assignee_AT_FN"
    And User clicks User form button "Out of Office"
    Then Overview User modal is displayed
    And User overview form fields are not editable
      | From        |
      | To          |
      | Time        |
      | Delegate to |
      | Status      |
    And User form OOO history message "NO AVAILABLE DATA" is displayed
    When User hovers User form status icon
    Then Tooltip text is displayed
      | Tasks\nNew Status\nOn-going Status\nOnboarding/Renewal\nActivities\nFor Approval, Not Started,\nFor Review\nIn progress, Waiting\nQuestionnaire\n(Responder/Reviewer)\nSubmitted, Level 0-5\nPending Review\nSaved as Draft, Level 0-5 In Review,\nRequires Revision, Revision in Draft\nDD Orders\nFor Approval\nNew, Pending, In Progress,\nOn-Hold (Only email notification)\nScreening (reviewer)\nFor Review\nFor Review\nThird-party for Renewal\nNew\nFor Renewal\nWorld-Check Screening OGS\nNew\nNew |

  @C40202642
  Scenario: C40202642: [OOO] - Users - Audit
    Given User logs into RDDC as "Admin"
    And User creates valid email
    When User clicks Set Up option
    And User clicks 'Add New User' button
    And User fills in "First Name" Add User value "toBeReplaced"
    And User fills in "Last Name" Add User value "toBeReplaced"
    And User fills in "Email" Add User value "toBeReplaced"
    And User selects in "Role" Add User value "System Administrator"
    And User selects in "Division" Add User value "MyDivision"
    And User clicks 'Submit' button on User Page
    Then Users table is displayed
    When User searches user by first name
    And User clicks edit user button by name
    And User clicks User form button "Out of Office"
    And User fills in "From" Edit User value "TODAY-1"
    And User fills in "Time" Edit User value "11:00 PM"
    And User selects in "Delegate to" Edit User value "Assignee_AT_FN Assignee_AT_LN"
    And User selects in "Status" Edit User value "New"
    And User clicks User form button "Save"
    Then User for OOO History table is displayed with last record
      | NAME                                   | DATE/TIME           | OLD VALUE                                     | NEW VALUE                                                                                                  |
      | Admin_AT_FN Admin_AT_LN (toBeReplaced) | dd/MM/yyyy - h:mm a | From N/A To N/A Delegated to: N/A Status: N/A | From TODAY-1 - 11:00 PM To N/A Delegated to: Assignee_AT_FN Assignee_AT_LN (assignee.username) Status: NEW |
    When User updated OOO delegations 9 times
    Then Pagination option "10" is selected
    When User updated OOO delegations 1 times
    And User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
    When User selects "10" items per page
    And User updated OOO delegations 15 times
    And User clicks pagination drop-down
    Then Pagination Drop-Down list is displayed with values
      | 10 |
      | 25 |
      | 50 |
    When User selects "25" items per page
    Then Pagination buttons should be visible
      | first | previous | next | last |
    And Table displays corresponding to pagination correct rows number
    When User clicks User form button "Back to office"
    And User clicks Yes button on confirmation window
    Then User for OOO History table is displayed with last record
      | NAME                                   | DATE/TIME           | OLD VALUE                                                                                                   | NEW VALUE                                                       |
      | Admin_AT_FN Admin_AT_LN (toBeReplaced) | dd/MM/yyyy - h:mm a | From TODAY-15 - 12:00 AM To N/A Delegated to: Assignee_AT_FN Assignee_AT_LN (assignee.username) Status: NEW | From TODAY-15 - 12:00 AM To TODAY Delegated to: N/A Status: N/A |

  @C40219768
  Scenario: C40219768: OOO - User Management - Verify that Internal user is able to edit/view OOO Settings for Internal user/not able for External in case permission is ON
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User searches user by "Assignee_AT_FN" keyword
    And User clicks on user with First Name "Assignee_AT_FN"
    Then User form button "Out of Office" is displayed
    When User clicks User Overview Edit button
    Then User form button "Out of Office" is displayed
    When User clicks on back User Management button from User page
    And User searches user by "External_AT_FN" keyword
    And User clicks on user with First Name "External_AT_FN"
    Then User form button "Out of Office" is not displayed

  @C40219802
  Scenario: C40219802: OOO - User Management - Verify that Out of Office is NOT available for External user
    Given User logs into RDDC as "External"
    When User clicks User Menu
    And User clicks Preferences option
    Then External User preferences Out of Office tab is not displayed

  @C40219769
  Scenario: C40219769: OOO - User Management - Verify that Internal user is NOT able to edit/view OOO Settings for Internal/External user in case permission is OFF
    Given User logs into RDDC as "user without onboarding and renewal accesses"
    When User clicks Set Up option
    And User searches user by "Assignee_AT_FN" keyword
    And User clicks on user with First Name "Assignee_AT_FN"
    Then User form button "Out of Office" is not displayed
    When User clicks User Overview Edit button
    Then User form button "Out of Office" is not displayed
    When User clicks on back User Management button from User page
    And User searches user by "External_AT_FN" keyword
    And User clicks on user with First Name "External_AT_FN"
    Then User form button "Out of Office" is not displayed

  @C40219770
  Scenario: C40219770: OOO - User Management - Verify that default OOO permission is OFF for new role
    Given User logs into RDDC as "Admin"
    When User navigates 'Set Up' block 'Role' section
    And User clicks 'Add New Role' button
    Then Role Management field "Out Of Office" toggle button is switched "Off"

  @C40602481
  Scenario: C40602481: OOO - User Management - Verify that Internal user is NOT able to edit/view OOO Settings for INACTIVE Internal user in case permission is ON
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option
    And User searches user by "Auto_Internal_Inactive" keyword
    And User clicks on user with First Name "Auto_Internal_Inactive"
    Then User form button "Out of Office" is not displayed
    When User clicks User Overview Edit button
    Then User form button "Out of Office" is not displayed
