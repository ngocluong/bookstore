Given(/^I already have an account$/) do
  @user_password = 'abcd1234'
  @user = create :confirm_user, password: @user_password
  @unconfirmed_user = create :user, password: @user_password
end

Given(/^I am on the Signin page$/) do
  visit store_index_path
  step %{I press "SIGN IN"}
  step %{I wait for Sign In form to appear}
end

Then(/^I wait for Sign In form to appear$/) do
  step %{I should see element "#{sign_in_modal_id}"}
end

Then(/^I sign in with valid details$/) do
  within sign_in_modal_id do
    step %{I fill in "Email" with "#{@user.email}"}
    step %{I fill in "Password" with "#{@user_password}"}
    step %{I press "Sign in"}
  end
end

Then(/^I sign in with an uncomfirmed account$/) do
  within sign_in_modal_id do
    step %{I fill in "Email" with "#{@unconfirmed_user.email}"}
    step %{I fill in "Password" with "#{@user_password}"}
    step %{I press "Sign in"}
  end
end

Then(/^I sign in with incorrect password$/) do
  within sign_in_modal_id do
    step %{I fill in "Email" with "#{@user.email}"}
    step %{I fill in "Password" with "abc"}
    step %{I press "Sign in"}
  end
end

Then(/^I should be logged in$/) do
  within '#right-panel' do
    wait_until do
      page.has_link?('SIGN OUT') && page.has_link?('EDIT')
    end
  end
end
