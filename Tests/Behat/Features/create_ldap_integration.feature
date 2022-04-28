@e2e

Feature: Create LDAP integration

  Scenario: Create integration
    Given I login as administrator
    And go to System/ Integrations/ Manage Integrations
    And click "Create Integration"
    And I fill "E2E Integration Form" with:
      | Type                                | LDAP                                           |
      | Name                                | LDAP                                           |
      | Hostname                            | <Secret:ldap.hostname>                         |
      | Port                                | <Secret:ldap.port>                             |
      | Encryption                          | <Secret:ldap.encryption>                       |
      | Base Distinguished Name             | <Secret:ldap.base_dn>                          |
      | Username                            | <Secret:ldap.username>                         |
      | Password                            | <Secret:ldap.password>                         |
      | Default Business Unit Owner         | <Secret:ldap.default_business_unit_owner>      |
      | Enable Two Way Sync                 | true                                           |
      | User Filter                         | <Secret:ldap.mapping.user_filter>              |
      | User Information Username           | <Secret:ldap.mapping.username>                 |
      | Primary Email                       | <Secret:ldap.mapping.primary_email>            |
      | First name                          | <Secret:ldap.mapping.first_name>               |
      | Last name                           | <Secret:ldap.mapping.last_name>                |
      | Role Filter                         | <Secret:ldap.mapping.role_filter>              |
      | Role Id Attribute                   | <Secret:ldap.mapping.role_id_attribute>        |
      | Role User Id Attribute              | <Secret:ldap.mapping.role_user_id_attribute>   |
      | Export User Object Class            | <Secret:ldap.mapping.export_user_object_class> |
      | Export User Base Distinguished Name | <Secret:ldap.mapping.export_user_base_dn>      |
    And I click "Add"
    And I fill "E2E Integration Form" with:
      | LDAP Role Name | admin         |
      | CRM Role Names | Administrator |
    And I click "Add"
    And I fill "E2E Integration Form" with:
      | LDAP Role Name 2 | manager       |
      | CRM Role Names 2 | Sales Manager |
    When I click "Check Connection"
    Then I should see "Successfully connected to LDAP server."
    When I save and close form
    Then I should see "Integration saved" flash message
