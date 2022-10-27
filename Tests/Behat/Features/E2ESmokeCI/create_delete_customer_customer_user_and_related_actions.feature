@e2esmokeci
Feature: Create delete customer, customer user and related actions

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Create customer
    Given I proceed as the Admin
    And I login as administrator
    And I close organization notice
    When go to Customers/ Customers
    And click "Create Customer"
    And fill "Customer Form" with:
      | Name         | Smoke Customer     |
      | Price List   | Default Price List |
      | Payment Term | net_10             |
    And save and close form
    Then should see "Customer has been saved" flash message

  Scenario: Create customer user from the Admin panel (add address)
    When go to Customers/ Customer Users
    And click "Create Customer User"
    And fill form with:
      | First Name    | Branda                      |
      | Last Name     | Sanborn                     |
      | Email Address | BrandaJSanborn1@example.org |
    And I focus on "Birthday" field
    And click "Today"
    And fill form with:
      | Password         | BrandaJSanborn1@example.org |
      | Confirm Password | BrandaJSanborn1@example.org |
      | Customer         | Smoke Customer              |
    And fill "Customer User Addresses Form" with:
      | Primary                    | true          |
      | First Name Add             | Branda        |
      | Last Name Add              | Sanborn       |
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
      | Administrator (Predefined) | true          |
    And save and close form
    Then should see "Customer User has been saved" flash message

  Scenario: Create customer and customer user from the frontstore
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    When click "Sign In"
    Then should see that "Email Address" contains "name@domain.com" placeholder
    And should see that "Password" contains "Enter your password" placeholder
    When click "Create An Account"
    Then should see that "Company Name" contains "Company Inc." placeholder
    And should see that "First Name" contains "John" placeholder
    And should see that "Last Name" contains "Smith" placeholder
    And should see that "Email Address" contains "name@domain.com" placeholder
    And should see that "Password" contains "Enter your password" placeholder
    And should see that "Confirm Password" contains "Reenter your password" placeholder
    And I fill "Registration Form" with:
      | Company Name     | OroCommerce              |
      | First Name       | Amanda                   |
      | Last Name        | Cole                     |
      | Email Address    | AmandaRCole1@example.org |
      | Password         | AmandaRCole1@example.org |
      | Confirm Password | AmandaRCole1@example.org |
    And I confirm Agreements "Terms and Conditions" at registration step
    When I click "Create An Account"
    Then I should see "Please check your email to complete registration" flash message

  Scenario: Unconfirmed customer user cannot login
    When fill form with:
      | Email Address | AmandaRCole1@example.org |
      | Password      | AmandaRCole1@example.org |
    And click "Sign In"
    Then I should see "Your login was unsuccessful. Please check your e-mail address and password before trying again."

  Scenario: Activate customer user and login with activated customer
    Given  I proceed as the Admin
    When go to Customers/ Customer Users
    And click view "AmandaRCole1@example.org" in grid
    And click "Confirm"
    And go to Customers/ Customers
    And click edit "OroCommerce" in grid
    And fill form with:
      | Payment Term | net_10 |
    And save and close form

    When I proceed as the User
    And fill form with:
      | Email Address | AmandaRCole1@example.org |
      | Password      | AmandaRCole1@example.org |
    And click "Sign In"
    Then should see "Signed in as: Amanda Cole"
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
    And I click delete 'Smoke Customer' in grid
    And click "Yes, Delete"
    Then should see "Customer deleted" flash message
