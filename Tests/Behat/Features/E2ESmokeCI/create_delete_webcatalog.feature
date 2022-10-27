@e2esmokeci
Feature: Create delete webcatalog

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create WebCatalog
    Given I proceed as the Admin
    And I login as administrator
    And I close organization notice
    When I go to Marketing/ Web Catalogs
    And I click "Create Web Catalog"
    And I type "NewCatalog" in "Name"
    And save and close form
    Then I should see "Web Catalog has been saved" flash message

    When I click "Edit Content Tree"
    And I click on "Show Variants Dropdown"
    And I click "Add System Page"
    And I fill "Content Node Form" with:
      | Titles            | Root Node                               |
      | System Page Route | Oro Frontend Root (Welcome - Home page) |
    And I save form
    Then I should see "Content Node has been saved" flash message

    When go to System/ Configuration
    And follow "System Configuration/Websites/Routing" on configuration sidebar
    And uncheck "Use default" for "Web Catalog" field
    And I save setting
    And I fill form with:
      | Web Catalog | NewCatalog |
    And I save setting
    Then I should see "Configuration saved" flash message

    When I go to Marketing/ Web Catalogs
    And click "Edit Content Tree" on row "NewCatalog" in grid
    And I click "Root Node"
    And click "Create Content Node"
    And I fill "Content Node Form" with:
      | Titles   | Lighting Products |
      | Url Slug | lighting-products |
    And I click on "Show Variants Dropdown"
    And I click "Add Category"
    And click "Lighting Products"
    And I save form
    Then I should see "Content Node has been saved" flash message

    When I click "Root Node"
    And click "Create Content Node"
    And I fill "Content Node Form" with:
      | Titles   | Medical |
      | Url Slug | medical |
    And I click on "Show Variants Dropdown"
    And I click "Add Category"
    And click "Medical"
    And I save form
    Then I should see "Content Node has been saved" flash message

  Scenario: Frontend filters check
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    When I click "Lighting Products"
    And filter Any Text as contains "220 Lumen"
    Then I should see "0RT28" product
    And should not see "6UK81" product
    And click "Reset Any Text filter"

    When filter SKU as is equal to "6UK81"
    Then I should not see "0RT28" product
    And should see "6UK81" product
    And click "Reset SKU filter"

    When filter Name as contains "220 Lumen"
    Then I should see "0RT28" product
    And should not see "6UK81" product

  Scenario: Clear all data
    Given I proceed as the Admin
    When go to System/ Configuration
    And follow "System Configuration/Websites/Routing" on configuration sidebar
    And I fill form with:
      | Web Catalog | Default Web Catalog |
    And I save setting
    Then I should see "Configuration saved" flash message

    When I go to Marketing/ Web Catalogs
    And click delete "NewCatalog" in grid
    And click "Yes, Delete"
    Then I should see "Web Catalog deleted"
