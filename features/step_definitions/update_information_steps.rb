Given(/^I already logged in$/) do
  @user = create(:confirm_user)
  @valid_user = build(:user)
  step "I am on the Signin page"
  step "I fill in \"Email\" with \"#{@user.email}\""
  step "I fill in \"user_password\" with \"#{@user.password}\""
  step "I press \"Sign in\""
end

Given(/^I am on edit user information page$/) do
  visit edit_user_registration_path
end

When(/^I fill in the Edit page with valid details and new email address$/) do
  step "I fill in \"Email\" with \"#{@valid_user.email}\""
  step "I fill in \"Current password\" with \"#{@user.password}\""
end

Then(/^I should updated my email$/) do
  @updated_user = User.last
    expect(@updated_user.send(email)).to eq(@valid_user.send(email))
end

When(/^I fill in the Edit page with new details$/) do
  step "I fill in \"Full name\" with \"#{@valid_user.full_name}\""
  step "I fill in \"Phone\" with \"#{@valid_user.phone}\""
  step "I fill in \"Birthday\" with \"#{@valid_user.birthday}\""
  step "I fill in \"Current password\" with \"#{@user.password}\""
end

Then(/^I should updated my details$/) do
  @updated_user = User.last
  [:full_name, :phone, :birthday].each do |attr|
    expect(@updated_user.send(attr)).to eq(@valid_user.send(attr))
  end
end

When(/^I fill in the Edit page with new password$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should updated my password$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I fill in the Edit page with invalid phone format$/) do
  pending # express the regexp above with the code you wish you had
end
