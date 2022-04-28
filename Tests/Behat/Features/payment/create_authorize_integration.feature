@e2e

Feature: Create Authorize integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                      | Authorize.Net                              |
      | Name                      | AuthorizeNet                               |
      | CreditCard Label          | Authorize                                  |
      | CreditCard Short Label    | Au                                         |
      | Allowed Credit Card Types | [Visa, Mastercard]                         |
      | API Login ID              | <Secret:payment.authorize.api_login_id>    |
      | Transaction Key           | <Secret:payment.authorize.transaction_key> |
      | Client Key                | <Secret:payment.authorize.client_key>      |
      | Test Mode                 | true                                       |
      | Payment Action            | Authorize and Charge                       |
      | Status                    | Active                                     |
    When I click "Check credentials"
    Then I should see "Credentials are valid"
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Payment Rule
    When I go to System/ Payment Rules
    And I click "Create Payment Rule"
    And I fill "E2E Payment Rule Form" with:
      | Enabled    | true         |
      | Name       | Authorize    |
      | Sort Order | 1            |
      | Currency   | $            |
      | Expression |              |
      | Method     | AuthorizeNet |
    And I click "Add Payment Rule Method"
    And I save and close form
    Then I should see "Payment rule has been saved" flash message
