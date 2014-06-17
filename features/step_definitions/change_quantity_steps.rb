When(/^I change book quantity$/) do
  step %{I fill in "line_item_quantity" with "3"}
end

When(/^I press enter$/) do
  find('#line_item_quantity').native.send_keys(:enter)
end

Then(/^The total price will be updated$/) do
  step %{I should see "#{@book.unit_price * 3}"}
end

When(/^I change book quantity with invalid details$/) do
  step %{I fill in "line_item_quantity" with "something"}
end

Then(/^The total price will not be updated$/) do
  step %{I should see "#{@book.unit_price}"}
end
