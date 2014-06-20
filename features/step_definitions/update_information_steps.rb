Given(/^I already logged in$/) do
  @user_password = 'password'
  @user = create :confirm_user, password: @user_password
  @new_user_information = attributes_for :user
  login_as @user, scope: :user
end

Given(/^I am on edit user information page$/) do
  visit edit_user_registration_path
end

When(/^I change my email address$/) do
  step %{I fill in "Email" with "#{@new_user_information[:email]}"}
  step %{I fill in "Current password" with "#{@user_password}"}
  step %{I press "Update"}
end

When(/^I fill in the Edit page with my new details$/) do
  step %{I fill in "Full name" with "#{@new_user_information[:full_name]}"}
  step %{I fill in "Phone" with "#{@new_user_information[:phone]}"}
  step %{I fill in "Birthday" with "#{@new_user_information[:birthday]}"}
  step %{I fill in "Current password" with "#{@user_password}"}
  step %{I press "Update"}
end


Then(/^My account detail is updated$/) do
  expect(User).to be_exists(@new_user_information.slice('full_name', 'phone', 'birthday'))
end

When(/^I change my password$/) do
  step %{I fill in "Password" with "#{@new_user_information[:password]}"}
  step %{I fill in "Password confirmation" with "#{@new_user_information[:password]}"}
  step %{I fill in "Current password" with "#{@user_password}"}
  step %{I press "Update"}
end

Then(/^I sign out$/) do
  find('img.user-image').click
  within '.dropdown-menu' do
    step %{I press "Sign out"}
  end
end

Then(/^I can login with my new password$/) do
  step %{I sign out}
  step %{I am on the Signin page}
  step %{I fill in "Email" with "#{@user.email}"}
  step %{I fill in "user_password" with "#{@new_user_information[:password]}"}
  step %{I press "Sign in"}
  step %{I should see the following messages}, table(%{
     |messages              |
     |Signed in successfully|
   })
  step %{I should see element "#{user_p}"}
end

When(/^I fill in the Edit page with invalid phone format$/) do
  step %{I fill in "Phone" with "121-aa1-a111"}
  step %{I fill in "Current password" with "#{@user_password}"}
  step %{I press "Update"}
end

Then(/^I should receive an confirmation email$/) do
  wait_until do
    unread_emails_for(@new_user_information.email).present?
  end
  expect(unread_emails_for(@new_user_information[:email]).first.subject).to eq 'Confirmation instructions'
end

When(/^I fill in the Edit page with my new details without correct current password$/) do
  step %{I fill in "Full name" with "#{@new_user_information[:full_name]}"}
  step %{I fill in "Phone" with "#{@new_user_information[:phone]}"}
  step %{I fill in "Birthday" with "#{@new_user_information[:birthday]}"}
  step %{I fill in "Current password" with "abcd1234"}
  step %{I press "Update"}
end

When(/^I fill in the Edit page with my new details but without current password$/) do
  step %{I fill in "Full name" with "#{@new_user_information[:full_name]}"}
  step %{I fill in "Phone" with "#{@new_user_information[:phone]}"}
  step %{I fill in "Birthday" with "#{@new_user_information[:birthday]}"}
  step %{I press "Update"}
end

When(/^I fill in the Edit page with password mismatched with confirmation$/) do
  step %{I fill in "Password" with "#{@new_user_information[:password]}"}
  step %{I fill in "Password confirmation" with "abcd1234"}
  step %{I fill in "Current password" with "#{@user_password}"}
  step %{I press "Update"}
end

Then(/^I click on the confirmation link$/) do
  open_email(@new_user_information[:email])
  click_first_link_in_email
end

Then(/^My email is updated$/) do
  expect(User).to be_exists(id: @user.id, email: @new_user_information[:email])
end
