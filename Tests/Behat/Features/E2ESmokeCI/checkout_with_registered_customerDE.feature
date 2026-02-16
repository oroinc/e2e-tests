@e2esmoke_de_ci
Feature: Checkout with registered customer

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Precondition
    Given I proceed as the Admin
    And I login as administrator
    And go to System/ Konfiguration
    And follow "Handel/Lagerbestand/Produkt-Optionen" on configuration sidebar
    And fill "Product Option Form" with:
      | Backorders Default | false |
      | Lieferrückstände   | Ja    |
    And I click "Einstellungen speichern"
    Then I should see "Konfiguration gespeichert" flash message

  Scenario: Create Payment Term, Customer, Customer User and product
    When go to Vertrieb/ Zahlungsbedingungen
    And click "Zahlungsbedingung hinzufügen"
    And type "net_10_e2e" in "Bezeichnung"
    And click "Speichern und schließen"

    When go to Kunden/ Kunden
    And click "Kunde hinzufügen"
    And fill "Customer Form" with:
      | Name              | e2e Customer       |
      | Price List        | Default Price List |
      | Zahlungsbedingung | net_10_e2e         |
    And click "Speichern und schließen"
    Then should see "Account wurde gespeichert" flash message

    When go to Kunden/ Benutzer des Kunden
    And click "Benutzer des Kunden hinzufügen"
    And fill form with:
      | Vorname         | Branda                      |
      | Nachname        | Sanborn e2e                 |
      | E-Mail Adressen | BrandaJSanborn1@example.org |
    And I focus on "Geburtsdatum" field
    And click "Heute"
    And fill form with:
      | Passwort             | BrandaJSanborn1@example.org |
      | Passwort bestätigen  | BrandaJSanborn1@example.org |
      | Kunde                | e2e Customer                |
      | Buyer (Vordefiniert) | true                        |
    And fill "Customer User Addresses Form" with:
      | Primär            | true               |
      | First Name Add    | Branda             |
      | Last Name Add     | Sanborn e2e        |
      | Organisation      | e2e Org            |
      | Land              | Vereinigte Staaten |
      | Straße            | Market St. 12      |
      | Ort               | San Francisco      |
      | Bundesland/Kanton | California         |
      | Postleitzahl      | 90001              |
      | Rechnung          | true               |
      | Versand           | true               |
      | Standard Rechnung | true               |
      | Standard Versand  | true               |
    And click "Speichern und schließen"
    Then should see "Account-Benutzer ist gespeichert" flash message

    When go to Produkte/ Produkte
    And click "Produkt hinzufügen"
    And fill form with:
      | Typ | Einfach |
    And click "Fortfahren"
    And fill "Create Product Form" with:
      | SKU               | 110_lumen_headlamp_e2e              |
      | Name              | 110 Lumen Rechargeable Headlamp e2e |
      | Status            | Aktiviert                           |
      | Unit Of Quantity  | Element                             |
      | Description       | Product Description                 |
      | Short Description | Product_Short_Description           |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 10,99              |
      | Currency   | €                  |
    And I take screenshot
    And click "Speichern und schließen"
    Then I should see "Produkt wurde gespeichert" flash message

  Scenario: Create payment and shipping integration
    Given go to System/ Integrationen/ Integrationen verwalten
    And click "Integration hinzufügen"
    And I fill "Integration Form" with:
      | Type  | Pauschale Versandkosten |
      | Name  | Flat Rate e2e           |
      | Label | Flat_Rate_e2e           |
    And click "Speichern und schließen"
    Then I should see "Integration gespeichert" flash message
    When go to System/ Integrationen/ Integrationen verwalten
    And click "Integration hinzufügen"
    And I fill "Integration Form" with:
      | Type        | Zahlungsbedingungen |
      | Name        | Payment Terms e2e   |
      | Label       | Payment_Terms_e2e   |
      | Short Label | Payment Terms e2e   |
    And click "Speichern und schließen"
    Then I should see "Integration gespeichert" flash message

  Scenario: Create payment and shipping integration
    Given I go to System/ Versand Regeln
    And click "Versandregel hinzufügen"
    And fill "E2E Shipping Rule Form" with:
      | Aktiviert          | true          |
      | Name               | Flat Rate e2e |
      | Sortierreihenfolge | 10            |
      | Währung            | €             |
      | Method             | Flat Rate e2e |
    And I click "Add Shipping Rule Method"
    And fill form with:
      | Preis | 10 |
    And click "Speichern und schließen"
    Then should see "Versand Regel wurde gespeichert" flash message
    When I go to System/ Zahlungsregeln
    And click "Zahlungsregel hinzufügen"
    And fill "E2E Payment Rule Form" with:
      | Aktiviert          | true              |
      | Name               | Payment Terms e2e |
      | Sortierreihenfolge | 1                 |
      | Währung            | €                 |
      | Method             | Payment Terms e2e |
    And I click "Add Payment Rule Method"
    When click "Speichern und schließen"
    Then should see "Zahlungsregel wurde gespeichert" flash message

  Scenario:
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as BrandaJSanborn1@example.org on the store frontend in old session
    When I hover on "Shopping Cart"
    And click "Neue Liste erstellen"
    Then should see an "Create New Shopping List popup" element
    And type "e2e SL" in "Einkaufslistenname"
    And click "Erstellen"
    And I should see "e2e SL" flash message

    And I am on homepage
    And I type "110_lumen_headlamp_e2e" in "search"
    And I click "Search Button"
    And I click "110 Lumen Rechargeable Headlamp e2e"
    When I click "Add to e2e SL"
    Then I should see "Produkt wurde zur" flash message and I close it
    When I hover on "Shopping Cart"
    And click "e2e SL" on shopping list widget
    And click "Bestellung anlegen"
    And I confirm Agreements "Terms and Conditions" at the checkout if they are not confirmed
    And I select "Branda Sanborn e2e, e2e Org, Market St. 12, SAN FRANCISCO CA US 90001" on the "Rechnungsinformationen" checkout step and press "Weiter"
    And I select "Branda Sanborn e2e, e2e Org, Market St. 12, SAN FRANCISCO CA US 90001" on the "Versandinformationen" checkout step and press "Weiter"
    And I check "Flat_Rate_e2e" on the "Versandart" checkout step and press "Weiter"
    And I check "Payment_Terms_e2e" on the "Zahlung" checkout step and press "Weiter"
    And fill "Checkout Order Form" with:
      | PO Number | P777155 |
    When I check "Diese Einkaufsliste nach dem Absenden der Bestellung löschen" on the "Bestellung überprüfen" checkout step and press "Bestellung absenden"
    Then I see the "Thank You" page with "Vielen Dank für Ihre Bestellung!" title

  Scenario: Clear all data
    Given I proceed as the Admin
    And I am logged in under ORO Inc - Worldwide organization
    And go to System/ Lokalisierung/ Übersetzungen
    And filter "Schlüssel" as "Enthält" value "oro.order.po_number.label"
    And filter "Übersetzter Wert" as "Enthält" value "Bestellnummer"
    And edit "oro.order.po_number.label" Übersetzter Wert as "POBestellnummer" DE
    And click Ausloggen in user menu
    And I login as administrator
    When go to Vertrieb/ Bestellungen
    And filter "POBestellnummer" as "Enthält" value "P777155"
    When click "Löschen" "P777155" in grid
    And I click "Ja, löschen"
    Then should see "Bestellung gelöscht" flash message

    And go to System/ Konfiguration
    And follow "Handel/Lagerbestand/Produkt-Optionen" on configuration sidebar
    And fill "Product Option Form" with:
      | Backorders Default | true |
    And I click "Einstellungen speichern"
    Then I should see "Konfiguration gespeichert" flash message

    When go to Kunden/ Benutzer des Kunden
    And click "Löschen" "BrandaJSanborn1@example.org" in grid
    And click "Ja, löschen"
    Then should see "Benutzer des Kunden gelöscht" flash message

    When go to Produkte/ Produkte
    And I filter "Art.-Nr." as "Enthält" value "110_lumen_headlamp_e2e"
    And click "Löschen" "110_lumen_headlamp_e2e" in grid
    And click "Ja, löschen"
    Then I should see "Product deleted" flash message

    When go to System/ Versand Regeln
    And I filter "Name" as "Enthält" value "Flat Rate e2e"
    And click "Löschen" "Flat Rate e2e" in grid
    And click "Ja, löschen"
    Then I should see "Versandregel gelöscht"

    When go to System/ Zahlungsregeln
    And I filter "Name" as "Enthält" value "Payment Terms e2e"
    And click "Löschen" "Payment Terms e2e" in grid
    And click "Ja, löschen"
    Then I should see "Zahlungsregel gelöscht"

    When go to System/ Integrationen/ Integrationen verwalten
    And I filter "Name" as "Enthält" value "Flat Rate e2e"
    And click "Löschen" "Flat Rate e2e" in grid
    And click "Ja"
    Then I should see "Integration wurde erfolgreich gelöscht"

    When go to System/ Integrationen/ Integrationen verwalten
    And I filter "Name" as "Enthält" value "Payment Terms e2e"
    And click "Löschen" "Payment Terms e2e" in grid
    And click "Ja"
    Then I should see "Integration wurde erfolgreich gelöscht"

    When go to Vertrieb/ Zahlungsbedingungen
    And click "Löschen" "net_10_e2e" in grid
    And click "Ja"
    Then should see "Zahlungsbedingung gelöscht" flash message

    When go to Kunden/ Konten
    And filter "Kontoname" as "Enthält" value "e2e Customer"
    And click "Löschen" "e2e Customer" in grid
    And click "Ja, löschen"
    Then should see "Element gelöscht" flash message

    # should be fixed in BB-15705
    When go to Kunden/ Kunden
    And click Bearbeiten "e2e Customer" in grid
    And I fill form with:
      | Name | deleted |
    And click "Speichern und schließen"
    Then should see "Account wurde gespeichert" flash message

#    When go to Customers/ Customers
#    And I click delete 'e2e Customer' in grid
#    And click "Ja, löschen"
#    Then should see "Customer deleted" flash message
