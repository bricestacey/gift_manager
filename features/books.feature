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
    And   I am signed in as "user@example.com"
    And   I am on the home page
    And   I follow "Books"

  # Index
  Scenario: The page should have a title
    Then I should see "Books" within "title"

  Scenario: The page should have breadcrumbs
    Then I should see "Home" within ".breadcrumb"

  Scenario: The page should have action items
    Then I should see "Add Book" within ".action_items"

  Scenario: There should be links to change scope
    Then I should see "All (6)"
    Then I should see "Undecided (2)"
    Then I should see "Keep (2)"
    Then I should see "Toss (2)"

  Scenario: The default scope should be all books
    Then I should see "Walden"
    And  I should see "AWOCAMR"
    And  I should see "The Cat and the Hat"
    And  I should see "Green Eggs and Ham"
    And  I should see "SICP"
    And  I should see "CRLS"

  Scenario: Viewing undecided books
    When I follow "Undecided"
    Then I should see "Walden"
    And  I should see "AWOCAMR"
    And  I should not see "The Cat and the Hat"
    And  I should not see "Green Eggs and Ham"
    And  I should not see "SICP"
    And  I should not see "CRLS"

  Scenario: Adding books to a bin
    When I follow "Add Book"
    And  I fill in "ISBN" with "0201853922"
    And  I select "Brice Stacey" from "Donor"
    # I am not sure why I need to reselect a donor here...
    And  I select "Truck #2, top shelf" from "Bin"
    And  I press "Add Book"
    Then I should see "The art of computer programming"
    And  I should see "Knuth, Donald Ervin"

  Scenario: Editing a book in a bin
    When I follow "Edit" within ".book-2"
    And  I fill in "Title" with "A week on the Concord and Merrimack Rivers"
    # I am not sure why I need to reselect a donor here...
    And  I select "Brice Stacey" from "Donor"
    And  I press "Update Book"
    Then I should see "You successfully updated the book."
    And  I should see "A week on the Concord and Merrimack Rivers"

  Scenario: Removing a book from a bin
    When I follow "Remove" within ".book-2"
    Then I should see "You successfully removed the book."

  Scenario: Showing a book
    When I follow "Show" within ".book-1"
    Then I should see "Walden"
    Then I should see "Edit Book" within ".action_items"
    Then I should see "Keep" within ".action_items"
    Then I should see "Toss" within ".action_items"
    Then I should see "Undecided" within ".action_items"
