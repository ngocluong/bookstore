@javascript
Feature: Chagne quantity in shopping cart
As an unauthorized user
I want to change quantity of books in my shopping cart

Background:
  Given The Bookstore has books
  Then I visit book listing page
  And I want to add book in my cart
  Then I add one book in my cart
  And I will see this book in my cart

Scenario: Change quantity of book item
  When I change book quantity
  And I press enter
  Then I should see the following messages
    |message                        |
    |Update successfully            |
  And The total price will be updated

Scenario: Change quantity with invalid details
  When I change book quantity with invalid details
  And I press enter
  Then I should see the following messages
    |message                        |
    |Quantity is not a number       |
  And The total price will not be updated
