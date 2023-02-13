@e2esmokeci
Feature: Admin customer user can create, update, delete child customer user

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Customer User with Administrator privileges create/update/block/delete new Customer User
    Given I proceed as the Admin
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as AmandaRCole@example.org on the store frontend in old session
    And follow "Account"
    And click "Roles"
    When click edit "Buyer" in grid
    And I wait for 1 seconds
    And fill form with:
      | Role Title | NewByerRole |
    And I uncheck LoisLLessard@example.org record in grid
    And I uncheck BrandaJSanborn@example.org record in grid
    And I click on "Second Save Button"
    Then should see "Customer User Role has been saved" flash message

    When click "Users"
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
      | Email Address              | TestUser1@test.com |
      | First Name                 | TestF              |
      | Last Name                  | TestL              |
      | Password                   | TestUser1@test.com |
      | Confirm Password           | TestUser1@test.com |
      | NewByerRole (Customizable) | true               |
    And click "Save"
    Then should see "Customer User has been saved" flash message

    When click "Address Book"
    And click "New Address"
    And fill form with:
      | User            | TestF TestL     |
      | First Name      | TestF           |
      | Last Name       | TestL           |
      | Organization    | OroCommerce     |
      | Country         | United States   |
      | Street          | Parnasus Ave 13 |
      | City            | San Francisco   |
      | State           | California      |
      | Zip/Postal Code | 90001           |
    And click "Save"
    Then I should see "Customer User Address has been saved" flash message
#
    When I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as TestUser1@test.com on the store frontend in old session
    Then should see "Signed in as: TestF TestL"
    And follow "Account"
    When click "Address Book"
    Then I should see following "Customer Company User Addresses Grid" grid:
      | Customer Address | City          | State      | Zip/Postal Code | Country       |
      | Parnasus Ave 13  | San Francisco | California | 90001           | United States |
    And click "Sign Out"

    When I proceed as the Admin
    And follow "Account"
    And click "Users"
    And click disable "TestUser1@test.com" in grid
    And I proceed as the User
    And I signed in as TestUser1@test.com on the store frontend in old session
    Then I should see "Your login was unsuccessful. Please check your e-mail address and password before trying again."
    And I proceed as the Admin

    When follow "Account"
    And click "Users"
    And click edit "TestUser1@test.com" in grid
    And fill form with:
      | Enable      | true        |
      | Name Prefix | Test Prefix |
    And click "Save"
    Then should see "Customer User has been saved" flash message

    When click "Users"
    And click view "TestUser1@test.com" in grid
    And click "Edit User Address"
    And fill form with:
      | Street          | Parnasus Ave 15 |
      | Zip/Postal Code | 90002           |
    And click "Save"
    Then I should see "Customer User Address has been saved" flash message
    And I proceed as the User
    And I signed in as TestUser1@test.com on the store frontend in old session
    And follow "Account"

    When click "Address Book"
    Then I should see following "Customer Company User Addresses Grid" grid:
      | Customer Address | City          | State      | Zip/Postal Code | Country       |
      | Parnasus Ave 15  | San Francisco | California | 90002           | United States |
    And click "Sign Out"
    And I proceed as the Admin
    And follow "Account"

    When click "Users"
    And click delete "TestUser1@test.com" in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message
    And I reload the page
    And should not see "TestUser1@test.com"
    And follow "Account"
    And click "Roles"
    When click delete "NewByerRole" in grid
    Then should see "Customer User Role deleted" flash message
