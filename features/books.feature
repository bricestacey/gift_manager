Feature: Books
  As a user
  I want to manage books

  Background:
    Given I am not authenticated
    And   I am a new, authenticated user
    And   A donor exists with a name of "Anonymous"
    And   A bin exists with a name of "Top Shelf"
    And   the following books exists:
      | title       | author  | published | publisher      | recommendation | donor           | bin             |
      | Walden      | Thoreau | 1854      | foo            | undecided      | name: Anonymous | name: Top Shelf |
      | AWOCAMR     | Thoreau | 1849      | bar            | keep           | name: Anonymous | name: Top Shelf |
    And   I am on the home page
    And   I follow "Books"

  Scenario: The page should have the proper standard layout
    Then I should see "Books" within the title
    Then I should see an "Add Book" action item
    Then I should see the following breadcrumbs
      | text |
      | Home |

  # Index
  Scenario: There should be a list of books
    Then I should see the following books:
      | title       | author  | published | publisher |
      | Walden      | Thoreau | 1854      | foo       |
      | AWOCAMR     | Thoreau | 1849      | bar       |

  Scenario: There should be options to facet the table
    Then I should see an "All" facet is selected
    And  I should see an "Undecided" facet
    And  I should see a "Keep" facet
    And  I should see a "Trash" facet
    And  I should see a "Sell" facet

  Scenario: If there are too many books, paginate
    Given 30 books exist
    When  I follow "Books"
    Then  I should see pagination

  @javascript
  Scenario: Can select multiple books and change their recommendation
    When I select the book "Walden"
    And  I select the book "AWOCAMR"
    And  I select "Trash" from "book[recommendation]"
    Then I should be on the books page
    And  I should see "You have successfully changed the recommendations."
    And  I should see the book "Walden" has the "trash" recommendation
    And  I should see the book "AWOCAMR" has the "trash" recommendation

  # Show
  Scenario: Showing a particular book
    When I show the book "Walden"
    Then I should be on the page for the book with title "Walden"
    And  I should see "Walden" within the title
    And  I should see the following action items:
      | Edit      |
      | Undecided |
      | Keep      |
      | Trash     |
      | Sell      |
    And  I should see the following breadcrumbs
      | text  |
      | Home  |
      | Books |
    And  I should see the following book details:
      | title       | author  | published | publisher |
      | Walden      | Thoreau | 1854      | foo       |

  Scenario Outline: Making a recommendation on a book
    When I show the book "Walden"
    And  I follow "<recommendation>"
    Then I should be on the page for the book with title "Walden"
    And  I should see "The book's recommendation has been updated to: <recommendation>."

    Examples:
      | recommendation |
      | Keep           |
      | Trash          |
      | Sell           |
      | Undecided      |

  # New
  Scenario: Adding a new book
    When I follow "Add Book"
    Then I should see "New Book" within the title
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
    And  I should be on the page for the book with isbn "1557094179"

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
    Then I should be on the page for the book with isbn "047210330x"
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
    When I follow "Edit" within the book with title "AWOCAMR"
    Then I should see "Edit Book" within the title
    When I fill in "Title" with "A Week on the Concord and Merrimack Rivers"
    And  I press "Update Book"
    Then I should see "You successfully updated the book."
    And  I should be on the page for the book with title "A Week on the Concord and Merrimack Rivers"
    And  I should see "A Week on the Concord and Merrimack Rivers"

  # Delete
  Scenario: Deleting a book
    When I follow "Delete" within the book with title "Walden"
    Then I should be on the books page
    And  I should see "You successfully deleted the book."
