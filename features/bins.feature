Feature: Bins
  As a user
  I want to manage bins

  Background:
    Given the following bins exists:
      | name                   | active | id |
      | Truck #1, top shelf    | false  | 1  |
      | Truck #1, middle shelf | false  | 2  |
      | Truck #1, bottom shelf | false  | 3  |
      | Truck #2, top shelf    | true   | 4  |
      | Truck #2, middle shelf | true   | 5  |
      | Truck #2, bottom shelf | true   | 6  |
      | Truck #3, top shelf    | true   | 7  |
    And the following donors exists:
      | id | name         |
      | 1  | Brice Stacey |
    And the following books exists:
      | title               | bin_id | recommendation | donor_id |
      | Walden              | 4      | undecided      | 1        |
      | AWOCAMR             | 4      | undecided      | 1        |
      | The Cat and the Hat | 5      | toss           | 1        |
      | Green Eggs and Ham  | 5      | toss           | 1        |
      | SICP                | 1      | keep           | 1        |
      | CRLS                | 1      | keep           | 1        |
    And   I am on the home page
    And   I follow "Bins"

  # Index
  Scenario: The page title should be Bins
    Then I should see "Bins" within "title"

  Scenario: There should be breadcrumbs
    Then I should see "Home" within ".breadcrumb"

  Scenario: There should be action items to add a new bin
    Then I should see "Add Bin" within ".action_items"

  Scenario: There should be links to change scope
    Then I should see "Active (4)"
    Then I should see "Inactive (3)"

  Scenario: The default scope should be the active bins
    Then I should see "Truck #2, top shelf"
    And  I should see "Truck #2, middle shelf"
    And  I should see "Truck #2, bottom shelf"

  Scenario: Viewing inactive bins
    When I follow "Inactive"
    Then I should see "Truck #1, top shelf"
    And  I should see "Truck #1, middle shelf"
    And  I should see "Truck #1, bottom shelf"

  # New
  Scenario: Adding a new bin
    When I follow "Add Bin"
    And  I fill in "Name" with "Truck #3, top shelf"
    And  I press "Create Bin"
    And  I should see "You successfully created a bin."

  Scenario: Adding a new bin without a name
    When I follow "Add Bin"
    And  I fill in "Name" with ""
    And  I press "Create Bin"
    Then I should see "can't be blank" within "#bin_name_input"

  # Edit
  Scenario: Editing a bin
    When I follow "Edit" within ".bin-5"
    And  I fill in "Name" with "Book truck #3, middle shelf"
    And  I press "Update Bin"
    Then I should see "You successfully updated the bin."

  # Archive
  Scenario: Archiving a complete bin
    When I follow "Archive" within ".bin-5"
    Then I should be on the bins page
    And  I should see "You successfully archived the bin."

  Scenario: Archiving an incomplete bin
    When I follow "Archive" within ".bin-4"
    Then I should be on the bins page
    And  I should see "You must make a decision on every book before archiving a bin."

  # Show
  Scenario: The page title should be Truck #2, top shelf
    When I follow "Show" within ".bin-4"
    Then I should see "Truck #2, top shelf" within "title"

  Scenario: There should be breadcrumbs
    When I follow "Show" within ".bin-4"
    Then I should see "Home" within ".breadcrumb"
    And  I should see "Bins" within ".breadcrumb"

  Scenario: There should be action items to add a new book
    When I follow "Show" within ".bin-4"
    Then I should see "Edit Bin" within ".action_items"
    Then I should see "Archive Bin" within ".action_items"

  # Books
  Scenario: There should be links to change scope
    When I follow "Show" within ".bin-4"
    And  I follow "See all books" within ".sidebar"
    Then I should see "All (2)"
    Then I should see "Undecided (2)"
    Then I should see "Keep (0)"
    Then I should see "Toss (0)"

  Scenario: The default scope should be all the items
    When I follow "Show" within ".bin-4"
    And  I follow "See all books" within ".sidebar"
    Then I should see "Truck #2, top shelf"
    And  I should see "Walden"
    And  I should see "AWOCAMR"

  Scenario: Adding books to a bin
    When I follow "Show" within ".bin-4"
    And  I follow "See all books" within ".sidebar"
    And  I follow "Add Book"
    And  I fill in "ISBN" with "0201853922"
    And  I select "Brice Stacey" from "Donor"
    And  I press "Add Book"
    Then I should see "The art of computer programming"
    And  I should see "Knuth, Donald Ervin"

  Scenario: Editing a book in a bin
    When I follow "Show" within ".bin-4"
    And  I follow "See all books" within ".sidebar"
    And  I follow "Edit" within ".book-2"
    And  I fill in "Title" with "A week on the Concord and Merrimack Rivers"
    # I am not sure why I need to reselect a donor here...
    And  I select "Brice Stacey" from "Donor"
    And  I press "Update Book"
    Then I should see "You successfully updated the book."
    And  I should see "A week on the Concord and Merrimack Rivers"

  Scenario: Removing a book from a bin
    When I follow "Show" within ".bin-4"
    And  I follow "See all books" within ".sidebar"
    And  I follow "Remove" within ".book-2"
    Then I should see "You successfully removed the book."

  Scenario: Showing a book
    When I follow "Show" within ".bin-4"
    And  I follow "See all books" within ".sidebar"
    And  I follow "Show" within ".book-1"
    Then I should see "Walden"
    Then I should see "Edit Book" within ".action_items"
    Then I should see "Keep" within ".action_items"
    Then I should see "Toss" within ".action_items"
    Then I should see "Undecided" within ".action_items"
