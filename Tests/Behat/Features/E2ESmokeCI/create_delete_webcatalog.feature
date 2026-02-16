@e2esmokeci
Feature: Create delete webcatalog

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create categories in master catalog and content nodes in webcatalog
    Given I proceed as the Admin
    And I login as administrator
    When I go to Marketing/ Web Catalogs
    And I click "Create Web Catalog"
    And I type "e2e Catalog" in "Name"
    And save and close form
    Then I should see "Web Catalog has been saved" flash message

    When I click "Edit Content Tree"
    And I click on "Show Variants Dropdown"
    And I click "Add Landing Page"
    And I fill "Content Node Form" with:
      | Titles       | Root Node |
      | Landing Page | Homepage  |
    And I save form
    Then I should see "Content Node has been saved" flash message

    When go to System/ Configuration
    And follow "System Configuration/Websites/Routing" on configuration sidebar
    And uncheck "Use default" for "Web Catalog" field
    And I save setting
    And I fill form with:
      | Web Catalog | e2e Catalog |
    And I save setting
    Then I should see "Configuration saved" flash message

    When I go to Products/ Master Catalog
    And I click "All Products"
    And I click "Create Subcategory"
    And I fill "Category Form" with:
      | Title | Lighting Products e2e |
    And I save form

    When I go to Products/ Master Catalog
    And I click "All Products"
    And I click "Create Subcategory"
    And I fill "Category Form" with:
      | Title | Medical e2e |
    And I save form

    When I go to Marketing/ Web Catalogs
    And click "Edit Content Tree" on row "e2e Catalog" in grid
    And I click "Root Node"
    And click "Create Content Node"
    And I fill "Content Node Form" with:
      | Titles | Lighting Products e2e |
    And I click on "Show Variants Dropdown"
    And I click "Add Category"
    And click "Lighting Products e2e"
    And I save form
    Then I should see "Content Node has been saved" flash message

    When I click "Root Node"
    And click "Create Content Node"
    And I fill "Content Node Form" with:
      | Titles | Medical e2e |
    And I click on "Show Variants Dropdown"
    And I click "Add Category"
    And click "Medical e2e"
    And I save form
    Then I should see "Content Node has been saved" flash message

  Scenario: Create products in different categories
    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type | Simple |
    And click "Lighting Products e2e"
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU               | 220_lumen_headlamp_e2e              |
      | Name              | 220 Lumen Rechargeable Headlamp e2e |
      | Status            | Enable                              |
      | Unit Of Quantity  | item                                |
      | Description       | Product Description                 |
      | Short Description | Product_Short_Description           |
    And save and close form
    Then I should see "Product has been saved" flash message

    When go to Products/ Products
    And click "Create Product"
    And fill form with:
      | Type | Simple |
    And click "Medical e2e"
    And click "Continue"
    And fill "Create Product Form" with:
      | SKU               | blood_pressure_monitors_e2e |
      | Name              | Blood Pressure Monitors e2e |
      | Status            | Enable                      |
      | Unit Of Quantity  | item                        |
      | Description       | Product Description         |
      | Short Description | Product_Short_Description   |
    And save and close form
    Then I should see "Product has been saved" flash message

  Scenario: Frontend filters check
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    When I click "Lighting Products e2e" in hamburger menu
    And filter Any Text as contains "220 Lumen"
    Then I should see "220_lumen_headlamp_e2e" product
    And should not see "blood_pressure_monitors_e2e" product
    And click "Reset Any Text filter"

    When I click "Medical e2e" in hamburger menu
    When filter SKU as is equal to "blood_pressure_monitors_e2e"
    Then I should not see "220_lumen_headlamp_e2e" product
    And should see "blood_pressure_monitors_e2e" product
    And click "Reset SKU filter"

  Scenario: Clear all data
    Given I proceed as the Admin
    When go to System/ Configuration
    And follow "System Configuration/Websites/Routing" on configuration sidebar
    And check "Use default" for "Web Catalog" field
    And I save setting
    Then I should see "Configuration saved" flash message

    When I go to Marketing/ Web Catalogs
    And click delete "e2e Catalog" in grid
    And click "Yes, Delete"
    Then I should see "Web Catalog deleted" flash message

    When I go to Products/ Master Catalog
    And I click "Lighting Products e2e"
    And I click "Delete"
    And click "Yes, Delete"

    And I click "Medical e2e"
    And I click "Delete"
    And click "Yes, Delete"

    When go to Products/ Products
    And click delete '220_lumen_headlamp_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted" flash message

    When go to Products/ Products
    And click delete 'blood_pressure_monitors_e2e' in grid
    And click "Yes, Delete"
    Then I should see "Product deleted" flash message
