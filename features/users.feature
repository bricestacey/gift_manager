Feature: Users
  As a user
  I want to manage users

  Background:
    Given the following users exists:
      | id | email             |
      | 1  | user1@example.com |
      | 2  | user2@example.com |
      | 3  | user3@example.com |
      | 4  | user4@example.com |
      | 5  | user5@example.com |
    And   I am not authenticated
    And   I am a new, authenticated user
    And   I am on the home page
    And   I follow "Users"

  Scenario: The page should have the proper standard layout
    Then I should see the title "Users"
    Then I should see an "Add User" action item
    Then I should see the following breadcrumbs
      | text |
      | Home |

  # Index
  Scenario: There should be a list of users
    Then I should see "test@example.com"
    And  I should see "user1@example.com"
    And  I should see "user2@example.com"
    And  I should see "user3@example.com"
    And  I should see "user4@example.com"
    And  I should see "user5@example.com"

  Scenario: If there are too many users, paginate
    Given 30 users exist
    When  I follow "Users"
    Then  I should see "1"
    Then  I should see "2"
    Then  I should see "Next"
    Then  I should see "Last"

  # Show
  Scenario: Showing a particular user
    When I follow "Show" within ".user-1"
    Then I should be on the page for user 1
    And  I should see "User Information"
    And  I should see "user1@example.com"
    And  I should see a "Edit User" action item
    And  I should see a "Delete User" action item
    And  I should see the following breadcrumbs
      | text  |
      | Home  |
      | Users |

  # New
  Scenario: Adding a new user
    When I follow "Add User"
    Then I should see the title "New User"
    Then I should see the following breadcrumbs
      | text  |
      | Home  |
      | Users |

  Scenario: Adding a user
    When I follow "Add User"
    And  I fill in "Email" with "student@example.com"
    And  I fill in "Password" with "secret"
    And  I fill in "Password confirmation" with "secret"
    And  I press "Add User"
    Then I should see "You successfully added a user."
    And  I should be on the page for user 7
    And  I should see "student@example.com"

  # Edit
  Scenario: Editing a user
    When I follow "Edit" within ".user-2"
    Then I should see the title "Edit User"
    When I fill in "Password" with "newsecret"
    And  I fill in "Password confirmation" with "newsecret"
    And  I press "Update User"
    Then I should see "You successfully updated the user."
    And  I should be on the page for user 2

  # Delete
  Scenario: Deleting a user
    When I follow "Delete" within ".user-2"
    Then I should be on the users page
    And  I should see "You successfully deleted the user."
