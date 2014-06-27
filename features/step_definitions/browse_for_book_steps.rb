Given(/^The Bookstore has books$/) do
  @books = create_list :book, 20
end

Given(/^I visit book listing page$/) do
  visit books_path
end

Then(/^I should see first (\d+) books$/) do |per_page|
  first_page_books = Book.page(1).per(per_page)

  first_page_books.each do |book|
    step %{I should see "#{book.title}" immediately}
  end

  Book.where.not(id: first_page_books.map(&:id)).each do |book|
    step %{I should not see "#{book.title}"}
  end
end

Then(/^I should see links to other pages$/) do
  step %{I should see element "#{pagination_class}"}
end

Then(/^I should see next (\d+) books$/) do |per_page|
  second_page_books = Book.page(2).per(per_page)

  second_page_books.each do |book|
    step %{I should see "#{book.title}" immediately}
  end

  Book.where.not(id: second_page_books.map(&:id)).each do |book|
    step %{I should not see "#{book.title}"}
  end
end

When(/^I change to (\d+) books per page$/) do |per_page|
  page.select(per_page, from: 'per_page')
end

When(/^I move to second page$/) do
  step %{I press "Next ›"}
end
