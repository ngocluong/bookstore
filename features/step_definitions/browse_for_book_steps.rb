Given(/^The Bookstore has books$/) do
  @books = create_list :book, 20
end

Given(/^I visit book listing page$/) do
  visit books_path
end

Then(/^I should see first (\d+) books$/) do |per_page|
  Book.first(per_page.to_i).each do |book|
    step %{I should see "#{book.title}"}
  end
  Book.last(20 - per_page.to_i).each do |book|
    step %{I should not see "#{book.title}"}
  end
end

Then(/^I should see links to other pages$/) do
  expect(page).to have_selector('nav.pagination')
end

Then(/^I should see next (\d+) books$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
