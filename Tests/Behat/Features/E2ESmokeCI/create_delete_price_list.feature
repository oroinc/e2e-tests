@e2esmokeci
Feature: Create delete price list

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create 2 price lists (1 create through the rules and 2 create through the import)
    Given I proceed as the Admin
    And I login as administrator

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type | Simple |
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU               | 500_lumen_headlamp_e2e              |
      | Name              | 500 Lumen Rechargeable Headlamp e2e |
      | Status            | Enable                              |
      | Unit Of Quantity  | item                                |
      | Description       | Product Description                 |
      | Short Description | Product_Short_Description           |
    Then I should see "Add More Rows" element inside "Additional Units Form Section" element
    When set Additional Unit with:
      | Unit | Precision | Rate |
      | each | 2         | 5    |
    And I check "oro_product[additionalUnitPrecisions][0][sell]"
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 10.99              |
      | Currency   | $                  |
    And save and close form
    Then I should see "Product has been saved" flash message

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type | Simple |
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU               | led_blood_pressure_monitors_e2e |
      | Name              | Blood Pressure Monitors e2e     |
      | Status            | Enable                          |
      | Unit Of Quantity  | item                            |
      | Description       | Product Description             |
      | Short Description | Product_Short_Description       |
    Then I should see "Add More Rows" element inside "Additional Units Form Section" element
    When set Additional Unit with:
      | Unit | Precision | Rate |
      | each | 2         | 5    |
    And I check "oro_product[additionalUnitPrecisions][0][sell]"
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 24.99              |
      | Currency   | $                  |
    And save and close form
    Then I should see "Product has been saved" flash message

    When go to Sales/ Price Lists
    And click "Create Price List"
    And I fill form with:
      | Name       | FirstPriceList_e2e |
      | Currencies | US Dollar ($)      |
      | Active     | true               |
    And save and close form
    And I click "Import file"
    And I upload "product_prices.csv" file to "ShoppingListImportFileField"
    And I click "Import file"
    And I should see "Import started successfully. You will receive an email notification upon completion." flash message
    And I wait for 3 seconds
    And reload the page
    And sort grid by "Value"
    Then should see following grid:
      | Product SKU                     | Product name                        | Quantity | Unit | Value | Currency |
      | 500_lumen_headlamp_e2e          | 500 Lumen Rechargeable Headlamp e2e | 10       | item | 10.00 | USD      |
      | led_blood_pressure_monitors_e2e | Blood Pressure Monitors e2e         | 1        | item | 12.00 | USD      |

    When go to Sales/ Price Lists
    And click "Create Price List"
    And I fill form with:
      | Name       | SecondPriceList_e2e |
      | Currencies | US Dollar ($)       |
      | Active     | true                |
      | Rule       | product.id > 0      |
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

  Scenario: Check availability of storefront
    Given I proceed as the Admin
    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name       | e2e Customer        |
      | Price List | SecondPriceList_e2e |
    And save and close form
    Then should see "Customer has been saved" flash message
    When go to Customers/ Customer Users
    And click "Create Customer User"
    And fill form with:
      | First Name    | Branda                      |
      | Last Name     | Sanborn e2e                 |
      | Email Address | BrandaJSanborn1@example.org |
    And I focus on "Birthday" field
    And click "Today"
    And fill form with:
      | Password         | BrandaJSanborn1@example.org |
      | Confirm Password | BrandaJSanborn1@example.org |
      | Customer         | e2e Customer                |
    And fill "Customer User Addresses Form" with:
      | Primary                    | true          |
      | First Name Add             | Branda        |
      | Last Name Add              | Sanborn e2e   |
      | Organization               | e2e Org       |
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
      | Name       | e2e Group                   |
      | Fallback   | Current customer group only |
      | Price List | FirstPriceList_e2e          |
    And I click "Customers" in scrollspy
    And click on e2e Customer in grid
    And save and close form
    Then should see "Customer group has been saved" flash message

    Given I proceed as the User
    And I am on the homepage
    And I signed in as BrandaJSanborn1@example.org on the store frontend in old session
    And I click "Accept Cookie Banner" if present
    And I am on "/product"
    When filter SKU as is equal to "led_blood_pressure_monitors_e2e"
    When fill line item with "led_blood_pressure_monitors_e2e" in frontend product grid:
      | Quantity | 1    |
      | Unit     | item |
    And should see "Your Price: $12.00 / item" for "led_blood_pressure_monitors_e2e" product
    And should see "Listed Price: $12.00 / item" for "led_blood_pressure_monitors_e2e" product
    When fill line item with "led_blood_pressure_monitors_e2e" in frontend product grid:
      | Quantity | 10   |
      | Unit     | item |
    Then should see "Your Price: $12.00 / item" for "led_blood_pressure_monitors_e2e" product
    And should see "Listed Price: $12.00 / item" for "led_blood_pressure_monitors_e2e" product
    And click "Reset SKU filter"
    When filter SKU as is equal to "500_lumen_headlamp_e2e"
    When fill line item with "500_lumen_headlamp_e2e" in frontend product grid:
      | Quantity | 1    |
      | Unit     | item |
    And should see "Your Price: $8.792 / item" for "500_lumen_headlamp_e2e" product
    And should see "Listed Price: $8.792 / item" for "500_lumen_headlamp_e2e" product
    When fill line item with "500_lumen_headlamp_e2e" in frontend product grid:
      | Quantity | 10   |
      | Unit     | item |
    Then should see "Your Price: $10.00 / item" for "500_lumen_headlamp_e2e" product
    And should see "Listed Price: $8.792 / item" for "500_lumen_headlamp_e2e" product
    And click "Reset SKU filter"

  Scenario: Clear all data
    Given I proceed as the Admin
    When go to Sales/ Price Lists
    And I click delete 'FirstPriceList_e2e' in grid
    And click "Yes, Delete"
    Then should see "Price List deleted" flash message
    And I click delete 'SecondPriceList_e2e' in grid
    And click "Yes, Delete"
    Then should see "Price List deleted" flash message

    When go to Customers/ Customer Users
    And I click delete 'BrandaJSanborn1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message

    When go to Customers/ Customers
    And I filter "Name" as Contains "e2e Customer"
    And I click delete 'e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message

    When go to Customers/ Accounts
    And I filter "Account name" as Contains "e2e Customer"
    And I click delete 'e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Item deleted" flash message

    When go to Customers/ Customer Groups
    And I click delete 'e2e Group' in grid
    And click "Yes, Delete"
    Then should see "Customer Group deleted" flash message

    When go to Products/ Products
    And I filter "SKU" as Contains "500_lumen_headlamp_e2e"
    And click delete '500_lumen_headlamp_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted"

    When go to Products/ Products
    And I filter "SKU" as Contains "led_blood_pressure_monitors_e2e"
    And click delete 'led_blood_pressure_monitors_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted"
