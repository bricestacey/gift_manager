Feature: Users
  As a user
  I want to manage users

  Background:
    Given the following users exists:
      | email             |
      | user1@example.com |
      | user2@example.com |
      | user3@example.com |
      | user4@example.com |
      | user5@example.com |
    And   I am not authenticated
    And   I am a new, authenticated user
    And   I am on the home page
    And   I follow "Users"

  Scenario: The page should have the proper standard layout
    Then I should see "Users" within the title
    Then I should see an "Add User" action item

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
    Then  I should see pagination

  # Show
  Scenario: Showing a particular user
    When I follow "Show" within the user "user1@example.com"
    Then I should be on the page for the user "user1@example.com"
    And  I should see "User Information"
    And  I should see "user1@example.com"
    And  I should see the following action items:
      | Edit User   |
      | Delete User |

  # New
  Scenario: Adding a new user
    When I follow "Add User"
    Then I should see "New User" within the title

  Scenario: Adding a user
    When I follow "Add User"
    And  I fill in "Email" with "student@example.com"
    And  I fill in "Password" with "secret"
    And  I fill in "Password confirmation" with "secret"
    And  I press "Create User"
    Then I should see "You successfully added a user."
    And  I should be on the page for the user "student@example.com"

  # Edit
  Scenario: Editing a user
    When I follow "Edit" within the user "user2@example.com"
    Then I should see "Edit User" within the title
    When I fill in "Password" with "newsecret"
    And  I fill in "Password confirmation" with "newsecret"
    And  I press "Update User"
    Then I should see "You successfully updated the user."
    And  I should be on the page for the user "user2@example.com"

  # Delete
  Scenario: Deleting a user
    When I follow "Delete" within the user "user3@example.com"
    Then I should see "You successfully deleted the user."
    And  I should be on the users page
