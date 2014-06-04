Given(/^I already logged in$/) do
  @user_password = 'password'
  @user = create :confirm_user, password: @user_password
  @new_user_information = attributes_for :user
  login_as @user, scope: :user
end

Given(/^I am on edit user information page$/) do
  visit edit_user_registration_path
end

When(/^I fill in the Edit page with valid details and new email address$/) do
  step "I fill in \"Email\" with \"#{@new_user_information[:email]}\""
  step "I fill in \"Current password\" with \"#{@user_password}\""
end

Then(/^I should verify my email$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should updated my email$/) do
  @updated_user = User.find_by_id(@user.id)
  expect(@updated_user.email).to eq(@valid_user.email)
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

Then(/^I should receive an confirmation email$/) do
  expect(unread_emails_for(@new_user_information[:email]).first.subject).to eq 'Confirmation instructions'
end

Then(/^I click on the confirmation link$/) do
  open_email(@new_user_information[:email])
  click_first_link_in_email
end

Then(/^My email is updated$/) do
  expect(@user.reload.email).to eq @new_user_information[:email]
end
