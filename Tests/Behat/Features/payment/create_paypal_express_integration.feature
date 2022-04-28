@e2e

Feature: Create PayPal Express integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type               | PayPal Express                                |
      | Name               | PayPal Express                                |
      | Payment Action     | Authorize                                     |
      | NoCard Label       | PayPal Express                                |
      | NoCard Short Label | PayPal Express                                |
      | Client ID          | <Secret:payment.paypal_express.client_id>     |
      | Client Secret      | <Secret:payment.paypal_express.client_secret> |
      | Sandbox Mode       | true                                          |
      | Status             | Active                                        |
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Payment Rule
    When I go to System/ Payment Rules
    And I click "Create Payment Rule"
    And I fill "E2E Payment Rule Form" with:
      | Enabled    | true           |
      | Name       | PayPal Express |
      | Sort Order | 1              |
      | Currency   | $              |
      | Expression |                |
      | Method     | PayPal Express |
    And I click "Add Payment Rule Method"
    And I save and close form
    Then I should see "Payment rule has been saved" flash message
