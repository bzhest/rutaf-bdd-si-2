@ui @user_preferences
Feature: User Preferences

  As a RDDC User
  I want to have a way to configure my User Account Preferences
  So that I can change

  @C35652396
  @full_regression @core_regression
  @onlySingleThread
  Scenario: C35652396: User Preferences - Edit Third-party Contact - Verify that the changes are reflected on the Third-party Contact page
    Given User logs into RDDC as "External User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    When External User updates First Name Personal Details with value random name
    And External User updates Last Name Personal Details with value random name
    And External User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks on "Associated Parties" tab on Third-party page
    Then Associated Party table contains associated party with values
      | Key Principal | Title | First Name          | Last Name          | Country | Status |
      | false         |       | userEditedFirstName | userEditedLastName |         | Active |

  @C35653854
  @core_regression
  @onlySingleThread
  @WSO2email
  Scenario: C35653854: User Preferences - Internal user - Update all details
    Given User logs into RDDC as "Internal User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page is displayed
    And Personal Details section required field "First Name" is enabled
    And Personal Details section required field "Last Name" is enabled
    And Personal Details section field "Position" is enabled
    And Personal Details section photo placeholder is enabled
    And System Setting Date Format is disabled
    And System Setting Date Format is "Month Day Year"
    And System Setting Email Notification is displayed
    And My Preferences page Save button is disabled
    When User updates First Name Personal Details with value random name
    And User updates Last Name Personal Details with value random name
    And User updates Position Personal Details with value random name
    And User uploads Personal Details "logo.jpg" photo
    And User clicks Email Notification
    Then My Preferences page Save button is enabled
    When User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    And User waits for progress bar to disappear from page
    And User clicks Log Out button
    And User logs into RDDC as "Internal User for Editing"
    And User navigates to Preferences page
    Then First Name Personal Details contains expected value
    And Last Name Personal Details contains expected value
    And Position Personal Details contains expected value
    And Personal Details section photo is displayed
    And Email Notification is clicked
    When User navigates 'Set Up' block 'User' section
    And User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name    | Position     |
      | toBeReplaced | toBeReplaced | toBeReplaced |
    And Profile photo icon on the upper right corner of the screen is displayed
    When User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "Internal User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User for Editing" user
    And Email "Refinitiv Due Diligence Centre - Password Reset" contains the following text
      | userEditedFirstName |

  @C35621667
  @full_regression
  Scenario: C35621667: User Preferences - Internal user - My Preferences Page
    Given User logs into RDDC as "Admin"
    Then Header "Hi, Admin_AT_FN" label is displayed
    And Header photo placeholder is displayed
    And User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page is displayed
    And Personal Details section required field "First Name" is enabled
    And Personal Details section required field "Last Name" is enabled
    And Personal Details section field "Position" is enabled
    And Personal Details section photo placeholder is enabled
    And System Setting Date Format is disabled
    And System Setting Date Format is "Month Day Year"
    And System Setting Email Notification is displayed
    And My Preferences page Save button is disabled

  @C35633890
  @full_regression
  Scenario: C35633890: User Preferences - External user - My Preferences Page
    Given User logs into RDDC as "External"
    Then Header "Hi, External_AT_FN" label is displayed
    And Header photo placeholder is displayed
    And User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    And Personal Details section required field "First Name" for External User is enabled
    And Personal Details section required field "Last Name" for External User is enabled
    And Personal Details section field "Position" for External User is enabled
    And Personal Details section photo placeholder for External User is enabled
    And System Setting Date Format for External User is disabled
    And System Setting for External User Date Format is "Month Day Year"
    And System Setting Email Notification for External User is displayed
    And My Preferences page Save button for External User is disabled
    When External User updates First Name Personal Details with value random name
    And External User updates Last Name Personal Details with value random name
    And External User updates Position Personal Details with value random name
    And External User clicks Email Notification
    Then My Preferences page Save button for External User is enabled

  @C35629665
  @full_regression
  @onlySingleThread
  Scenario: C35629665: User Preferences - Internal user - Edit Personal Details
    Given User logs into RDDC as "Internal User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page is displayed
    And My Preferences page Save button is disabled
    When User updates First Name Personal Details with value random name
    Then My Preferences page Save button is enabled
    When User updates First Name Personal Details with previous value
    Then My Preferences page Save button is disabled
    When User clears First Name
    And User clears Last Name
    Then Error message "This field is required" in red color is displayed near User Preferences fields
      | First Name |
      | Last Name  |
    When User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Error message "This field is required" in red color is displayed near User Preferences fields
      | First Name |
      | Last Name  |
    When User updates First Name Personal Details with value random name
    And User updates Last Name Personal Details with value random name
    And User updates Position Personal Details with value random name
    And User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    Then First Name Personal Details contains expected value
    And Last Name Personal Details contains expected value
    And Position Personal Details contains expected value
    When User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name    | Position     |
      | toBeReplaced | toBeReplaced | toBeReplaced |

  @C35633891
  @full_regression
  @onlySingleThread
  Scenario: C35633891: User Preferences - External user - Edit Personal Details
    Given User logs into RDDC as "External User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    And My Preferences page Save button for External User is disabled
    When External User updates First Name Personal Details with value random name
    Then My Preferences page Save button for External User is enabled
    When External User updates First Name Personal Details with previous value
    Then My Preferences page Save button for External User is disabled
    When External User clears First Name
    And External User clears Last Name
    Then Error message "This field is required" in red color is displayed near Profile fields
      | First Name |
      | Last Name  |
    When External User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Cannot Save                         |
      | Please complete the required fields |
    And Error message "This field is required" in red color is displayed near Profile fields
      | First Name |
      | Last Name  |
    When External User updates First Name Personal Details with value random name
    And External User updates Last Name Personal Details with value random name
    And External User updates Position Personal Details with value random name
    And External User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    Then First Name Personal Details for External User contains expected value
    And Last Name Personal Details for External User contains expected value
    And Position Personal Details for External User contains expected value
    When User logs into RDDC as "Admin"
    And User navigates 'Set Up' block 'User' section
    And User searches user by first name
    And User clicks on updated user
    Then Overview User modal is displayed
    And User overview is displayed with values
      | First Name   | Last Name    | Position     |
      | toBeReplaced | toBeReplaced | toBeReplaced |

  @C35632604
  @full_regression
  @onlySingleThread
  @email @WSO2email
  Scenario: C35632604: User Preferences - Internal user - Edit System Settings
    Given User logs into RDDC as "Internal User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page is displayed
    And System Setting Date Format is disabled
    And System Setting Date Format is "Month Day Year"
    And System Setting Email Notification is displayed
    And My Preferences page Save button is disabled
    When User clicks Email Notification
    Then My Preferences page Save button is enabled
    When User clicks Email Notification
    Then My Preferences page Save button is disabled
    When User turns On Email Notification
    And User clicks Save preferences button
    When User turns Off Email Notification
    And User saves current user name
    And User clicks Save preferences button
    And User refreshes page
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_Internal_User"
    And User clicks third-party with name "Supplier_Internal_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userInitialFirstName" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Email notification "Refinitiv Due Diligence Centre - Internal Questionnaire for Supplier_Internal_User DO NOT DELETE has been assigned to you" is not received by "Internal User for Editing" user
    When User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "Internal User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User for Editing" user
    When User logs into RDDC as "Internal User for Editing"
    And User navigates to Preferences page
    Then My Preferences page is displayed
    When User turns On Email Notification
    And User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    When User navigates to Third-party page
    And User searches third-party with name "Supplier_Internal_User"
    And User clicks third-party with name "Supplier_Internal_User"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "Internal" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_INTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userInitialFirstName" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Email notification "Questionnaire Assigned" with following values is received by "Internal User for Editing" user
      | <Activity_Name> | Internal Questionnaire for Supplier_Internal_User DO NOT DELETE |
    And User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "Internal User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "Internal User for Editing" user

  @C35633812
  @full_regression
  Scenario: C35633812: User Preferences - Internal user - Upload Photo
    Given User logs into RDDC as "Internal User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Set Up      |
      | Help        |
      | My Exports  |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    And Personal Details section photo placeholder for External User is enabled
    And Personal Details Upload Photo link for External User is displayed
    When External User uploads Personal Details "invalid.txt" photo
    Then Alert Icon is displayed with text
      | Error! The file type is not supported. |
    When External User uploads Personal Details "more10mb.jpg" photo
    Then Alert Icon is displayed with text
      | Error! File exceeded maximum size limit |
    When External User uploads Personal Details "racoon1.jpg" photo
    Then My Preferences page Save button is enabled
    And External User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |

  @C35633894
  @full_regression
  @onlySingleThread
  @WSO2email
  Scenario: C35633894: User Preferences - External user - Edit System Settings
    Given User logs into RDDC as "External User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    And System Setting Date Format for External User is disabled
    And System Setting for External User Date Format is "Month Day Year"
    And System Setting Email Notification for External User is displayed
    And My Preferences page Save button for External User is disabled
    When External User clicks Email Notification
    Then My Preferences page Save button for External User is enabled
    When External User clicks Email Notification
    Then My Preferences page Save button for External User is disabled
    When User turns Off Email Notification
    And External User saves current user name
    And User clicks Save preferences button
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userInitialFirstName" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Email notification "Refinitiv Due Diligence Centre - External Questionnaire for THIRD_PARTY_WITH_USER_DO_NOT_DELETE has been assigned to you" is not received by "External User for Editing" user
    When User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "External User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    Then Email notification "Refinitiv Due Diligence Centre - Password Reset" is received by "External User for Editing" user
    When User logs into RDDC as "External User for Editing"
    And External User navigates to Preferences page
    Then My Preferences page for External User is displayed
    When User turns On Email Notification
    And User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
    And User clicks Log Out button
    And User clicks Forgot Password? button
    And User fills email for user "External User for Editing"
    And User clicks 'Reset' password button
    And User clicks 'Ok' button
    When User logs into RDDC as "Admin"
    And User navigates to Third-party page
    And User searches third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks third-party with name "THIRD_PARTY_WITH_USER_DO_NOT_DELETE"
    And User clicks on Questionnaire tab
    And User clicks on Assign Questionnaire button
    And User selects "External" type
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "AUTO_TEST_EXTERNAL_QUESTIONNAIRE" questionnaire
    And User clicks "Next" Assign Questionnaire dialog button
    And User selects "userInitialFirstName" assignee
    And User clicks "Next" Assign Questionnaire dialog button
    Then Date input field is displayed
    When User clicks "Next" Assign Questionnaire dialog button
    Then Reviewer input field is displayed
    When User selects 'Skip this step' checkbox
    And User clicks "Finish" Assign Questionnaire dialog button
    Then Email notification "Questionnaire Assigned" with following values is received by "External User for Editing" user
      | <Activity_Name> | External Questionnaire for THIRD_PARTY_WITH_USER_DO_NOT_DELETE |

  @C35633895
  @full_regression
  Scenario: C35633895: User Preferences - External user - Upload Photo
    Given User logs into RDDC as "External User for Editing"
    Then User menu items are displayed
      | Preferences |
      | Help        |
      | Log Out     |
    When User clicks Preferences option
    Then My Preferences page for External User is displayed
    And Personal Details section photo placeholder for External User is enabled
    And Personal Details Upload Photo link for External User is displayed
    When External User uploads Personal Details "invalid.txt" photo
    Then Alert Icon is displayed with text
      | Error! The file type is not supported. |
    When External User uploads Personal Details "more25mb.jpg" photo
    Then Alert Icon is displayed with text
      | Error! The file reached maximum file size of 25 MB |
    When External User uploads Personal Details "racoon1.jpg" photo
    Then My Preferences page Save button is enabled
    When User clicks Save preferences button
    Then Alert Icon is displayed with text
      | Success! Preferences has been updated |
