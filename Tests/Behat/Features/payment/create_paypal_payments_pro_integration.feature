@e2e

Feature: Create PayPal Payments Pro integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                      | PayPal Payments Pro                  |
      | Name                      | PayPal Payments Pro                  |
      | CreditCard Label          | PayPal Payments Pro                  |
      | CreditCard Short Label    | PayPal Payments Pro                  |
      | Allowed Credit Card Types | [Visa, Mastercard]                   |
      | Partner                   | <Secret:payment.paypal_pro.partner>  |
      | Vendor                    | <Secret:payment.paypal_pro.vendor>   |
      | User                      | <Secret:payment.paypal_pro.user>     |
      | Password                  | <Secret:payment.paypal_pro.password> |
      | Test Mode                 | true                                 |
      | Payment Action            | Authorize                            |
      | Require CVV Entry         | true                                 |
      | Express Name              | PayPal Payments Pro Express          |
      | Express Label             | PayPal Payments Pro Express          |
      | Express Short Label       | PayPal Payments Pro Express          |
      | Express Payment Action    | Authorize                            |
      | Status                    | Active                               |
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Payment Rule
    When I go to System/ Payment Rules
    And I click "Create Payment Rule"
    And I fill "E2E Payment Rule Form" with:
      | Enabled    | true                   |
      | Name       | PayPal Payments Pro    |
      | Sort Order | 1                      |
      | Currency   | $                      |
      | Expression |                        |
      | Method     | PayPal Payments Pro |
    And I click "Add Payment Rule Method"
    And I select "PayPal Payments Pro Express" from "Method"
    And I click "Add Payment Rule Method"
    And I save and close form
    Then I should see "Payment rule has been saved" flash message
