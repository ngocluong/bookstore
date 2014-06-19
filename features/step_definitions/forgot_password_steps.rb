Given(/^I am on the forgot password page$/) do
  visit new_user_password_path
end

When(/^I enter my email$/) do
  step %{I fill in "Email" with "#{@user.email}"}
  step %{I press "Send me reset password instructions"}
end

Then(/^I should receive a email to change my password$/) do
  wait_until do
    unread_emails_for(@user.email).present?
  end
  expect(unread_emails_for(@user[:email]).last.subject).to eq 'Reset password instructions'
end

Then(/^I click on the change password link$/) do
  open_email(@user[:email], with_subject: 'Reset password instructions')
  click_first_link_in_email
end

When(/^I reset my password$/) do
  step %{I fill in "New password" with "newpassword"}
  step %{I fill in "Confirm new password" with "newpassword"}
  step %{I press "Change my password"}
end

When(/^My password is updated$/) do
  step %{I sign out}
  step %{I am on the Signin page}
  within sign_in_modal_id do
    step %{I fill in "Email" with "#{@user.email}"}
    step %{I fill in "Password" with "newpassword"}
    step %{I press "Sign in"}
  end
  step %{I should be logged in}
end

When(/^I did not fill the email address$/) do
  step %{I press "Send me reset password instructions"}
end

When(/^I enter my email which is not exists$/) do
  step %{I fill in "Email" with "other.email@gamil.com"}
  step %{I press "Send me reset password instructions"}
end

Then(/^I ignore this email$/) do
  # Do nothing
end

Then(/^My password is not updated$/) do
  step %{I am on the Signin page}
  within sign_in_modal_id do
    step %{I fill in "Email" with "#{@user.email}"}
    step %{I fill in "Password" with "#{@user_password}"}
    step %{I press "Sign in"}
  end
  step %{I should be logged in}
end


