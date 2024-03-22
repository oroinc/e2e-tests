@e2esmokeci
Feature: Create delete customer, customer user and related actions

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create Payment Term and Customer
    Given I proceed as the Admin
    And I login as administrator

    When go to Sales/ Payment terms
    And click "Create Payment Term"
    And type "net_10_e2e" in "Label"
    And save and close form

    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name         | e2e Customer       |
      | Price List   | Default Price List |
      | Payment Term | net_10_e2e         |
    And save and close form
    Then should see "Customer has been saved" flash message

  Scenario: Create customer user with address from the back-office
    When go to Customers/ Customer Users
    And click "Create Customer User"
    And fill form with:
      | First Name    | Branda                      |
      | Last Name     | Sanborn e2e                 |
      | Email Address | BrandaJSanborn1@example.org |
    And I focus on "Birthday" field
    And click "Today"
    And fill form with:
      | Password                   | BrandaJSanborn1@example.org |
      | Confirm Password           | BrandaJSanborn1@example.org |
      | Customer                   | e2e Customer                |
      | Administrator (Predefined) | true                        |
    And fill "Customer User Addresses Form" with:
      | Primary                    | true          |
      | First Name Add             | Branda        |
      | Last Name Add              | Sanborn e2e   |
      | Organization               | e2e Org       |
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

  Scenario: Create customer and customer user from the storefront
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    When click "Log In"
    And click "Sign Up"
    And I fill "Registration Form" with:
      | Company Name     | OroCommerce e2e          |
      | First Name       | Amanda                   |
      | Last Name        | Cole e2e                 |
      | Email            | AmandaRCole1@example.org |
      | Password         | AmandaRCole1@example.org |
      | Confirm Password | AmandaRCole1@example.org |
    And I confirm Agreements "Terms and Conditions" at registration step
    When I click "Create Account"
    Then I should see "Please check your email to complete registration" flash message

  Scenario: Unconfirmed customer user cannot login
    When fill form with:
      | Email    | AmandaRCole1@example.org |
      | Password | AmandaRCole1@example.org |
    And click "Log In Button"
    Then I should see "Your login was unsuccessful. Please check your e-mail address and password before trying again."

  Scenario: Activate customer user and login with activated customer
    Given  I proceed as the Admin
    When go to Customers/ Customer Users
    And click view "AmandaRCole1@example.org" in grid
    And click "Confirm"
    And go to Customers/ Customers
    And click edit "OroCommerce e2e" in grid
    And fill form with:
      | Payment Term | net_10_e2e |
    And save and close form

    When I proceed as the User
    And fill form with:
      | Email    | AmandaRCole1@example.org |
      | Password | AmandaRCole1@example.org |
    And click "Log In Button"
    Then should see "Amanda Cole e2e"
    And I click "Account Dropdown"
    And click "Sign Out"

  Scenario: Clear all data
    Given I proceed as the Admin
    When go to Customers/ Customer Users
    And I click delete 'BrandaJSanborn1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message

    And I click delete 'AmandaRCole1@example.org' in grid
    And click "Yes, Delete"
    Then should see "Customer User deleted" flash message

    When go to Customers/ Customers
    And I filter "Name" as Contains "e2e Customer"
    And I click delete 'e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message

    When go to Customers/ Customers
    And I filter "Name" as Contains "OroCommerce e2e"
    And I click delete 'OroCommerce e2e' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message

    When go to Customers/ Accounts
    And I filter "Account name" as Contains "e2e Customer"
    And I click delete 'e2e Customer' in grid
    And click "Yes, Delete"
    Then should see "Item deleted" flash message

    When go to Customers/ Accounts
    And I filter "Account name" as Contains "OroCommerce e2e"
    And I click delete 'OroCommerce e2e' in grid
    And click "Yes, Delete"
    Then should see "Item deleted" flash message

    When go to Sales/ Payment terms
    And I click delete 'net_10_e2e' in grid
    And click "Yes"
    Then should see "Payment Term deleted" flash message
