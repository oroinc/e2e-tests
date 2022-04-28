@e2e

Feature: Create UPS integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                    | UPS                                           |
      | Name                    | UPS                                           |
      | NoCard Label            | UPS                                           |
      | Test Mode               | true                                          |
      | API User                | <Secret:shipping.ups.api_user>                |
      | API Password            | <Secret:shipping.ups.api_password>            |
      | API Key                 | <Secret:shipping.ups.api_key>                 |
      | Shipping Account Name   | <Secret:shipping.ups.shipping_account_name>   |
      | Shipping Account Number | <Secret:shipping.ups.shipping_account_number> |
      | Pickup Type             | Regular Daily Pickup                          |
      | Unit Of Weight          | Pound                                         |
      | Country                 | United States                                 |
      | Shipping Services       | UPS Ground                                    |
      | Default owner           | John Doe                                      |
    When I click "Check UPS Connection"
    Then I should see "UPS Connection is valid" flash message
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Shipping Rule
    When I go to System/ Shipping Rules
    And I click "Create Shipping Rule"
    And I fill "E2E Shipping Rule Form" with:
      | Enabled    | true    |
      | Name       | UPS     |
      | Sort Order | 1       |
      | Currency   | $       |
      | Method     | UPS     |
      | Websites   | Default |
    And I click "Add Shipping Rule Method"
    And I should see "UPS Ground"
    And I fill in "Shipping Rule Method First Enabled" with "true"
    And I save and close form
    Then I should see "Shipping rule has been saved" flash message
