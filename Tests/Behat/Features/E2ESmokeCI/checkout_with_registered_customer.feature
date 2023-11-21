@e2esmokeci
Feature: Checkout with registered customer

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Precondition
    Given I proceed as the Admin
    And I login as administrator
    And go to System/ Configuration
    And follow "Commerce/Inventory/Product Options" on configuration sidebar
    And fill "Product Option Form" with:
      | Backorders Default | false |
      | Backorders         | Yes   |
    And I save setting
    Then I should see "Configuration saved" flash message

  Scenario: Create Payment Term, Customer, Customer User and product
    When go to Sales/ Payment terms
    And click "Create Payment Term"
    And type "net_10_e2e" in "Label"
    And save and close form

    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name         | e2e Customer       |
      | Price List   | Default Price List |
      | Payment Term | net_10_e2e         |
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
      | Password           | BrandaJSanborn1@example.org |
      | Confirm Password   | BrandaJSanborn1@example.org |
      | Customer           | e2e Customer                |
      | Buyer (Predefined) | true                        |
    And fill "Customer User Addresses Form" with:
      | Primary          | true          |
      | First Name Add   | Branda        |
      | Last Name Add    | Sanborn e2e   |
      | Organization     | e2e Org       |
      | Country          | United States |
      | Street           | Market St. 12 |
      | City             | San Francisco |
      | State            | California    |
      | Zip/Postal Code  | 90001         |
      | Billing          | true          |
      | Shipping         | true          |
      | Default Billing  | true          |
      | Default Shipping | true          |
    And save and close form
    Then should see "Customer User has been saved" flash message

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type | Simple |
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU               | 110_lumen_headlamp_e2e              |
      | Name              | 110 Lumen Rechargeable Headlamp e2e |
      | Status            | Enable                              |
      | Unit Of Quantity  | item                                |
      | Description       | Product Description                 |
      | Short Description | Product_Short_Description           |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 10.99              |
      | Currency   | $                  |
    And save and close form
    Then I should see "Product has been saved" flash message

  Scenario: Create payment and shipping integration
    Given I proceed as the Admin
    When go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "Integration Form" with:
      | Type  | Flat Rate Shipping |
      | Name  | Flat Rate e2e      |
      | Label | Flat_Rate_e2e      |
    And save and close form
    Then I should see "Integration saved" flash message
    When go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "Integration Form" with:
      | Type        | Payment Terms     |
      | Name        | Payment Terms e2e |
      | Label       | Payment_Terms_e2e |
      | Short Label | Payment Terms e2e |
    And save and close form
    Then I should see "Integration saved" flash message

  Scenario: Create payment and shipping integration
    Given I proceed as the Admin
    When I go to System/ Shipping Rules
    And click "Create Shipping Rule"
    And fill "Shipping Rule" with:
      | Enable     | true          |
      | Name       | Flat Rate e2e |
      | Sort Order | 10            |
      | Currency   | $             |
      | Method     | Flat Rate e2e |
    And fill form with:
      | Price | 10 |
    And save and close form
    Then should see "Shipping rule has been saved" flash message
    When I go to System/ Payment Rules
    And click "Create Payment Rule"
    And fill "Payment Rule Form" with:
      | Enable     | true                |
      | Name       | Payment Terms e2e   |
      | Sort Order | 1                   |
      | Currency   | $                   |
      | Method     | [Payment Terms e2e] |
    When save and close form
    Then should see "Payment rule has been saved" flash message

  Scenario:
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as BrandaJSanborn1@example.org on the store frontend in old session
    When I hover on "Shopping Cart"
    And click "Create New List"
    Then should see an "Create New Shopping List popup" element
    And type "e2e SL" in "Shopping List Name"
    And click "Create"
    And should see "e2e SL"

    And I am on homepage
    And I type "110_lumen_headlamp_e2e" in "search"
    And I click "Search Button"
    And I click "110 Lumen Rechargeable Headlamp e2e"
    When I click "Add to e2e SL"
    Then I should see "Product has been added to" flash message and I close it
    When I hover on "Shopping Cart"
    And click "e2e SL" on shopping list widget
    And click "Create Order"
    And I confirm Agreements "Terms and Conditions" at the checkout if they are not confirmed
    And I select "Branda Sanborn e2e, e2e Org, Market St. 12, SAN FRANCISCO CA US 90001" on the "Billing Information" checkout step and press Continue
    And I select "Branda Sanborn e2e, e2e Org, Market St. 12, SAN FRANCISCO CA US 90001" on the "Shipping Information" checkout step and press Continue
    And I check "Flat_Rate_e2e" on the "Shipping Method" checkout step and press Continue
    And I check "Payment_Terms_e2e" on the "Payment" checkout step and press Continue
    And fill form with:
      | PO Number | P777155 |
    When I check "Delete this shopping list after submitting order" on the "Order Review" checkout step and press Submit Order
    Then I see the "Thank You" page with "Thank You For Your Purchase!" title

  Scenario: Clear all data
    Given I proceed as the Admin
    When go to Sales/Orders
    And filter PO Number as is equal to "P777155"
    When I click delete "P777155" in grid
    And I confirm deletion
    Then should see "Order deleted" flash message

    And go to System/ Configuration
    And follow "Commerce/Inventory/Product Options" on configuration sidebar
    And fill "Product Option Form" with:
      | Backorders Default | true |
    And I save setting
    Then I should see "Configuration saved" flash message

    When go to Customers/ Customer Users
    And I click delete 'BrandaJSanborn1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message

    When go to Customers/ Accounts
    And I filter "Account name" as Contains "e2e Customer"
    And I click delete 'e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Item deleted" flash message

    When go to Products/ Products
    And I filter "SKU" as Contains "110_lumen_headlamp_e2e"
    And click delete '110_lumen_headlamp_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted"

    When go to System/ Shipping Rules
    And I filter "Name" as Contains "Flat Rate e2e"
    And click delete 'Flat Rate e2e' in grid
    And click "Yes, Delete"
    Then I should see "Shipping Rule deleted"

    When go to System/ Payment Rules
    And I filter "Name" as Contains "Payment Terms e2e"
    And click delete 'Payment Terms e2e' in grid
    And click "Yes, Delete"
    Then I should see "Payment Rule deleted"

    When go to System/ Integrations/ Manage Integrations
    And I filter "Name" as Contains "Flat Rate e2e"
    And click delete 'Flat Rate e2e' in grid
    And click "Yes"
    Then I should see "Integration has been deleted successfully"

    When go to System/ Integrations/ Manage Integrations
    And I filter "Name" as Contains "Payment Terms e2e"
    And click delete 'Payment Terms e2e' in grid
    And click "Yes"
    Then I should see "Integration has been deleted successfully"

    When go to Sales/ Payment terms
    And I click delete 'net_10_e2e' in grid
    And click "Yes"
    Then should see "Payment Term deleted" flash message

    # should be fixed in BB-15705
    When go to Customers/ Customers
    And I click edit 'e2e Customer' in grid
    And I fill form with:
      | Name | deleted |
    And I save and close form
    Then should see "Customer has been saved" flash message

#    When go to Customers/ Customers
#    And I click delete 'e2e Customer' in grid
#    And click "Yes, Delete"
#    Then should see "Customer deleted" flash message
