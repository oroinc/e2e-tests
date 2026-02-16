@e2esmokeci
Feature: Check storefront pages authenticated customer user

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create customer, customer user and product
    Given I proceed as the Admin
    And I login as administrator
    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name       | Second e2e Customer |
      | Price List | Default Price List  |
    And save and close form
    Then should see "Customer has been saved" flash message

    When go to Customers/ Customer Users
    And click "Create Customer User"
    And fill form with:
      | First Name    | James                      |
      | Last Name     | Maxwell e2e                |
      | Email Address | JamesJMaxwell1@example.org |
    And I focus on "Birthday" field
    And click "Today"
    And fill form with:
      | Password           | JamesJMaxwell1@example.org |
      | Confirm Password   | JamesJMaxwell1@example.org |
      | Customer           | Second e2e Customer        |
      | Buyer (Predefined) | true                       |
    And fill "Customer User Addresses Form" with:
      | Primary            | true          |
      | First Name Add     | James         |
      | Last Name Add      | Maxwell e2e   |
      | Organization       | e2e Org       |
      | Country            | United States |
      | Street             | Market St. 12 |
      | City               | San Francisco |
      | State              | California    |
      | Zip/Postal Code    | 90001         |
      | Billing            | true          |
      | Shipping           | true          |
      | Default Billing    | true          |
      | Default Shipping   | true          |
    And save and close form
    Then should see "Customer User has been saved" flash message

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type | Simple |
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU               | 24_lumen_headlamp_e2e              |
      | Name              | 24 Lumen Rechargeable Headlamp e2e |
      | Status            | Enable                             |
      | Unit Of Quantity  | item                               |
      | Description       | Product Description                |
      | Short Description | Product_Short_Description          |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 15.99              |
      | Currency   | $                  |
    And save and close form
    Then I should see "Product has been saved" flash message

  Scenario: Check Contact Us and About us pages, Products views, front filters, prices by not registered user
    Given I proceed as the User
    And I am on the homepage
    And I login as JamesJMaxwell1@example.org buyer
    And I click "Accept Cookie Banner" if present
    When click "About" in hamburger menu
    Then Page title equals to "About"
    When I type "24_lumen_headlamp_e2e" in "search"
    And I click "Search Button"
    And should see "View Details" for "24_lumen_headlamp_e2e" product
    And should see "Product Image" for "24_lumen_headlamp_e2e" product
    And should see "Product Name" for "24_lumen_headlamp_e2e" product
    And should not see "Product Information & Features:" for "24_lumen_headlamp_e2e" product
    And should see "Product_Short_Description" for "24_lumen_headlamp_e2e" product
    And should see "24 Lumen Rechargeable Headlamp e2e" for "24_lumen_headlamp_e2e" product
    And should see "$15.99" for "24_lumen_headlamp_e2e" product
    And filter SKU as is equal to "24_lumen_headlamp_e2e"
    And click "Add to Shopping List" for "24_lumen_headlamp_e2e" product
    And should see "Product has been added to "
    And should see "Green Box" for "24_lumen_headlamp_e2e" product
    And should see "Update Shopping List" for "24_lumen_headlamp_e2e" product
    And I scroll to top
    
    And click "Gallery View"
    Then should not see "View Details" for "24_lumen_headlamp_e2e" product
    And should see "Product Image" for "24_lumen_headlamp_e2e" product
    And should see "Product Name" for "24_lumen_headlamp_e2e" product
    And should see "$15.99" for "24_lumen_headlamp_e2e" product
    And should see "Green Box" for "24_lumen_headlamp_e2e" product
    And should see "Update Shopping List" for "24_lumen_headlamp_e2e" product

    And click "Compact View"
    And should see "Product Image" for "24_lumen_headlamp_e2e" product
    And should see "Product Name" for "24_lumen_headlamp_e2e" product
    And should see "$15.99" for "24_lumen_headlamp_e2e" product
    And should see "Green Box" for "24_lumen_headlamp_e2e" product
    And should see "Update Shopping List" for "24_lumen_headlamp_e2e" product

    Then click "List View"
    When I hover on "Shopping Cart"
    And I click "Shopping List" on shopping list widget
    And I click "Shopping List Actions"
    When I click "Delete"
    And I click "Yes, delete"
    Then should see "Shopping List deleted" flash message

  Scenario: Clear all data
    Given I proceed as the Admin

    When go to Customers/ Accounts
    And I filter "Account name" as Contains "Second e2e Customer"
    And I click delete 'Second e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Item deleted" flash message

    When go to Customers/ Customer Users
    And I filter "Email Address" as Contains "JamesJMaxwell1@example.org"
    And I click delete 'JamesJMaxwell1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message

    When go to Products/ Products
    And I filter "SKU" as Contains "24_lumen_headlamp_e2e"
    And click delete '24_lumen_headlamp_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted" flash message

    When go to Customers/ Customers
    And I filter "Name" as Contains "Second e2e Customer"
    And I click delete 'Second e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message
