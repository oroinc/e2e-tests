@e2esmokeci
Feature: Checkout with registered customer

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario:
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as BrandaJSanborn@example.org on the store frontend in old session
    When I hover on "Shopping Cart"
    And click "Create New List"
    Then should see an "Create New Shopping List popup" element
    And type "New Front Shopping List" in "Shopping List Name"
    And click "Create"
    And should see "New Front Shopping List"
    When I hover on "Clearance menu item"
    And click "Lighting Products menu item"
    And filter SKU as is equal to "2TK59"
    When fill line item with "2TK59" in frontend product grid:
      | Quantity | 10   |
      | Unit     | item |
    And I scroll to top
    And click "Add to New Front Shopping List" for "2TK59" product
    When I hover on "Shopping Cart"
    And click "New Front Shopping List" on shopping list widget
    And click "Create Order"
    And I confirm Agreements "Terms and Conditions" at the checkout if they are not confirmed
    And I select "Branda Sanborn, 23400 Caldwell Road, ROCHESTER NY US 14608" on the "Billing Information" checkout step and press Continue
    And I select "Branda Sanborn, 23400 Caldwell Road, ROCHESTER NY US 14608" on the "Shipping Information" checkout step and press Continue
    And I check "Fixed Product Shipping" on the "Shipping Method" checkout step and press Continue
    And I check "Payment Term" on the "Payment" checkout step and press Continue
    And fill form with:
      | PO Number | P777155 |
    When I check "Delete this shopping list after submitting order" on the "Order Review" checkout step and press Submit Order
    Then I see the "Thank You" page with "Thank You For Your Purchase!" title

  Scenario: Clear all data
    Given I proceed as the Admin
    And I login as administrator
    When go to Sales/Orders
    And filter PO Number as is equal to "P777155"
    When I click delete "P777155" in grid
    And I confirm deletion
    Then should see "Order deleted" flash message
