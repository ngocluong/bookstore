Given(/^I want to add some comment$/) do
  step %{I press "ADD REVIEW"}
end

Given(/^I already login$/) do
  step %{I already have an account}
  step %{I am on the Signin page}
  step %{I sign in with valid details}
end

When(/^I add a some comment$/) do
  step %{I fill in "context" with "this is a good book"}
  step %{I press "ADD REVIEW"}
end

Then(/^I will see my comment$/) do
  step %{I should see "this is a good book" immediately}
end

When(/^I leave an empty content$/) do
  step %{I press "ADD REVIEW"}
end

When(/^I log out$/) do
  step %{I sign out}
  step %{I show book of one book}
end
