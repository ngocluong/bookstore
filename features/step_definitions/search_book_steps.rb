Given(/^The Bookstore has books oragnized in categories$/) do
  @books = create_list :book, 2
  @categories = create_list :category, 2
  @books.each do |book|
      @categories.first.books << book 
  end
end

When(/^I search with the title of the first book$/) do
  step %{I fill in "search" with "#{@books.first.title}"}
  step %{I press "Go"}
end

When(/^I should see this book title$/) do
  step %{I should see "#{@books.first.title}" immediately}
  step %{I should not see "#{@books.last.title}"}
end

When(/^I choose category of the first book$/) do
  page.select(@categories.first.name, from: 'category')
end

When(/^I search with the author name of the first book$/) do
  step %{I fill in "search" with "#{@books.first.author_name}"}
  step %{I press "Go"}
end

When(/^I search with the title is not available$/) do
  step %{I fill in "search" with "something else"}
  step %{I press "Go"}
end

When(/^I choose category not contain the first book$/) do
  page.select(@categories.last.name, from: 'category')
end