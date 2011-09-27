Feature: Donors
  As a user
  I want to manage donors

  Background:
    Given I am not authenticated
    And   I am a new, authenticated user
    And   a donor exists
    And   I am on the home page
    And   I follow "Donors"

  # Index
  Scenario: The page should have a title
    Then I should see the title "Donors"
    And  I should see an "Add Donor" action item
    And  I should see the following breadcrumbs
      | text |
      | Home |

  Scenario: There should be a list of donors
    Then I should see "Anonymous"

  Scenario: If there are too many donors, paginate
    Given 30 donors exist
    When  I follow "Donors"
    Then  I should see "1"
    Then  I should see "2"
    Then  I should see "Next"
    Then  I should see "Last"

  # Show
  Scenario: The page should have a proper layout
    When I follow "Show" within ".donor-1"
    Then I should see the title "Anonymous"
    And  I should see an "Edit" action item
    And  I should see the following breadcrumbs
      | text   |
      | Home   |
      | Donors |

  Scenario: Showing a particular donor
    When I follow "Show" within ".donor-1"
    Then I should see "Contact Information"
    And  I should see "Anonymous"

  Scenario: I should see the number of books donated
    Given the following books exists:
      | donor_id | title | author  | recommendation |
      | 1        | SICP  | Abelson | undecided      |
      | 1        | TAOCP | Knuth   | keep           |
    When  I follow "Show" within ".donor-1"
    Then  I should see "Books Donated"
    And   I should see "2" within ".books-donated"
    And   I should see "Undecided Books"
    And   I should see "1" within ".books-undecided"
    And   I should see "Books Kept"
    And   I should see "1" within ".books-keep"
    And   I should see "Books Trashed"
    And   I should see "0" within ".books-trash"

  # Donor::Books
  Scenario: Looking up the number of books trashed for a given donor 
    Given the following books exists:
      | donor_id | title | author  | recommendation |
      | 1        | SICP  | Abelson | undecided      |
      | 1        | TAOCP | Knuth   | trash          |
      | 1        | ALGO  | CLRS    | trash          |
    When  I follow "Show" within ".donor-1"
    And   I follow "2" within ".books-trash"
    Then  I should see "TAOCP"
    And   I should see "ALGO"
    And   I should not see "SICP"

  # New
  Scenario: Adding a new donor
    When I follow "Add Donor"
    Then I should see the title "New Donor"
    And  I should see the following breadcrumbs
      | text   |
      | Home   |
      | Donors |

  Scenario: Adding a new donor
    When I follow "Add Donor"
    When I fill in the following:
      | Name           | Nathaniel Cranberry                |
      | Phone          | 6175555555                         |
      | Email          | example@umb.edu                    |
      | Address Line 1 | Healey Library                     |
      | Address Line 2 | University of Massachusetts Boston |
      | City           | Boston                             |
      | State          | MA                                 |
      | Zip Code       | 02125                              |
    And  I press "Add Donor"
    Then I should see "You successfully added a donor"
    And  I should see "Nathaniel Cranberry"

  Scenario: Adding a donor without a name
    When I follow "Add Donor"
    And  I press "Add Donor"
    Then I should see "There was a problem adding the donor."

  # Edit
  Scenario: Editing a donor
    When I follow "Edit" within ".donor-1"
    Then I should see the title "Edit Donor"
    And  I should see the following breadcrumbs
      | text         |
      | Home         |
      | Donors       |
      | Anonymous    |

  Scenario: Editing a donor
    When I follow "Edit" within ".donor-1"
    When I fill in "Name" with "Brice Stacey"
    And  I press "Update Donor"
    Then I should see "You successfully updated the donor."
    And  I should see "Brice Stacey"

  # Delete
  Scenario: Deleting a donor
    When I follow "Delete" within ".donor-1"
    Then I should be on the donors page
    And  I should see "You successfully deleted the donor."
