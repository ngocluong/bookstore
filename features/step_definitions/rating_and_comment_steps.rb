Given(/^I want to add some comment$/) do
  @comment = 'this is a good book'
end

Given(/^I already login$/) do
  @user = create :confirm_user
  login_as @user, scope: :user
end

When(/^I add a some comment$/) do
  Rails.cache.clear
  step %{I press "ADD REVIEW"}
  within add_review_modal_id do
    step %{I should see element "#{raty_div}"}
    step %{I fill in "comment_content" with "#{@comment}"}
    step %{I press "ADD REVIEW"}
  end
end

Then(/^I will see my comment$/) do
  step %{I should see "#{@comment}"}
end

When(/^I leave an empty content$/) do
  step %{I press "ADD REVIEW"}
  within add_review_modal_id do
    step %{I press "ADD REVIEW"}
  end
end

When(/^I log out$/) do
  step %{I sign out}
  step %{I am on the Signin page}
  step %{I show book of one book}
end
