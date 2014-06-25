Given(/^I already buy some books$/) do
  @orders = create_list :order, 2, user: @user
end

When(/^view my post order$/) do
  find('img.user-image').click
  within '.dropdown-menu' do
    step %{I press "Post Orders"}
  end
end

Then(/^I should see all my post order$/) do
  @orders.each do |order|
    step %{I should see "#{order.created_at}" immediately}
  end
end

When(/^should not see post order link$/) do
  step %{I should not see element "#{user_p}"}
end
