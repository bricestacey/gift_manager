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
    Then I should see "Donors" within the title
    And  I should see an "Add Donor" action item
    And  I should see the following breadcrumbs
      | text |
      | Home |

  Scenario: There should be a list of donors
    Then I should see "Anonymous"

  Scenario: If there are too many donors, paginate
    Given 30 donors exist
    When  I follow "Donors"
    Then  I should see pagination

  # Show
  Scenario: The page should have a proper layout
    When I follow "Show" within the donor "Anonymous"
    Then I should see "Anonymous" within the title
    And  I should see an "Edit" action item
    And  I should see the following breadcrumbs
      | text   |
      | Home   |
      | Donors |

  Scenario: Showing a particular donor
    When I follow "Show" within the donor "Anonymous"
    Then I should see "Contact Information"
    And  I should see "Anonymous"

  Scenario: I should see the number of books donated
    Given the following books exists:
      | donor_id | title | author  | recommendation |
      | 1        | SICP  | Abelson | undecided      |
      | 1        | TAOCP | Knuth   | keep           |
    When  I follow "Show" within the donor "Anonymous"
    Then  I should see "Books Donated"
    And   I should see 2 books were donated
    And   I should see 1 book is undecided
    And   I should see 1 book is keep
    And   I should see 0 books are trash

  # New
  Scenario: Adding a new donor
    When I follow "Add Donor"
    Then I should see "New Donor" within the title
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
    And  I should be on the page for the donor "Nathaniel Cranberry"

  Scenario: Adding a donor without a name
    When I follow "Add Donor"
    And  I press "Add Donor"
    Then I should see "There was a problem adding the donor."

  # Edit
  Scenario: Editing a donor
    When I follow "Edit" within the donor "Anonymous"
    Then I should see "Edit Donor" within the title
    And  I should see the following breadcrumbs
      | text         |
      | Home         |
      | Donors       |
      | Anonymous    |

  Scenario: Editing a donor
    When I follow "Edit" within the donor "Anonymous"
    When I fill in "Name" with "Brice Stacey"
    And  I press "Update Donor"
    Then I should see "You successfully updated the donor."
    And  I should be on the page for the donor "Brice Stacey"

  # Delete
  Scenario: Deleting a donor
    When I follow "Delete" within the donor "Anonymous"
    Then I should be on the donors page
    And  I should see "You successfully deleted the donor."
    And  I should be on the donors page
