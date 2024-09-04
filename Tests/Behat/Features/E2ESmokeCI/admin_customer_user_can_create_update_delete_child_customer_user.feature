@e2esmokeci
Feature: Admin customer user can create, update, delete child customer user

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create customer and customer user with Administrator privileges
    Given I proceed as the Admin
    And I login as administrator
    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name | Third e2e Customer |
    And save and close form
    Then should see "Customer has been saved" flash message

    When go to Customers/ Customer Users
    And click "Create Customer User"
    And fill form with:
      | First Name    | Nancy                     |
      | Last Name     | Martin e2e                |
      | Email Address | NancyRMartin1@example.org |
    And I focus on "Birthday" field
    And click "Today"
    And fill form with:
      | Password                   | NancyRMartin1@example.org |
      | Confirm Password           | NancyRMartin1@example.org |
      | Customer                   | Third e2e Customer        |
      | Administrator (Predefined) | true                      |
    And fill "Customer User Addresses Form" with:
      | Primary                    | true          |
      | First Name Add             | Nancy         |
      | Last Name Add              | Martin e2e    |
      | Organization               | Smoke Org     |
      | Country                    | United States |
      | Street                     | Market St. 12 |
      | City                       | San Francisco |
      | State                      | California    |
      | Zip/Postal Code            | 90001         |
      | Billing                    | true          |
      | Shipping                   | true          |
      | Default Billing            | true          |
      | Default Shipping           | true          |
    And save and close form
    Then should see "Customer User has been saved" flash message

  Scenario: Customer User with Administrator privileges create/update/block/delete new Customer User
    Given I proceed as the Admin
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as NancyRMartin1@example.org on the store frontend in old session
    And I click "Account Dropdown"
    And click "Roles"
    When click "Create Customer User Role"
    And I fill "CustomerUserRoleForm" with:
      | Role Title | e2e Buyer Role |
    And I select customer user role permissions:
      | Checkout                | View:User (Own) | Create:User (Own) | Edit:User (Own) | Delete:User (Own) | Assign:User (Own) |
      | Customer User Address   | View:User (Own) | Create:User (Own) | Edit:User (Own) | Delete:User (Own) | Assign:User (Own) |
      | Order                   | View:User (Own) | Create:User (Own) | Edit:User (Own) | Delete:User (Own) | Assign:User (Own) |
      | Shopping List           | View:User (Own) | Create:User (Own) | Edit:User (Own) | Delete:User (Own) | Assign:User (Own) |
      | Shopping List Line Item | View:User (Own) | Create:User (Own) | Edit:User (Own) | Delete:User (Own) | Assign:User (Own) |
    And I click on "Second Save Button"
    Then should see "Customer User Role has been saved" flash message
    And click on "Flash Message Close Button"
    And I click "Account Dropdown"
    And click "Users"
    And click "Create User"
    Then should see that "Email Address" contains "Enter your email" placeholder
    And should see that "Name Prefix" contains "Enter your name prefix" placeholder
    And should see that "First Name" contains "Enter your first name" placeholder
    And should see that "Middle Name" contains "Enter your middle name" placeholder
    And should see that "Last Name" contains "Enter your last name" placeholder
    And should see that "Name Suffix" contains "Enter your name suffix" placeholder
    And should see that "Password" contains "Enter your new password" placeholder
    And should see that "Confirm Password" contains "Enter password confirmation" placeholder
    When fill form with:
      | Email Address                 | TestUser1@test.com |
      | First Name                    | TestF              |
      | Last Name                     | TestL e2e          |
      | Password                      | TestUser1@test.com |
      | Confirm Password              | TestUser1@test.com |
      | e2e Buyer Role (Customizable) | true               |
    And click "Save"
    Then should see "Customer User has been saved" flash message
    And click on "Flash Message Close Button"

    And I click "Account Dropdown"
    And click "Address Book"
    And click "New Address"
    And fill form with:
      | User            | TestF TestL e2e |
      | First Name      | TestF           |
      | Last Name       | TestL e2e       |
      | Organization    | OroCommerce     |
      | Country         | United States   |
      | Street          | Parnasus Ave 13 |
      | City            | San Francisco   |
      | State           | California      |
      | Zip/Postal Code | 90001           |
    And click "Save"
    Then I should see "Customer User Address has been saved" flash message

    When I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as TestUser1@test.com on the store frontend in old session
    Then should see "TestF TestL e2e"
    And I click "Account Dropdown"
    When click "Address Book"
    Then I should see following "Customer Company User Addresses Grid" grid:
      | Customer Address | City          | State      | Zip/Postal Code | Country       |
      | Parnasus Ave 13  | San Francisco | California | 90001           | United States |
    And I click "Account Dropdown"
    And click "Sign Out"

    When I proceed as the Admin
    And I click "Account Dropdown"
    And click "Users"
    And click disable "TestUser1@test.com" in grid
    And I proceed as the User
    And I signed in as TestUser1@test.com on the store frontend in old session
    Then I should see "Your login was unsuccessful. Please check your e-mail address and password before trying again."
    And I proceed as the Admin

    And I click "Account Dropdown"
    And click "Users"
    And click edit "TestUser1@test.com" in grid
    And fill form with:
      | Enable      | true        |
      | Name Prefix | Test Prefix |
    And click "Save"
    Then should see "Customer User has been saved" flash message
    And click on "Flash Message Close Button"

    And I click "Account Dropdown"
    And click "Users"
    And click view "TestUser1@test.com" in grid
    And click "Edit User Address"
    And fill form with:
      | Street          | Parnasus Ave 15 |
      | Zip/Postal Code | 90002           |
    And click "Save"
    Then I should see "Customer User Address has been saved" flash message
    And I proceed as the User
    And I signed in as TestUser1@test.com on the store frontend in old session
    And I click "Account Dropdown"

    When click "Address Book"
    Then I should see following "Customer Company User Addresses Grid" grid:
      | Customer Address | City          | State      | Zip/Postal Code | Country       |
      | Parnasus Ave 15  | San Francisco | California | 90002           | United States |
    And I click "Account Dropdown"
    And click "Sign Out"
    And I proceed as the Admin
    And I click "Account Dropdown"

    When click "Users"
    And click delete "TestUser1@test.com" in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message
    And I reload the page
    And should not see "TestUser1@test.com"
    And I click "Account Dropdown"
    And click "Roles"
    When click delete "e2e Buyer Role" in grid
    Then should see "Customer User Role deleted" flash message

  Scenario: Clear data in back-office
    Given I proceed as the User
    And I login as administrator

    When go to Customers/ Customer Users
    And I filter "Email Address" as Contains "NancyRMartin1@example.org"
    And I click delete 'NancyRMartin1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message

    When go to Customers/ Accounts
    And I filter "Account name" as Contains "Third e2e Customer"
    And I click delete 'Third e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Item deleted" flash message

    When go to Customers/ Customers
    And I filter "Name" as Contains "Third e2e Customer"
    And I click delete 'Third e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message
