@e2e

Feature: Create Apruve integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type               | Apruve                              |
      | Name               | Apruve                              |
      | NoCard Label       | Apruve                              |
      | NoCard Short Label | Apruve Short Label                  |
      | Test Mode          | true                                |
      | API Key            | <Secret:payment.apruve.api_key>     |
      | Merchant ID        | <Secret:payment.apruve.merchant_id> |
      | Status             | Active                              |
      | Default owner      | John Doe                            |
    When I click "Check Apruve connection"
    Then I should see "Apruve Connection is valid" flash message
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Payment Rule
    When I go to System/ Payment Rules
    And I click "Create Payment Rule"
    And I fill "E2E Payment Rule Form" with:
      | Enable     | true   |
      | Name       | Apruve |
      | Sort Order | 1      |
      | Currency   | $      |
      | Method     | Apruve |
    And I click "Add Payment Rule Method"
    And I save and close form
    Then I should see "Payment rule has been saved" flash message
