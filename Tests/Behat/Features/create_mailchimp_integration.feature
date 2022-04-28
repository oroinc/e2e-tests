@e2e

Feature: Create MailChimp integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                     | MailChimp                    |
      | Name                     | MailChimp                    |
      | API Key                  | <Secret:mailchimp.api_token> |
      | Activity Update Interval | 3 months                     |
      | Status                   | Active                       |
      | Enable two way sync      | true                         |
    When I click "Check Connection"
    Then I should see "Everything's Chimpy!"
    When I save and close form
    Then I should see "Integration saved" flash message
