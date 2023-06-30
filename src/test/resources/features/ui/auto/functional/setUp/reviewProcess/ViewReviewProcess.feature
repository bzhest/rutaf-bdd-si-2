@ui @functional @review_process
Feature: Set Up - Review Process - View

  As an Internal User with appropriate access rights
  I want to have the ability to view the review process
  So that I can overview already created review processes

  @C32926331 @C45149812
  Scenario: C32926331, C45149812: Set - Up : Review Process - View - Verify that user should be able to select and view Review Process details and see edit option
  (Set Up/Review Process) - Clicking "Edit" button redirects user to the "Edit Review Process" page
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks "View" for first Review Process
    Then Review Process view page edit button is displayed
    When User hovers Review Process Edit button
    Then Tooltip text is displayed
      | Edit |
    When User clicks Review Process Edit button
    Then Edit Review Process page is displayed

  @C45149809
  Scenario: C45149809: (Set Up/Review Process) - "Review Process/View" page is displayed when clicking any row in the table with existing Review Process setups
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "View" for created Review Process
    Then Review Process view page edit button is displayed
    And Review Process breadcrumb "REVIEW PROCESS/reviewProcessName" is displayed
    When User clicks back browser button
    Then Review Process overview page is displayed
    When User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "View" for created Review Process
    Then Review Process view page edit button is displayed
    And Review Process breadcrumb "REVIEW PROCESS/reviewProcessName" is displayed

  @C45149810
  Scenario: C45149810: (Set Up/Review Process) - "Review Process/View" page divided into 3 sections with uneditable fields
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "View" for created Review Process
    Then Review process modal should have Main block fields
      | Review Process Name | Description | Active |
    And Review process modal should have Default Reviewer block fields
      | Reviewer |
    And Review process modal should have fields for Reviewer block "1"
      | Add Rules For | Activity Owner | Reviewer | Reviewer Method |
    And Review Process fields are disabled
      | Review Process Name |
      | Description         |
      | Active              |
      | Reviewer            |
      | Add Rules For       |
      | Activity Owner      |
      | Reviewer            |
      | Reviewer Method     |
    And Review Process form page is displayed with populated data
    And Review Process Reviewer Method options are displayed
      | Any         |
      | All         |
      | In Sequence |

  @C45149811
  Scenario: C45149811: (Set Up/Review Process) - Clicking "<Review Process" link redirects user to the "Review Process Overview" page (Review Process main page)
    Given User logs into RDDC as "Admin"
    When User navigates to Review Process page
    And User clicks 'Add Review Process' button
    And User fills Add Review Process form with "Review Process with Activity owner" data
    And User fills Add Review Process - Review block form with "Review Process with Activity owner" data
    And User clicks 'Add Review Process' "Save" button
    And User selects "Max" items per page
    And User clicks "View" for created Review Process
    Then Review Process view page edit button is displayed
    And Review Process breadcrumb "REVIEW PROCESS/reviewProcessName" is displayed
    When User clicks Review Process breadcrumb button
    Then Review Process overview page is displayed
