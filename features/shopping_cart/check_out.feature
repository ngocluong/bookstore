Feature: Check out shopping cart
As an authorized user
I want to check out

Background:
  Given The Bookstore has books
  And I already logged in
  Then I visit book listing page
  And I want to add book in my cart
  Then I add one book in my cart
  And I will see this book in my cart

Scenario: Check out succesfully
  When I check out my shopping cart
  And I fill delivery detail
  Then I should see the following messages
    |message                            |
    |Thank you for your order           |

Scenario: Check out unsuccesfully
  When I check out my shopping cart
  And I not fill delivery detail
  Then I should see the following messages
    |message                        |
    |Address can't be blank         |
