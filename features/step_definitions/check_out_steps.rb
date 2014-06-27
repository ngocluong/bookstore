When(/^I check out my shopping cart$/) do
  step %{I press "Check Out"}
end

When(/^I fill delivery detail$/) do
  address = '123 nguyen lam'
  step %{I fill in "Address" with "#{address}"}
  step %{I press "Proceed"}
end

When(/^I not fill delivery detail$/) do
  step %{I press "Proceed"}
end
