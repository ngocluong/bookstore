Given(/^The Bookstore has books$/) do
  @books = create_list :book, 5
end

Given(/^I visit book listing page$/) do
  visit books_path
end

Then(/^I should see all book$/) do
  @books.each do |book|
    step %{I should see "#{book.title}"}
  end
end
