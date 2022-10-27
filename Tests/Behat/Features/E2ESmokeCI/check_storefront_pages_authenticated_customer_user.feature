@e2esmokeci
Feature: Check storefront pages authenticated customer user

  Scenario: Check Contact Us and About us pages, Products views, front filters, prices by not registered user
    Given I am on the homepage
    And I login as BrandaJSanborn@example.org buyer
    And I click "Accept Cookie Banner" if present
    When click "About"
    Then Page title equals to "About"
    When I hover on "Clearance menu item"
    And click "Lighting Products menu item"
    Then should see "Default Web Catalog / Navigation Root / Clearance / Lighting Products"
    And should see "View Details" for "2TK59" product
    And should see "Product Image" for "2TK59" product
    And should see "Product Name" for "2TK59" product
    And should not see "Product Information & Features:" for "2TK59" product
    And should see "This 500-lumen powered suspended lamp is a powerful and compact LED" for "2TK59" product
    And should see "500-Lumen Portable Suspended Work Lamp" for "2TK59" product
    And should see "Your Price: $15.99 / item" for "2TK59" product
    And should see "Listed Price: $15.99 / item" for "2TK59" product
    And filter SKU as is equal to "2TK59"
    And click "Add to Shopping List" for "2TK59" product
    And should see "Product has been added to "
    And should see "Green Box" for "2TK59" product
    And should see "Update Shopping List" for "2TK59" product

    When I click "Catalog Switcher Toggle"
    And click "Gallery View"
    Then should not see "View Details" for "2TK59" product
    And should see "Product Image" for "2TK59" product
    And should see "Product Name" for "2TK59" product
    And should see "Your Price: $15.99 / item" for "2TK59" product
    And should see "Listed Price: $15.99 / item" for "2TK59" product
    And should see "Green Box" for "2TK59" product
    And should see "Update Shopping List" for "2TK59" product

    When I click "Catalog Switcher Toggle"
    And click "No Image View"
    Then should see "View Details" for "2TK59" product
    And should not see "Product Image" for "2TK59" product
    And should see "Product Name" for "2TK59" product
    And should see "Your Price: $15.99 / item" for "2TK59" product
    And should see "Listed Price: $15.99 / item" for "2TK59" product
    And should see "Green Box" for "2TK59" product
    And should see "Update Shopping List" for "2TK59" product

    When I click "Catalog Switcher Toggle"
    Then click "List View"
    When I hover on "Shopping Cart"
    And I click "Shopping List" on shopping list widget
    And I click "Shopping List Actions"
    When I click "Delete"
    And I click "Yes, delete"
    Then should see "Shopping List deleted" flash message
