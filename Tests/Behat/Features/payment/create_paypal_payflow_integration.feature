@e2e

Feature: Create PayPal PayFlow integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                      | PayPal Payflow Gateway                   |
      | Name                      | PayPal Payflow Gateway                   |
      | CreditCard Label          | PayPal Payflow Gateway                   |
      | CreditCard Short Label    | PayPal Payflow Gateway                   |
      | Allowed Credit Card Types | [Discover, American Express]             |
      | Partner                   | <Secret:payment.paypal_payflow.partner>  |
      | Vendor                    | <Secret:payment.paypal_payflow.vendor>   |
      | User                      | <Secret:payment.paypal_payflow.user>     |
      | Password                  | <Secret:payment.paypal_payflow.password> |
      | Test Mode                 | true                                     |
      | Payment Action            | Authorize                                |
      | Require CVV Entry         | true                                     |
      | Express Name              | PayPal Gateway Express                   |
      | Express Label             | PayPal Gateway Express                   |
      | Express Short Label       | PayPal Gateway Express                   |
      | Express Payment Action    | Authorize                                |
      | Status                    | Active                                   |
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Payment Rule
    When I go to System/ Payment Rules
    And I click "Create Payment Rule"
    And I fill "E2E Payment Rule Form" with:
      | Enabled    | true                   |
      | Name       | PayPal Payflow Gateway |
      | Sort Order | 1                      |
      | Currency   | $                      |
      | Expression |                        |
      | Method     | PayPal Payflow Gateway |
    And I click "Add Payment Rule Method"
    And I select "PayPal Gateway Express" from "Method"
    And I click "Add Payment Rule Method"
    And I save and close form
    Then I should see "Payment rule has been saved" flash message
