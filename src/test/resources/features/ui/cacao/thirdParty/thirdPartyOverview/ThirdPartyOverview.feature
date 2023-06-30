@ui @cacao @functional @suppliers @third_party_overview
Feature: Third-party - Third-party Overview

  As an RDDC User
  I want to have a page where I can see all the Third-parties that I have access to
  So that  I can start managing the Third-parties

  @C37578445
  @thirdPartySearch
  Scenario: C37578445: Third Party Overview - Verify Third Party search
    Given User logs into RDDC as "user without onboarding and renewal accesses"
    When User creates third-parties with name and data "with random ID name" via API if it is absent
      | red flag qwerty_DO_NOT_USER |
    And User logs into RDDC as "Assignee"
    And User creates third-parties with name and data "with random ID name" via API if it is absent
      | THE RED FLAG GROUP (UK) LIMITED |
      | Rẻd                             |
      | Red Rock Musikproduktion GmbH   |
      | Inter Flag, s.r.o.              |
      | Red Mul Unlimited B.V.          |
      | RED FOX,s.r.o.                  |
      | Bella Vista                     |
      | Bella Vista Inc                 |
      | Bella Vista Limited             |
      | Isabella Inc                    |
      | Novista                         |
    And User navigates to Third-party page
    Then Show Drop-Down current option should be "All"
    And Search text field is displayed
    When User searches item by "Red Flag" keyword
    And User selects "Max" items per page
    Then Third-party overview table contains records with Name in relevancy order sorted by creation time
      | Name                            | Score |
      | THE RED FLAG GROUP (UK) LIMITED | 1.2   |
      | Rẻd                             | 1     |
      | Red Rock Musikproduktion GmbH   | 0.625 |
      | Inter Flag, s.r.o.              | 0.6   |
      | Red Mul Unlimited B.V.          | 0.6   |
      | RED FOX,s.r.o.                  | 0.6   |
    And Third-party overview table does not contains records with Name in relevancy order sorted by creation time
      | Name                        | Score |
      | red flag qwerty_DO_NOT_USER | 0     |
    When User searches item by "bella vista" keyword
    And User selects "Max" items per page
    Then Third-party overview table contains records with Name in relevancy order sorted by creation time
      | Name                | Score |
      | Bella Vista         | 1.5   |
      | Bella Vista Inc     | 1.33  |
      | Bella Vista Limited | 1.33  |
      | Isabella Inc        | 0     |
      | Novista             | 0     |
    When User searches item by "BELLA VISTA LIMITED" keyword
    And User selects "Max" items per page
    Then Third-party overview table contains records with Name in relevancy order sorted by creation time
      | Name                | Score |
      | Bella Vista Limited | 2     |
      | Bella Vista         | 1.5   |
      | Bella Vista Inc     | 1.33  |
      | Isabella Inc        | 0     |
      | Novista             | 0     |
    When User selects "My Third-party" show option
    Then Third-party overview table is displayed with assigned to the user
    When User clears search input field
    Then Third-party overview table is displayed with assigned to the user
    When User searches item by "qwerty_DO_NOT_USER" keyword
    Then Third-party Overview "NO MATCH FOUND" message is displayed