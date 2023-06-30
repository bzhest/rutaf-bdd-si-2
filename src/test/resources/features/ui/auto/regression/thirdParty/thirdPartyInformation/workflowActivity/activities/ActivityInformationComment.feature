@ui @full_regression @react @activity_information @robusta
Feature: Activity Information Page - Edit Comment

  As a RDDC User
  I want to add the comment to activity information
  so that I will be able to all comment related to the activity

  @C38461879
  @core_regression
  Scenario: C38461879: Activity Information page - Comment section should have the correct fields and details
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Created comment on Activity Information page is displayed

  @C38461880
  @core_regression
  Scenario: C38461880: Activity Information page - Comments field under Comments section should have maximum of 5000 characters (Alpha Numeric and Special Characters)
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity Information Page comment character limit message "Characters : 0/5000" is displayed
    When User on Activity Information page adds comment with 500 alphanumeric and special characters
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    And Created comment on Activity Information page is displayed
    When User on Activity Information page adds comment with 5000 alphanumeric and special characters
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    When User refreshes page
    Then The 5000-character comment on Activity Information page is displayed
    When User on Activity Information page adds comment with 5001 alphanumeric and special characters
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    When User refreshes page
    Then The 5000-character comment on Activity Information page is displayed

  @C38461883
  Scenario: C38461883: Activity Information page - Comments section See More link won't be displayed when comment is less than 3 lines
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds comment "Activity comment text N1"
    Then Created comment on Activity Information page is displayed
    And Activity information page comment block button "[See more]" is not displayed

  @C38461884
  Scenario: C38461884: Activity Information page - Comments should be arranged by Descending orderNewest on the TopOldest on the bottom
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds 4 comment "Activity comment text N"
    Then Created comments on Activity Information page is displayed in order
      | Activity comment text N4 |
      | Activity comment text N3 |
      | Activity comment text N2 |

  @C38461885
  Scenario: C38461885: Activity Information page - Comments section Show More link
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds 7 comment "Activity comment text N"
    Then Created comments on Activity Information page is displayed in order
      | Activity comment text N7 |
      | Activity comment text N6 |
      | Activity comment text N5 |
    When User clicks Activity Information comment section button "Show More"
    Then Created comments on Activity Information page is displayed in order
      | Activity comment text N7 |
      | Activity comment text N6 |
      | Activity comment text N5 |
      | Activity comment text N4 |
      | Activity comment text N3 |
      | Activity comment text N2 |

  @C38461886
  Scenario: C38461886: Activity Information page - Comments section Show All Comments and Hide Comments link
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds 7 comment "Activity comment text N"
    Then Created comments on Activity Information page is displayed in order
      | Activity comment text N7 |
      | Activity comment text N6 |
      | Activity comment text N5 |
    When User clicks Activity Information comment section button "Show all comments"
    Then Created comments on Activity Information page is displayed in order
      | Activity comment text N7 |
      | Activity comment text N6 |
      | Activity comment text N5 |
      | Activity comment text N4 |
      | Activity comment text N3 |
      | Activity comment text N2 |
      | Activity comment text N1 |
    And Activity information page comment section button "Hide comments" is displayed
    And Activity information page comment section button "Show all comments" is not displayed

  @C38461887
  Scenario: C38461887: Activity Information page - Comments section Show All Comments link won't be displayed when comment is less than 3
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    And User on Activity information page adds 2 comment "Activity comment text N"
    Then Activity information page comment section button "Show all comments" is not displayed

  @C38461888
  Scenario: C38461888: Activity Information page - Comments section Should be expanded by default
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information page comment section is expanded

  @C38461889
  Scenario: C38461889: Activity Information page - Comments section Should an Accordion
    Given User logs into RDDC as "Admin"
    When User creates third-party "workflowGroupUkraine" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "OrderDueDiligenceReport" activity
    Then Activity information page comment section is expanded
    When User clicks Activity Information comments section arrow
    Then Activity information page comment section is collapsed
    When User clicks Activity Information comments section arrow
    Then Activity information page comment section is expanded
    And Activity information page comment section button "Comment" is displayed
    And Activity information page comment section button "Comment" is disabled
    And Activity information page comment section button "Cancel" is displayed
    When User on Activity information page fills in comment text "Activity comment text N1"
    Then Activity information page comment section button "Comment" is enabled
    When User clicks Activity Information comment section button "Cancel"
    Then Comment "Activity comment text N1" on Activity information page should not be shown
    And Activity information page comment text area contains ""
    When User on Activity information page fills in comment text "Activity comment text N2"
    And User clicks Activity Information comment section button "Comment"
    Then Alert Icon is displayed with text
      | Success! Comment has been added. |
    And Comment "Activity comment text N2" on Activity information page should be shown
    And Activity information page comment text area contains ""

  @C38461890
  @core_regression
  @RMS-20683
  Scenario: C38461890: Activity Information page - Comments section should have maximum of 20 comments
    Given User logs into RDDC as "Admin"
    When User creates third-party "with questionnaire workflow" via API and open it
    And User clicks Start Onboarding for third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User on Activity information page adds 19 comment "Activity comment text N"
    And User navigates to Third-party page
    And User searches created third-party
    And User clicks on created third-party
    And User clicks "New Component" component tab
    And User clicks on "Assign Questionnaire1" activity
    And User on Activity information page adds comment "Activity comment text N20"
    Then Activity information page comment section button "Comment" is not displayed
    And Activity information page comment section button "Comment" is not displayed
    And Activity information page comment section text area is not displayed
#    TODO uncomment when RMS-20683 will be fixed
#    When User clicks Edit button for Activity
#    And User selects activity status "Done"
#    And User selects activity assessment
#    And User clicks 'Save' activity button
#    And User clicks "New Component" component tab
#    And User clicks on "Assign Questionnaire1" activity
#    And User clicks Edit button for Activity
#    And User selects activity status "In Progress"
#    And User clicks 'Save' activity button
#    And User clicks "Proceed" Alert dialog button
#    And User refreshes page
#    Then User should see System Notice comment "toBeReplaced made changes:" on Activity Information page
#      | FIELD ORIGINAL VALUE NEW VALUE   |
#      | Status Completed In Progress |
