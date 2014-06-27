When(/^I delete book item$/) do
  step %{I press "delete"}
  delete_confirm = page.driver.browser.switch_to.alert
  delete_confirm.accept
end

Then(/^This book will removed$/) do
  step %{I should not see "#{@book.title}"}
end
