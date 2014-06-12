When(/^I show book of one book$/) do
  visit(book_path(@books.first))
end

Then(/^I will see this book details$/) do
  @book = @books.first
  [:title, :description, :author_name, :publisher_name, :published_date, :total_rating_count].each do |attr|
    step %{I should see "#{@book.send(attr)}" immediately}
  end
end
