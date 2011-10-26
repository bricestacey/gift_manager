Given /^a user is not logged in$/ do
  visit "/users/signout"
end

Given /^I am not authenticated$/ do
  visit('/users/signout') # ensure that at least
end

Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  User.create(email: email, password: password, password_confirmation: password)
end

Given /^I am a new, authenticated user$/ do
  email = 'test@example.com'
  password = 'secret'

  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end
