Feature: Bins
  As a user
  I want to manage bins

  Background:
    Given I am not authenticated
    And   I am a new, authenticated user
    And   the following bins exists:
      | name                   | active |
      | Truck #1, top shelf    | false  |
      | Truck #1, middle shelf | false  |
      | Truck #1, bottom shelf | false  |
      | Truck #2, top shelf    | true   |
      | Truck #2, middle shelf | true   |
      | Truck #2, bottom shelf | true   |
    And   a donor exists with a name of "Brice Stacey"
    And   the following books exists:
      | title               | bin                          | recommendation | donor              |
      | Walden              | name: Truck #2, top shelf    | undecided      | name: Brice Stacey |
      | AWOCAMR             | name: Truck #2, top shelf    | undecided      | name: Brice Stacey |
      | The Cat and the Hat | name: Truck #2, middle shelf | trash          | name: Brice Stacey |
      | Green Eggs and Ham  | name: Truck #2, middle shelf | trash          | name: Brice Stacey |
      | SICP                | name: Truck #1, top shelf    | keep           | name: Brice Stacey |
      | CRLS                | name: Truck #1, top shelf    | keep           | name: Brice Stacey |
    And   I am on the home page
    And   I follow "Bins"

  # Index
  Scenario: The page should have a title, action items.
    Then I should see "Bins" within the title
    And  I should see an "Add Bin" action item

  Scenario: The index should have facets to change the faceting
    Then I should see an "Active (3)" facet is selected
    Then I should see an "Inactive (3)" facet

  Scenario: The default facet should be the active bins
    Then I should see the following bins:
      | name                   | total | undecided | keep | trash |
      | Truck #2, top shelf    | 2     | 2         | 0    | 0     |
      | Truck #2, middle shelf | 2     | 0         | 0    | 2     |
      | Truck #2, bottom shelf | 0     | 0         | 0    | 0     |
    And  I should not see "Truck #1, top shelf"
    And  I should not see "Truck #1, middle shelf"
    And  I should not see "Truck #1, bottom shelf"

  Scenario: Viewing inactive bins
    When I follow "Inactive"
    Then I should see the following bins:
      | name                   | total | undecided | keep | trash |
      | Truck #1, top shelf    | 2     | 0         | 2    | 0     |
      | Truck #1, middle shelf | 0     | 0         | 0    | 0     |
      | Truck #1, bottom shelf | 0     | 0         | 0    | 0     |
    And  I should not see "Truck #2, top shelf"
    And  I should not see "Truck #2, middle shelf"
    And  I should not see "Truck #2, bottom shelf"

  Scenario: If there are too many bin, it should be paginated.
    Given 30 bins exist
    When  I follow "Bins"
    Then  I should see pagination

  # Show
  Scenario: Showing a bin
    When I follow "Show" within the bin "Truck #2, top shelf"
    Then I should see "Truck #2, top shelf" within the title
    And  I should see the following action items:
      | Edit Bin    |
      | Archive Bin |
    And  I should see 2 books were donated
    And  I should see 2 books are undecided
    And  I should see 0 books are keep
    And  I should see 0 books are trash

  # New
  Scenario: Adding a new bin
    When I follow "Add Bin"
    Then I should see "New Bin" within the title

  Scenario: Adding a new bin
    When I follow "Add Bin"
    And  I fill in "Name" with "Truck #3, top shelf"
    And  I press "Create Bin"
    Then I should see "You successfully added a bin."
    And  I should be on the page for the bin "Truck #3, top shelf"

  Scenario: Adding a new bin without a name
    When I follow "Add Bin"
    And  I fill in "Name" with ""
    And  I press "Create Bin"
    Then I should see "There was a problem adding the bin."

  # Edit
  Scenario: Standard layout for editing a bin
    When I follow "Edit" within the bin "Truck #2, top shelf"
    Then I should see "Edit Bin" within the title

  Scenario: Editing a bin
    When I follow "Edit" within the bin "Truck #2, top shelf"
    And  I fill in "Name" with "Truck #3, bottom shelf"
    And  I press "Update Bin"
    Then I should see "You successfully updated the bin."
    And  I should be on the page for the bin "Truck #3, bottom shelf"

  # Archive
  Scenario: Archiving a complete bin
    When I follow "Archive" within the bin "Truck #2, middle shelf"
    Then I should be on the bins page
    And  I should see "You successfully archived the bin."

  Scenario: Archiving an incomplete bin
    When I follow "Archive" within the bin "Truck #2, top shelf"
    Then I should be on the bins page
    And  I should see "You must make a decision on every book before archiving a bin."
