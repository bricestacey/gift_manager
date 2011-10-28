Feature: Pull book info from local ILS (Voyager)
  As a user
  I want to add books ISBN and pull info from local ILS
  So that I can make a better recommendation for each book

  Background:
    Given I am a new, authenticated user
    And   a donor exists
    And   a bin exists
    And   I am on the home page
    And   I follow "Books"
    And   I follow "Add Book"

  Scenario: Add a book that is locally held with at least one circulation
    When I fill in "ISBN" with the ISBN of a book with at least one circulation
    And  I select "Anonymous" from "Donor"
    And  I select "Top Shelf" from "Bin"
    And  I press "Create Book"
    Then I should see that there is at least one copy
    And  I should see that there is at least one circulation

  Scenario: Add a book that is locally held that hasn't circulated
    When I fill in "ISBN" with the ISBN of a book without a circulation
    And  I select "Anonymous" from "Donor"
    And  I select "Top Shelf" from "Bin"
    And  I press "Create Book"
    Then I should see that there is at least one copy
    And  I should see that it has not circulated
