Given(/^I am a new user$/) do
  @user = build(:user)
end

Given(/^I am on the signup page$/) do
  visit store_index_path
  step %{I press "SIGN IN"}
  step %{I wait for Sign In form to appear}
  within sign_in_modal_id do
    step %{I press "Sign up"}
  end
  step %{I wait for Sign Up form to appear}
end

Then(/^I wait for Sign Up form to appear$/) do
  step %{I should see element "#{sign_up_modal_id}"}
end

When(/^I sign up with mismatched password$/) do
  within sign_up_modal_id do
    step %{I fill in "user_password" with "#{@user.password}"}
    step %{I fill in "Password confirmation" with "other_secret"}
    step %{I press "Sign up"}
  end
end

Given(/^I did not fill all the signup information$/) do
  within sign_up_modal_id do
    step %{I press "Sign up"}
  end
end

When(/^I sign up with invalid email format$/) do
  within sign_up_modal_id do
    step %{I fill in "Email" with "abc"}
    step %{I press "Sign up"}
  end
end

When(/^I sign up with invalid phone format$/) do
  within sign_up_modal_id do
    step %{I fill in "user_password" with "something"}
    step %{I press "Sign up"}
  end
end

When(/^I sign up with valid details$/) do
  within sign_up_modal_id do
    step %{I fill in "Email" with "#{@user.email}"}
    step %{I fill in "user_password" with "#{@user.password}"}
    step %{I fill in "Password confirmation" with "#{@user.password}"}
    step %{I fill in "Full name" with "#{@user.full_name}"}
    step %{I fill in "Phone" with "#{@user.phone}"}
    step %{I fill in "Birthday" with "#{@user.birthday}"}
    step %{I press "Sign up"}
  end
end

Then(/^I should be registed$/) do
  wait_until do
    User.exists?(@user.attributes.slice('email', 'full_name', 'phone', 'birthday'))
  end
end

Then(/^I should receive a confirmation email$/) do
  wait_until do
    unread_emails_for(@user.email).present?
  end
  expect(unread_emails_for(@user.email).first.subject).to eq 'Confirmation instructions'
end
