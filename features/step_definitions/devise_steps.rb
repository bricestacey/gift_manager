Given /^I am signed in as "(.*)"$/ do |login|
  @current_user = User.create!(
    :email => login,
    :password => 'secret',
    :password_confirmation => 'secret',
  )

  visit "/users/signin"
  fill_in("Email", :with => @current_user.email)
  fill_in("Password", :with => @current_user.password)
  click_button("Sign in")
end

Given /^a user is not logged in$/ do
  visit "/users/signout"
end

