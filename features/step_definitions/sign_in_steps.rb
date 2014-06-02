Given(/^I already have an account$/) do
  @user = create(:confirm_user)
  @unconfirm_user = create(:user)
end

Given(/^I am on the Signin page$/) do
  visit new_user_session_path
end

When(/^I fill in the Sign in page with valid details$/) do
  step "I fill in \"Email\" with \"#{@user.email}\""
  step "I fill in \"user_password\" with \"#{@user.password}\""
end

When(/^I fill in the Sign in form with uncomfirmation account$/) do
  step "I fill in \"Email\" with \"#{@unconfirm_user.email}\""
  step "I fill in \"user_password\" with \"#{@unconfirm_user.password}\""
end

When(/^I fill in the Sign in form with incorrect password$/) do
  step "I fill in \"Email\" with \"#{@user.email}\""
  step "I fill in \"user_password\" with \"abc\""
end


