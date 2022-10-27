@e2esmokeci
Feature: Create delete price list

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create 2 price lists (1 create through the rules and 2 create through the import)
    Given I proceed as the Admin
    And I login as administrator
    When go to Sales/ Price Lists
    And click "Create Price List"
    And I fill form with:
      | Name       | FirstPriceList |
      | Currencies | US Dollar ($)  |
      | Active     | true           |
    And save and close form
    And I click "Import file"
    And I upload "prod_prices.csv" file to "ShoppingListImportFileField"
    And I click "Import file"
    And I should see "Import started successfully. You will receive an email notification upon completion." flash message
    And I wait for 3 seconds
    And reload the page
    And sort grid by "Value"
    Then should see following grid:
      | Product SKU | Product name                                      | Quantity | Unit  | Value  | Currency |
      | 3YB32       | Women’s Teal Scrub Cap                            | 10       | piece | 10.00  | USD      |
      | 3LV37       | Women’s 5-Pocket V-neck Fashion Scrub Top         | 1        | piece | 12.00  | USD      |
      | 8BC37       | Colorful Floral Women’s Scrub Top                 | 10       | piece | 24.00  | USD      |
      | 8BC37       | Colorful Floral Women’s Scrub Top                 | 1        | piece | 26.00  | USD      |
      | 5TJ23       | 17-inch POS Touch Screen Monitor with Card Reader | 10       | set   | 255.00 | USD      |
      | 5BM69       | Conference Table, 47 in. x 10 ft.                 | 1        | item  | 300.00 | USD      |

    When go to Sales/ Price Lists
    And click "Create Price List"
    And I fill form with:
      | Name       | SecondPriceList |
      | Currencies | US Dollar ($)   |
      | Active     | true            |
      | Rule       | product.id > 0  |
    And click "Add Price Calculation Rules"
    And click "Enter expression unit"
    And fill "Price Calculation Rules Form" with:
      | Price Unit | pricelist[1].prices.unit |
    And click "Enter expression currency"
    And fill "Price Calculation Rules Form" with:
      | Price Currency     | pricelist[1].prices.currency    |
      | Price for quantity | 1                               |
      | Calculate As       | pricelist[1].prices.value * 0.8 |
      | Condition          | pricelist[1].prices.value > 1   |
      | Priority           | 1                               |
    And save and close form
    Then should see "Price List has been saved" flash message

  Scenario: Check availability of front store
    Given I proceed as the Admin
    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name       | Smoke Customer  |
      | Price List | SecondPriceList |
    And save and close form
    Then should see "Customer has been saved" flash message
    When go to Customers/ Customer Users
    And click "Create Customer User"
    And fill form with:
      | First Name    | Branda                      |
      | Last Name     | Sanborn                     |
      | Email Address | BrandaJSanborn1@example.org |
    And I focus on "Birthday" field
    And click "Today"
    And fill form with:
      | Password         | BrandaJSanborn1@example.org |
      | Confirm Password | BrandaJSanborn1@example.org |
      | Customer         | Smoke Customer              |
    And fill "Customer User Addresses Form" with:
      | Primary                    | true          |
      | First Name Add             | Branda        |
      | Last Name Add              | Sanborn       |
      | Organization               | Smoke Org     |
      | Country                    | United States |
      | Street                     | Market St. 12 |
      | City                       | San Francisco |
      | State                      | California    |
      | Zip/Postal Code            | 90001         |
      | Billing                    | true          |
      | Shipping                   | true          |
      | Default Billing            | true          |
      | Default Shipping           | true          |
      | Administrator (Predefined) | true          |
    And save and close form
    Then should see "Customer User has been saved" flash message
    When go to Customers/ Customer Groups
    And click "Create Customer Group"
    And fill "Customer Group Form" with:
      | Name       | Smoke Group                 |
      | Fallback   | Current customer group only |
      | Price List | FirstPriceList              |
    And click on Smoke Customer in grid
    And save and close form
    Then should see "Customer group has been saved" flash message

    Given I proceed as the User
    And I am on the homepage
    And I signed in as BrandaJSanborn1@example.org on the store frontend in old session
    And I click "Accept Cookie Banner" if present
    And I am on "/product"
    When filter SKU as is equal to "3LV37"
    And should see "Your Price: $12.00 / piece" for "3LV37" product
    And should see "Listed Price: $12.00 / piece" for "3LV37" product
    When fill line item with "3LV37" in frontend product grid:
      | Quantity | 10    |
      | Unit     | piece |
    Then should see "Your Price: $12.00 / piece" for "3LV37" product
    And should see "Listed Price: $12.00 / piece" for "3LV37" product
    And click "Reset SKU filter"
    When filter SKU as is equal to "3YB32"
    And should see "Your Price: $8.792 / piece" for "3YB32" product
    And should see "Listed Price: $8.792 / piece" for "3YB32" product
    When fill line item with "3YB32" in frontend product grid:
      | Quantity | 10    |
      | Unit     | piece |
    Then should see "Your Price: $10.00 / piece" for "3YB32" product
    And should see "Listed Price: $8.792 / piece" for "3YB32" product
    And click "Reset SKU filter"
    When filter SKU as is equal to "8BC37"
    And should see "Your Price: $19.96 / piece" for "8BC37" product
    And should see "Listed Price: $19.96 / piece" for "8BC37" product
    When fill line item with "8BC37" in frontend product grid:
      | Quantity | 10    |
      | Unit     | piece |
    Then should see "Your Price: $24.00 / piece" for "8BC37" product
    And should see "Listed Price: $19.96 / piece" for "8BC37" product
    And click "Reset SKU filter"

  Scenario: Clear all data
    Given I proceed as the Admin
    When go to Sales/ Price Lists
    And I click delete 'FirstPriceList' in grid
    And click "Yes, Delete"
    Then should see "Price List deleted" flash message
    And I click delete 'SecondPriceList' in grid
    And click "Yes, Delete"
    Then should see "Price List deleted" flash message
    When go to Customers/ Customer Users
    And I click delete 'BrandaJSanborn1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message
    When go to Customers/ Customers
    And I click delete 'Smoke Customer' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message
    When go to Customers/ Customer Groups
    And I click delete 'Smoke Group' in grid
    And click "Yes, Delete"
    Then should see "Customer Group deleted" flash message
