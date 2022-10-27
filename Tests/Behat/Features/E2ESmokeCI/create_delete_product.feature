@e2esmokeci
Feature: Create delete product
  Scenario: Create different window session
    Given sessions active:
      | Admin  |first_session |
      | User   |second_session|

  Scenario: Create category, product in category,  product without category and assign it to the category
    Given I proceed as the Admin
    And I login as administrator
    When go to Products/ Master Catalog
    And click "Create Category"
    And fill "Create Category Form" with:
    | Title               | Phones |
    | Inventory Threshold | 0      |
    And click "Save"
    Then I should see "Category has been saved" flash message

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
    | Type | Simple |
    And click "Phones"
    And click "Continue"
    And fill "Create Product Form" with:
    | SKU               | Lenovo_Vibe_sku           |
    | Name              | Lenovo Vibe               |
    | Status            | Enable                    |
    | Unit Of Quantity  | item                      |
    | Tax Code          | TAXABLE_ITEMS             |
    | Description       | Product Description       |
    | Short Description | Product_Short_Description |
    And I wait for "3" seconds
    And I click "Add Image"
    And fill "Create Product Form" with:
    | Product Image    | black_shirt.jpg |
    | Main Image       | true            |
    | Listing Image    | true            |
    | Additional Image | true            |
    And click "AddPrice"
    And fill "Product Price Form" with:
    | Price List     | Default Price List |
    | Quantity       | 1                  |
    | Value          | 100                |
    | Currency       | $                  |
    And save and close form
    Then I should see "Product has been saved" flash message

  Scenario: Check availability on front store
    Given I proceed as the User
    And I am on the homepage
    And I am on "/product"
    When filter SKU as is equal to "Lenovo_Vibe_sku"
    Then I should see "Lenovo_Vibe_sku" product

  Scenario: Delete product and category
    Given I proceed as the Admin
    When go to Products/ Products
    And click delete 'Lenovo_Vibe_sku' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted"
    When go to Products/ Master Catalog
    And click "Phones"
    And click "Delete"
    And I confirm deletion
    Then I should see "Category deleted"

  Scenario: Check unavailability on front store
    Given I proceed as the User
    And I am on the homepage
    And I am on "/product"
    When filter SKU as is equal to "Lenovo_Vibe_sku"
    Then I should not see "Lenovo_Vibe_sku" product
