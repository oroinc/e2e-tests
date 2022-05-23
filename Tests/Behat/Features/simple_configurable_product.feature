@e2e

Feature: Simple configurable product

  Scenario: Create configurable product with correct data (Product Attribute, Product Family)
    Given I login as administrator
    And go to Products/ Product Attributes
    And click "Create Attribute"
    And fill form with:
      | Field Name | Color1  |
      | Type       | Select |
    And click "Continue"
    And set Options with:
      | Label  |
      | Black  |
      | White  |
    And save and close form for product attribute
    And I click "Create Attribute"
    And fill form with:
      | Field Name | Size1   |
      | Type       | Select |
    And click "Continue"
    And set Options with:
      | Label  |
      | L      |
      | M      |
    When save and close form for product attribute
    And I reload the page
    And click update schema
    Then should see Schema updated flash message

    And go to Products/ Product Families
    When I click "Create Product Family"
    And fill "Product Family Form" with:
      | Code       | tshirt_family |
      | Label      | Tshirts       |
      | Enabled    | True          |
    And click "Add"
    And fill "Attributes Group Form" with:
      | Attribute Groups Label1      | Product Prices   |
      | Attribute Groups Visible1    | true             |
      | Attribute Groups Attributes1 | [Product prices] |
    And click "Add"
    And fill "Attributes Group Form" with:
      | Attribute Groups Label2      | Inventory          |
      | Attribute Groups Visible2    | true               |
      | Attribute Groups Attributes2 | [Inventory Status] |
    And click "Add"
    And fill "Attributes Group Form" with:
      | Attribute Groups Label3      | Images   |
      | Attribute Groups Visible3    | true     |
      | Attribute Groups Attributes3 | [Images] |
    And click "Add"
    And fill "Attributes Group Form" with:
      | Attribute Groups Label4      | SEO                               |
      | Attribute Groups Visible4    | true                              |
      | Attribute Groups Attributes4 | [Meta keywords, Meta description] |
    And click "Add"
    And fill "Attributes Group Form" with:
      | Attribute Groups Label5      | Attribute Family |
      | Attribute Groups Visible5    | true             |
      | Attribute Groups Attributes5 | [Color1, Size1]    |
    And save and close form
    Then should see "Product Family was successfully saved" flash message

    And go to Products/ Master Catalog
    And click "Create Category"
    And fill "Create Category Form" with:
      | Title               | Shirts |
      | Inventory Threshold | 0      |
    And click "Save"

    And go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type           | Simple  |
      | Product Family | Tshirts |
    And click "Shirts"
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU              | Black_Shirt_M_sku |
      | Name             | Black Shirt       |
      | Status           | Enable            |
      | Unit Of Quantity | item              |
    And I click "Add Image"
    And fill "Create Product Form" with:
      | Product Image    | black_shirt.jpg |
      | Main Image       | true            |
      | Listing Image    | true            |
      | Additional Image | true            |
      | Color1            | Black           |
      | Size1             | M               |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 10                 |
      | Currency   | $                  |
    And save and close form
    And go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type           | Simple  |
      | Product Family | Tshirts |
    And click "Shirts"
      | Category | Shirts |
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU              | Black_Shirt_L_sku |
      | Name             | Black Shirt       |
      | Status           | Enable            |
      | Unit Of Quantity | item              |
    And I click "Add Image"
    And fill "Create Product Form" with:
      | Product Image    | black_shirt.jpg |
      | Main Image       | true            |
      | Listing Image    | true            |
      | Additional Image | true            |
      | Color1            | Black           |
      | Size1             | L               |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 8                  |
      | Currency   | $                  |
    And save and close form
    And go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type           | Simple  |
      | Product Family | Tshirts |
    And click "Shirts"
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU              | White_Shirt_M_sku |
      | Name             | White Shirt       |
      | Status           | Enable            |
      | Unit Of Quantity | item              |
    And I click "Add Image"
    And fill "Create Product Form" with:
      | Product Image    | white_shirt.jpg |
      | Main Image       | true            |
      | Listing Image    | true            |
      | Additional Image | true            |
      | Color1            | White           |
      | Size1             | M               |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 12                 |
      | Currency   | $                  |
    And save and close form
    And go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type           | Simple  |
      | Product Family | Tshirts |
    And click "Shirts"
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU              | White_Shirt_L_sku |
      | Name             | White Shirt       |
      | Status           | Enable            |
      | Unit Of Quantity | item              |
    And I click "Add Image"
    And fill "Create Product Form" with:
      | Product Image    | white_shirt.jpg |
      | Main Image       | true            |
      | Listing Image    | true            |
      | Additional Image | true            |
      | Color1            | White           |
      | Size1             | L               |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 13                 |
      | Currency   | $                  |
    And save and close form

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type           | Configurable |
      | Product Family | Tshirts      |
    And click "Shirts"
    And click "Continue"
    And fill "Create Product Form" with:
      | Name                          | ConfigurableShirt |
      | SKU                           | Shirt_Sku         |
      | Status                        | Enable            |
      | Unit Of Quantity              | item              |
      | Configurable Attributes Color | true              |
      | Configurable Attributes Size  | true              |
    And I click "Add Image"
    And fill "Create Product Form" with:
      | Product Image    | uni_shirt.jpg |
      | Main Image       | true          |
      | Listing Image    | true          |
      | Additional Image | true          |
    And save and close form
    And click "Edit Product"
    And click on Black_Shirt_L_sku in grid
    And click on Black_Shirt_M_sku in grid
    And click on White_Shirt_L_sku in grid
    And click on White_Shirt_M_sku in grid
    And save and close form
    Then should see "Product has been saved" flash message