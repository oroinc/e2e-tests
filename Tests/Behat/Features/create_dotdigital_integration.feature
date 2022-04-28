@e2e

Feature: Create dotdigital integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                | dotdigital                   |
      | Name                | dotdigital                   |
      | Username            | <Secret:dotdigital.username> |
      | Password            | <Secret:dotdigital.password> |
      | Status              | Active                       |
    When I click "Check Connection"
    Then I should see "Connection successful!"
    When I save and close form
    Then I should see "Integration saved" flash message
