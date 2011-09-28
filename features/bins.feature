Feature: Bins
  As a user
  I want to manage bins

  Background:
    Given I am not authenticated
    And   I am a new, authenticated user
    And   the following bins exists:
      | name                   | active | id |
      | Truck #1, top shelf    | false  | 1  |
      | Truck #1, middle shelf | false  | 2  |
      | Truck #1, bottom shelf | false  | 3  |
      | Truck #2, top shelf    | true   | 4  |
      | Truck #2, middle shelf | true   | 5  |
      | Truck #2, bottom shelf | true   | 6  |
    And the following donors exists:
      | id | name         |
      | 1  | Brice Stacey |
    And the following books exists:
      | title               | bin_id | recommendation | donor_id |
      | Walden              | 4      | undecided      | 1        |
      | AWOCAMR             | 4      | undecided      | 1        |
      | The Cat and the Hat | 5      | trash          | 1        |
      | Green Eggs and Ham  | 5      | trash          | 1        |
      | SICP                | 1      | keep           | 1        |
      | CRLS                | 1      | keep           | 1        |
    And   I am on the home page
    And   I follow "Bins"

  # Index
  Scenario: The page should have a title, action items, and breadcrumbs.
    Then I should see "Bins" within the title
    And  I should see an "Add Bin" action item
    And  I should see the following breadcrumbs
      | text |
      | Home |

  Scenario: There should be links to change scope
    Then I should see an "Active (3)" facet is selected
    Then I should see an "Inactive (3)" facet

  Scenario: The default scope should be the active bins
    Then I should see "Truck #2, top shelf"
    And  I should see "Truck #2, middle shelf"
    And  I should see "Truck #2, bottom shelf"
    And  I should not see "Truck #1, top shelf"
    And  I should not see "Truck #1, middle shelf"
    And  I should not see "Truck #1, bottom shelf"

  Scenario: Viewing inactive bins
    When I follow "Inactive"
    Then I should see "Truck #1, top shelf"
    And  I should see "Truck #1, middle shelf"
    And  I should see "Truck #1, bottom shelf"
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
    And  I should see an "Edit Bin" action item
    And  I should see an "Archive Bin" action item
    And  I should see the following breadcrumbs
      | text |
      | Home |
      | Bins |

  # New
  Scenario: Adding a new bin
    When I follow "Add Bin"
    Then I should see "New Bin" within the title
    And  I should see the following breadcrumbs
      | text |
      | Home |
      | Bins |

  Scenario: Adding a new bin
    When I follow "Add Bin"
    And  I fill in "Name" with "Truck #3, top shelf"
    And  I press "Add Bin"
    And  I should see "You successfully added a bin."
    And  I should be on the page for the bin "Truck #3, top shelf"

  Scenario: Adding a new bin without a name
    When I follow "Add Bin"
    And  I fill in "Name" with ""
    And  I press "Add Bin"
    Then I should see "can't be blank" within "#bin_name_input"

  # Edit
  Scenario: Standard layout for editing a bin
    When I follow "Edit" within ".bin-5"
    Then I should see "Edit Bin" within the title
    And  I should see the following breadcrumbs
      | text |
      | Home |
      | Bins |

  Scenario: Editing a bin
    When I follow "Edit" within the bin "Truck #2, top shelf"
    And  I fill in "Name" with "Truck #3, bottom shelf"
    And  I press "Update Bin"
    Then I should see "You successfully updated the bin."
    And  I should be on the page for the bin "Truck #3, bottom shelf"

  # Archive
  Scenario: Archiving a complete bin
    When I follow "Archive" within ".bin-5"
    Then I should be on the bins page
    And  I should see "You successfully archived the bin."

  Scenario: Archiving an incomplete bin
    When I follow "Archive" within ".bin-4"
    Then I should be on the bins page
    And  I should see "You must make a decision on every book before archiving a bin."
