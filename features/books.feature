Feature: Books
  As a user
  I want to manage books

  Background:
    Given I am not authenticated
    And   I am a new, authenticated user
    And   the following books exists:
      | title   | author  | recommendation |
      | Walden  | Thoreau | undecided      |
      | AWOCAMR | Thoreau | keep           |
    And   I am on the home page
    And   I follow "Books"

  Scenario: The page should have the proper standard layout
    Then I should see the title "Books"
    Then I should see an "Add Book" action item
    Then I should see the following breadcrumbs
      | text |
      | Home |

  # Index
  Scenario: There should be a list of books
    Then I should see "Walden"
    And  I should see "AWOCAMR"

  Scenario: There should be options to scope the table
  Scenario: The default scope should be 'All'

  Scenario: If there are too many books, paginate
    Given 30 books exist
    When  I follow "Books"
    Then  I should see "1"
    Then  I should see "2"
    Then  I should see "Next"
    Then  I should see "Last"

  # Show
  Scenario: Showing a particular book
    When I follow "Show" within ".book-1"
    Then I should be on the page for book 1
    And  I should see the title "Walden"
    And  I should see an "Edit" action item
    And  I should see an "Undecided" action item
    And  I should see a "Keep" action item
    And  I should see a "Trash" action item
    And  I should see the following breadcrumbs
      | text  |
      | Home  |
      | Books |

  # New
  Scenario: Adding a new book
    When I follow "Add Book"
    Then I should see the title "New Book"
    Then I should see the following breadcrumbs
      | text  |
      | Home  |
      | Books |

  Scenario: Adding a book
    When I follow "Add Book"
    And  I fill in "ISBN" with "1557094179"
    And  I select "Anonymous" from "Donor"
    And  I select "Top Shelf" from "Bin"
    And  I press "Add Book"
    Then I should see "You successfully added a book"
    And  I should be on the page for book 3
    And  I should see "On the duty of civil disobedience"

  Scenario: Adding a book without a donor
    When I follow "Add Book"
    And  I fill in "ISBN" with "1557094179"
    And  I press "Add Book"
    Then I should see "can't be blank"

  Scenario: Adding a book that has no thumbnail in Amazon
    When I follow "Add Book"
    And  I fill in "ISBN" with "047210330x"
    And  I select "Anonymous" from "Donor"
    And  I select "Top Shelf" from "Bin"
    And  I press "Add Book"
    Then I should be on the book details for ISBN 047210330x
    And  I should see "No thumbnail"

  # Covers issue #2. OCLC web service would return the soundtrack for The
  # Social Network if the ISBN was left blank.
  Scenario: Adding a book without providing an ISBN
    When I follow "Add Book"
    And  I fill in the following:
      | ISBN   |                               |
      | Title  | Crooked Letter Crooked Letter |
      | Author | Franklin, Tom                 |
    And  I select "Anonymous" from "Donor"
    And  I select "Top Shelf" from "Bin"
    And  I press "Add Book"
    Then I should be on the latest book's details
    And  I should see "Crooked Letter Crooked Letter"
    And  I should see "Franklin, Tom"
    And  I should not see "The social network"

  # Edit
  Scenario: Editing a book
    When I follow "Edit" within ".book-2"
    Then I should see the title "Edit Book"
    When I fill in "Title" with "A Week on the Concord and Merrimack Rivers"
    And  I press "Update Book"
    Then I should see "You successfully updated the book."
    And  I should see "A Week on the Concord and Merrimack Rivers"

  # Delete
  Scenario: Deleting a book
    When I follow "Delete" within ".book-1"
    Then I should be on the books page
    And  I should see "You successfully deleted the book."
