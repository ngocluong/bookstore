When(/^I wait for (\d+) seconds$/) do |second|
  sleep second.to_i
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |location, value|
  fill_in location, with: value
end

When(/^I press "(.*?)"$/) do |button_or_link|
  click_on button_or_link
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content content
end
