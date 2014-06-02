Given(/^I am a new user$/) do
  @user = build(:user)
end

Given(/^I am on the signup page$/) do
  visit new_user_registration_path
end

Given(/^I fill in the Sign up form with mismatched password$/) do
  step "I fill in \"user_password\" with \"#{@user.password}\""
  step "I fill in \"Password confirmation\" with \"other_secret\""
end

Given(/^I did not fill all the signup information$/) do
  # Do nothing here
end

When(/^I fill in the Sign up form with invalid email format$/) do
  step "I fill in \"Email\" with \"abc\""
end

When(/^I fill in the sign up form with invalid phone format$/) do
  step "I fill in \"user_password\" with \"something\""
end

When(/^I fill in the Sign up form with valid details$/) do
  step "I fill in \"Email\" with \"#{@user.email}\""
  step "I fill in \"user_password\" with \"#{@user.password}\""
  step "I fill in \"Password confirmation\" with \"#{@user.password}\""
  step "I fill in \"Full name\" with \"#{@user.full_name}\""
  step "I fill in \"Phone\" with \"#{@user.phone}\""
  step "I fill in \"Birthday\" with \"#{@user.birthday}\""
end

Then(/^I should be registed$/) do
  @new_user = User.last
  [:email, :full_name, :phone, :birthday].each do |attr|
    expect(@user.send(attr)).to eq(@new_user.send(attr))
  end
end

Then(/^I should received an confirmation email$/) do
  p ActionMailer::Base.deliveries.last
  expect ActionMailer::Base.deliveries.last.to eq(@user.email)
end
