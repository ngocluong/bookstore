Given(/^I am a new user$/) do
  @user = build(:user)
end

Given(/^I am on the signup page$/) do
  visit new_user_registration_path
end

Given(/^I fill in the Sign up form with mismatched password$/) do
  fill_in "Password", with: @user.password
  fill_in "Password confirmation", with: "other_secret"
end

Given(/^I did not fill all the signup information$/) do
  # Do nothing here
end

Then(/^I should see the following errors$/) do |table|
  table.hashes.each do |hash|
    step "I should see \"#{hash['error']}\""
  end
end
