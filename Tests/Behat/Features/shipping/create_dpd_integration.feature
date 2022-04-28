@e2e

Feature: Create DPD integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                 | DPD                                    |
      | Name                 | DPD                                    |
      | NoCard Label         | DPD                                    |
      | Test Mode            | true                                   |
      | Cloud User Id        | <Secret:shipping.dpd.cloud_user_id>    |
      | Cloud User Token     | <Secret:shipping.dpd.cloud_user_token> |
      | Shipping Services    | DPD Classic                            |
      | Unit of weight       | kilogram                               |
      | Rate Policy          | Flat Rate                              |
      | Flat Rate Price      | 10                                     |
      | Label Size           | PDF A6                                 |
      | Label Start Position | Upper Right                            |
      | Status               | Active                                 |
      | Default owner        | John Doe                               |
    When I save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create Shipping Rule
    When I go to System/ Shipping Rules
    And I click "Create Shipping Rule"
    And I fill "E2E Shipping Rule Form" with:
      | Enabled    | true    |
      | Name       | DPD     |
      | Sort Order | 1       |
      | Currency   | $       |
      | Method     | DPD     |
      | Websites   | Default |
    And I click "Add Shipping Rule Method"
    And fill "DPD Classic Form" with:
      | Enable       | true |
      | Handling fee | 10   |
    And I save and close form
    Then I should see "Shipping rule has been saved" flash message
