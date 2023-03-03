@e2esmokeci
Feature: Create delete tax related entities

  Scenario: Create Product Tax Code, Customer Tax Code, Create Tax, Create Tax Jurisdiction, Create Tax Rule
    Given I login as administrator
    And go to Taxes/ Product Tax Codes
    When click "Create Product Tax Code"
    And fill form with:
      | Code        | Phone_Tax_Code_e2e                 |
      | Description | Description of Phone Tax Code code |
    And save and close form
    Then should see "Product Tax Code has been saved" flash message

    And go to Taxes/ Customer Tax Codes
    When click "Create Customer Tax Code"
    And fill form with:
      | Code        | New_Customer_Tax_Code_e2e                 |
      | Description | Description of New_Customer_Tax_Code code |
    And save and close form
    Then should see "Customer Tax Code has been saved" flash message

    And go to Taxes/ Taxes
    When click "Create Tax"
    And fill form with:
      | Code        | CA_e2e |
      | Description | CA     |
      | Rate (%)    | 9.5    |
    And save and close form
    Then should see "Tax has been saved" flash message

    And go to Taxes/ Tax Jurisdictions
    When click "Create Tax Jurisdiction"
    And fill form with:
      | Code        | CA_Jurisdiction_e2e |
      | Description | CA_Jurisdiction     |
      | Country     | United States       |
      | State       | California          |
    And save and close form
    Then should see "Tax Jurisdiction has been saved" flash message

    And go to Taxes/ Tax Rules
    When click "Create Tax Rule"
    And fill "Tax Rule Form" with:
      | Customer Tax Code | New_Customer_Tax_Code_e2e |
      | Product Tax Code  | Phone_Tax_Code_e2e        |
      | Tax Jurisdiction  | CA_Jurisdiction_e2e       |
      | Tax               | CA_e2e                    |
      | Description       | New Tax Rule              |
    And save and close form
    Then should see "Tax Rule has been saved" flash message

  Scenario: Delete Product Tax Code, Customer Tax Code, Delete Tax, Tax Jurisdiction, Tax Rule
    Given go to Taxes/ Tax Rules
    And click delete 'Phone_Tax_Code_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Tax Rule deleted"

    When go to Taxes/ Tax Jurisdictions
    And click delete 'CA_Jurisdiction_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Tax Jurisdiction deleted"

    When go to Taxes/ Taxes
    And click delete 'CA_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Tax deleted"

    When go to Taxes/ Customer Tax Codes
    And click delete 'New_Customer_Tax_Code_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Customer Tax Code deleted"

    When go to Taxes/ Product Tax Codes
    And click delete 'Phone_Tax_Code_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product Tax Code deleted"
