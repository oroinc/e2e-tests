@e2e

Feature: Create Zendesk integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                       | Zendesk                     |
      | Name                       | Zendesk                     |
      | URL                        | <Secret:zendesk.url>        |
      | API Email                  | <Secret:zendesk.email>      |
      | API Token                  | <Secret:zendesk.token>      |
      | Default Zendesk user email | <Secret:zendesk.user_email> |
      | Status                     | Active                      |
      | Enable two way sync        | true                        |
    When I save and close form
    Then I should see "Integration saved" flash message
