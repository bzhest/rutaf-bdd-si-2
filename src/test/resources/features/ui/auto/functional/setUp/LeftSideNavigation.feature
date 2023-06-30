@ui @functional @setUp
Feature: Set Up - Left Side Navigation

  As a user,
  I want to see the Setup Left Side Navigation in React
  So that it will comply with Refinitiv policy

  Background:
    Given User logs into RDDC as "Admin"
    When User clicks Set Up option

  @C43509043
  Scenario: C43509043: Left side navigation is displayed on the "Set Up" pages
    Then Users table is displayed
    And Setup navigation should consist of the following menu
      | User Management                |
      | User                           |
      | Role                           |
      | Groups                         |
      | My Organisation                |
      | Questionnaire Management       |
      | Questionnaires                 |
      | Workflow Management            |
      | Workflow                       |
      | Groups                         |
      | Renewal Settings               |
      | Due Diligence Order Management |
      | Due Diligence Order Approval   |
      | Custom Required Fields         |
      | Screening Management           |
      | Approval Process               |
      | Review Process                 |
      | Fields Management              |
      | Third-party Fields             |
      | Custom Fields                  |
      | Country Checklist              |
      | Value Management               |
      | Email Management               |
    And Setup navigation options should be expanded
      | User Management                |
      | Questionnaire Management       |
      | Workflow Management            |
      | Due Diligence Order Management |

  @C43509049
  Scenario: C43509049: Finger pointer and blue highlight is displayed when hovering over the navigation bar options
    Then Finger pointer and blue highlight is displayed when hovering over the navigation bar options
      | User                         |
      | Role                         |
      | Groups                       |
      | My Organisation              |
      | Questionnaires               |
      | Workflow                     |
      | Groups                       |
      | Renewal Settings             |
      | Due Diligence Order Approval |
      | Custom Required Fields       |
      | Screening Management         |
      | Approval Process             |
      | Review Process               |
      | Third-party Fields           |
      | Custom Fields                |
      | Country Checklist            |
      | Value Management             |
      | Email Management             |

  @C43509131
  Scenario: C43509131: The corresponding page is displayed after clicking the navigation bar option
    When User clicks Questionnaires tab in Questionnaire Management
    Then Questionnaire Overview page is displayed

  @C43509142
  Scenario: C43509142: Options of the navigation menu collapse/expand when clicking on it
    Then Setup navigation options could be collapsed and expanded
      | User Management                |
      | Questionnaire Management       |
      | Workflow Management            |
      | Due Diligence Order Management |
      | Fields Management              |
