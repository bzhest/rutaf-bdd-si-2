@ui @full_regression @adhoc_activity
Feature: View Ad Hoc Activity

  As a RDDC User
  I want the adhoc activities to be reviewed by designated reviewers after they are accomplished
  So that I can make sure that the activities are correct before they are finalized

  @C38949247
  Scenario: C38949247: Third-party - Ad Hoc Activity - Delete Reviewer with Activity Status that is Not Draft
    Given User logs into RDDC as "Admin"
    When User creates third-party "with random ID name" via API and open it
    And User clicks on Risk Management tab
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "Not Started Activity"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN"
    And User clicks Done button in Activity Reviewers section
    Then Ad-Hoc Activity Information is saved
    When User opens previously created Ad-Hoc Acvtivity
    Then 'Delete' button is grayed out for the reviewer "Assignee_AT_FN Assignee_AT_LN"
    When User clicks Back button to return from Activity modal
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "In Progress Activity"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN"
    And User clicks Done button in Activity Reviewers section
    Then Ad-Hoc Activity Information is saved
    When User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "In Progress"
    And User clicks 'Save' activity button
    And User opens previously created Ad-Hoc Acvtivity
    Then 'Delete' button is grayed out for the reviewer "Assignee_AT_FN Assignee_AT_LN"
    When User clicks Back button to return from Activity modal
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "Deferral Activity"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN"
    And User clicks Done button in Activity Reviewers section
    Then Ad-Hoc Activity Information is saved
    When User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Deferral"
    And User clicks 'Save' activity button
    And User opens previously created Ad-Hoc Acvtivity
    Then 'Delete' button is grayed out for the reviewer "Assignee_AT_FN Assignee_AT_LN"
    When User clicks Back button to return from Activity modal
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "Waiting Activity"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN"
    And User clicks Done button in Activity Reviewers section
    Then Ad-Hoc Activity Information is saved
    When User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Waiting"
    And User clicks 'Save' activity button
    And User opens previously created Ad-Hoc Acvtivity
    Then 'Delete' button is grayed out for the reviewer "Assignee_AT_FN Assignee_AT_LN"
    When User clicks Back button to return from Activity modal
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "Done Activity"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN"
    And User clicks Done button in Activity Reviewers section
    Then Ad-Hoc Activity Information is saved
    When User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Done"
    And User clicks 'Save' activity button
    And User opens previously created Ad-Hoc Acvtivity
    Then 'Delete' button is grayed out for the reviewer "Assignee_AT_FN Assignee_AT_LN"
    When User clicks Back button to return from Activity modal
    And User clicks Third-Party Risk Management "ADD ACTIVITY" button
    And User fills in "Status" drop-down with "Not Started"
    And User fills in "Activity Type" drop-down with "Assessment"
    And User fills in "Activity Name" field with "Completed Activity"
    And User fills in "Description" field with "Auto test Description"
    And User selects "TODAY+0" date for Due Date field
    And User fills in Assignee drop-down with "Admin_double_AT_FN Admin_double_AT_LN"
    And User clicks Third-Party Risk Management "Save" button
    And User fills in "Reviewer" drop-down with "Assignee_AT_FN"
    And User clicks Done button in Activity Reviewers section
    Then Ad-Hoc Activity Information is saved
    When User opens previously created Ad-Hoc Acvtivity
    And User clicks Edit button for Activity
    And User fills in "Status" drop-down with "Done"
    And User clicks 'Save' activity button
    And User opens previously created Ad-Hoc Acvtivity
    And User clicks "Review" review action button for "Assignee_AT_FN Assignee_AT_LN" user
    Then Review icon Delete icon for "Assignee_AT_FN Assignee_AT_LN" user should not be displayed