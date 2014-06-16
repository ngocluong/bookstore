Feature: Add book to shopping cart
As an unauthorized user
I want to add book for shopping cart

Background:
  Given The Bookstore has books
  Then I visit book listing page
  And I want to add book in my cart

Scenario: Add book into cart successfully
  When I add one book in my cart
  Then I should see the following messages
    |message                        |
    |Add book to cart successfully  |
  And I will see this book in my cart

Scenario: Add same book into cart again
  When I add one book in my cart
  Then I should see the following messages
    |message                        |
    |Add book to cart successfully  |
  And I add this book one more time
  Then I will see this book in my cart with updated quantity

Scenario: Add book into cart from book detail page
  When I show book of one book
  And I add this book in my cart
  Then I should see the following messages
    |message                        |
    |Add book to cart successfully  |
  And I will see this book in my cart

