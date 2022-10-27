@e2e

Feature: Sample data set

  Scenario: Create integration
    Given I login as administrator
    And I go to Products / Product Attributes
    And I click "Import file"
    And I upload "New_Cloud_Products_attributes_R.csv" file to "ShoppingListImportFileField"
    And I click "Import file"
    And I should see "Import started successfully. You will receive an email notification upon completion." flash message
    And I wait for 10 seconds
    And I reload the page
    And click update schema
    Then should see Schema updated flash message

  Scenario: Create Product Families
    Given I go to Products / Product Families
    When I click "Create Product Family"
    And I fill "Product Family Form" with:
      | Code    | Tea_Family |
      | Label   | Tea_Family |
      | Enabled | true       |
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
      | Attribute Groups Label5      | Attribute Family                     |
      | Attribute Groups Visible5    | true                                 |
      | Attribute Groups Attributes5 | [Grade, Country, Date Of Production] |
    And save and close form
    Then should see "Product Family was successfully saved" flash message

    And I go to Products / Product Families
    When I click "Create Product Family"
    And I fill "Product Family Form" with:
      | Code    | Weapon_Family |
      | Label   | Weapon_Family |
      | Enabled | true          |
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
      | Attribute Groups Label5      | Attribute Family                                                                                                             |
      | Attribute Groups Visible5    | true                                                                                                                         |
      | Attribute Groups Attributes5 | [Axe-Handle, Barrel Length, BladeLength, Caliber, Color, DrawLength, Handle Cover, Force, Rounds, Steel Mark, StructureType] |
    And save and close form
    Then should see "Product Family was successfully saved" flash message

    And I go to Products / Product Families
    When I click "Create Product Family"
    And I fill "Product Family Form" with:
      | Code    | Phone_Family |
      | Label   | Phone_Family |
      | Enabled | true         |
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
      | Attribute Groups Label5      | Attribute Family                                                                                                                                                                                                              |
      | Attribute Groups Visible5    | true                                                                                                                                                                                                                          |
      | Attribute Groups Attributes5 | [Battery Life Indicator, Bluetooth Capable, Bluetooth Version, Camera, Color, Material, Memory Size, Operation System, Power Capacity, Product Series, Screen Resolution, Screen Size, Standby Time, Storage Size, Talk Time] |
    And save and close form
    Then should see "Product Family was successfully saved" flash message

  Scenario: Import Product Categories
    Given I go to Products / Master Catalog
    And I click "Import file"
    And I upload "New_Cloud_Category_R_noid.csv" file to "ShoppingListImportFileField"
    And I click "Import file"
    And I should see "Import started successfully. You will receive an email notification upon completion." flash message
    And I wait for 20 seconds

  Scenario: Import Products
    Given I go to Products / Products
    And I click "Import file"
    And I upload "New_Cloud_Products_All_1_t.csv" file to "ShoppingListImportFileField"
    And I click "Import file"
    And I should see "Import started successfully. You will receive an email notification upon completion." flash message
    And I wait for 20 seconds

  Scenario: Import Products Prices
    Given I go to Sales / Price Lists
    And click view "Default Price List" in grid
    And I click "Import file"
    And I upload "New_Cloud_Prices_1.csv" file to "ShoppingListImportFileField"
    And I click "Import file"
    And I should see "Import started successfully. You will receive an email notification upon completion." flash message
