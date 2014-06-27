Then(/^I want to add book in my cart$/) do
  @book = @books.first
end

When(/^I add one book in my cart$/) do
  step %{I press "#{@book.unit_price}"}
end

Then(/^I will see this book in my cart$/) do
  step %{I press "CART"}
  step %{I should see "#{@book.title}"}
end

Then(/^I add this book one more time$/) do
  step %{I press "#{@book.unit_price}"}
end

Then(/^I will see this book in my cart with updated quantity$/) do
  step %{I should see "2" immediately}
end

When(/^I add this book in my cart$/) do
  step %{I press "#{@book.unit_price}"}
end

When(/^I show invalid cart$/) do
  visit(cart_path('something'))
end