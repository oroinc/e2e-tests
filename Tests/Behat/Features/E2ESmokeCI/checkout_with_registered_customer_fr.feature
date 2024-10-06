@e2esmoke_fr_ci
Feature: Checkout with registered customer FR

  Scenario: Create different window session
    Given sessions active:
      | Admin | first_session  |
      | User  | second_session |

  Scenario: Precondition
    Given I proceed as the Admin
    And I login as administrator
    And go to Système/ Configuration
    And follow "Commerce/Stock/Options du Produit" on configuration sidebar
    And fill "Product Option Form" with:
      | Backorders Default | false |
      | Réassorts          | Oui   |
    And I click "Sauvegarder les paramètres"
    Then I should see "Configuration sauvegardée" flash message

  Scenario: Create Payment Term, Customer, Customer User and product
    When go to Ventes/ Conditions de paiement
    And click "Créer Condition de Paiement"
    And type "net_10_e2e" in "Libellé"
    And click "Enregistrer et Fermer"

    When go to Clients/ Clients
    And click "Créer Client"
    And fill "Customer Form" with:
      | Nom                  | e2e Customer       |
      | Price List            | Default Price List |
      | Condition de Paiement | net_10_e2e         |
    And click "Enregistrer et Fermer"
    Then should see "Le client a été sauvegardé" flash message

    When go to Clients/ Utilisateurs Clien
    And click "Créer Utilisateur Client"
    And fill form with:
      | Prénom         | Branda                      |
      | Nom de famille | Sanborn e2e                 |
      | Adresse e-mail | BrandaJSanborn1@example.org |
    And I focus on "Date de Naissance" field
    And click "Aujourd'hui"
    And fill form with:
      | Mot de passe              | BrandaJSanborn1@example.org |
      | Confirmez le Mot de passe | BrandaJSanborn1@example.org |
      | Client                    | e2e Customer                |
      | Buyer (Prédéfini)         | true                        |
    And fill "Customer User Addresses Form" with:
      | Principal              | true          |
      | First Name Add         | Branda        |
      | Last Name Add          | Sanborn e2e   |
      | Organisation           | e2e Org       |
      | Pays                   | États-Unis    |
      | Adresse                | Market St. 12 |
      | Ville                  | San Francisco |
      | État                   | Californie    |
      | Code postal            | 90001         |
      | Facturation            | true          |
      | Livraison              | true          |
      | Facturation par défaut | true          |
      | Livraison par défaut   | true          |

    And click "Enregistrer et Fermer"
    Then should see "L'utilisateur client a été sauvegardé" flash message

    When go to Produits/ Produits
    And click "Créer Produit"
    And fill form with:
      | Type | Simple |
    And click "Continuer"
    And fill "Create Product Form" with:
      | SKU               | 110_lumen_headlamp_e2e              |
      | Name              | 110 Lumen Rechargeable Headlamp e2e |
      | Status            | Activé                           |
      | Unit Of Quantity  | élément                             |
      | Description       | Product Description                 |
      | Short Description | Product_Short_Description           |
    And click "AddPrice"
    And fill "Product Price Form" with:
      | Price List | Default Price List |
      | Quantity   | 1                  |
      | Value      | 10,99              |
      | Currency   | €                  |
    And click "Enregistrer et Fermer"
    Then I should see "Le produit a été sauvegardé" flash message

  Scenario: Create payment and shipping integration
    Given go to Système/ Intégrations/ Gérer les Intégrations
    And click "Créer Intégration"
    And I fill "Integration Form" with:
      | Type  | Expédition à taux fixe |
      | Name  | Flat Rate e2e          |
      | Label | Flat_Rate_e2e          |
    And click "Enregistrer et Fermer"
    Then I should see "Intégration enregistrée" flash message
    When go to Système/ Intégrations/ Gérer les Intégrations
    And click "Créer Intégration"
    And I fill "Integration Form" with:
      | Type        | Conditions de Paiement |
      | Name        | Payment Terms e2e      |
      | Label       | Payment_Terms_e2e      |
      | Short Label | Payment Terms e2e      |
    And click "Enregistrer et Fermer"
    Then I should see "Intégration enregistrée" flash message

  Scenario: Create payment and shipping integration
    Given I go to Système/ Règles de livraison
    And click "Créer Règle de livraison"
    And fill "E2E Shipping Rule Form" with:
      | Activée      | true          |
      | Nom          | Flat Rate e2e |
      | Ordre de tri | 10            |
      | Devise       | €             |
      | Method       | Flat Rate e2e |
    And I click "Add Shipping Rule Method"
    And fill form with:
      | Prix | 10 |
    And click "Enregistrer et Fermer"
    Then should see "La règle de livraison a été sauvegardée" flash message
    When I go to Système/ Règles de paiement
    And click "Créer Règle de paiement"
    And fill "E2E Payment Rule Form" with:
      | Activée      | true              |
      | Nom          | Payment Terms e2e |
      | Ordre de tri | 1                 |
      | Devise       | €                 |
      | Method       | Payment Terms e2e |
    And I click "Add Payment Rule Method"
    When click "Enregistrer et Fermer"
    Then should see "La règle de paiement a été enregistrée" flash message

  Scenario:
    Given I proceed as the User
    And I am on the homepage
    And I click "Accept Cookie Banner" if present
    And I signed in as BrandaJSanborn1@example.org on the store frontend in old session
    When I hover on "Shopping Cart"
    And click "Créer une nouvelle liste"
    Then should see an "Create New Shopping List popup" element
    And type "e2e SL" in "Nom de Panier"
    And click "Créer"
    And should see "e2e SL"

    And I am on homepage
    And I type "110_lumen_headlamp_e2e" in "search"
    And I click "Search Button"
    And I click "110 Lumen Rechargeable Headlamp e2e"
    When I click "Add to e2e SL"
    Then I should see "Le produit a été ajouté à" flash message and I close it
    When I hover on "Shopping Cart"
    And click "e2e SL" on shopping list widget
    And click "Créer une commande"
    And I confirm Agreements "Terms and Conditions" at the checkout if they are not confirmed
    And I select "Branda Sanborn e2e, e2e Org, Market St. 12, SAN FRANCISCO CA US 90001" on the "Informations de facturation" checkout step and press "Continuer"
    And I select "Branda Sanborn e2e, e2e Org, Market St. 12, SAN FRANCISCO CA US 90001" on the "Informations de livraison" checkout step and press "Continuer"
    And I check "Flat_Rate_e2e" on the "Mode de livraison" checkout step and press "Continuer"
    And I check "Payment_Terms_e2e" on the "Paiement" checkout step and press "Continuer"
    And fill "Checkout Order Form" with:
      | PO Number | P777155 |
    When I check "Supprimer le panier après l'envoi de la commande" on the "Vérification de la commande" checkout step and press "Passer la commande"
    Then I see the "Thank You" page with "Merci pour votre commande !" title

  Scenario: Clear all data
    Given I proceed as the Admin
    And I login as administrator
    When go to Ventes/ Commandes
    And show column Numéro du bon de commande in grid
    And show filter "Numéro du bon de commande" in grid
    And filter "Numéro du bon de commande" as "Contient" value "P777155"
    When click "Supprimer" "P777155" in grid
    And I click "Oui, Supprimer"
    Then should see "Commande supprimé" flash message

    And go to Système/ Configuration
    And follow "Commerce/Stock/Options du Produit" on configuration sidebar
    And fill "Product Option Form" with:
      | Backorders Default | true |
    And I click "Sauvegarder les paramètres"
    Then I should see "Configuration sauvegardée" flash message

    When go to Clients/ Utilisateurs Client
    And click "Supprimer" "BrandaJSanborn1@example.org" in grid
    And click "Oui, Supprimer"
    Then should see "Utilisateur Client supprimé" flash message

    When go to Produits/ Produits
    And I filter "SKU" as "Contient" value "110_lumen_headlamp_e2e"
    And click "Supprimer" "110_lumen_headlamp_e2e" in grid
    And click "Oui, supprimer"
    Then I should see "Product deleted"

    When go to Système/ Règles de livraison
    And I filter "Nom" as "Contient" value "Flat Rate e2e"
    And click "Supprimer" "Flat Rate e2e" in grid
    And click "Oui, Supprimer"
    Then I should see "Règle de livraison supprimé"

    When go to Système/ Règles de paiement
    And I filter "Nom" as "Contient" value "Payment Terms e2e"
    And click "Supprimer" "Payment Terms e2e" in grid
    And click "Oui, Supprimer"
    Then I should see "Règle de paiement supprimé"

    When go to Système/ Intégrations/ Gérer les Intégrations
    And I filter "Nom" as "Contient" value "Flat Rate e2e"
    And click "Supprimer" "Flat Rate e2e" in grid
    And click "Oui"
    Then I should see "L'intégration a été supprimée avec succès"

    When go to Système/ Intégrations/ Gérer les Intégrations
    And I filter "Nom" as "Contient" value "Payment Terms e2e"
    And click "Supprimer" "Payment Terms e2e" in grid
    And click "Oui"
    Then I should see "L'intégration a été supprimée avec succès"

    When go to Ventes/ Conditions de paiement
    And click "Supprimer" "net_10_e2e" in grid
    And click "Oui"
    Then should see "Condition de Paiement supprimé" flash message

    When go to Clients/ Comptes
    And filter "Nom du compte" as "Contient" value "e2e Customer"
    And click "Supprimer" "e2e Customer" in grid
    And click "Oui, supprimer"
    Then should see "Élément supprimé" flash message

    # should be fixed in BB-15705
    When go to Clients/ Clients
    And click Modifier "e2e Customer" in grid
    And I fill form with:
      | Nom | deleted |
    And click "Enregistrer et Fermer"
    Then should see "Le client a été sauvegardé" flash message

#    When go to Customers/ Customers
#    And I click delete 'e2e Customer' in grid
#    And click "Oui, Supprimer"
#    Then should see "Customer deleted" flash message
