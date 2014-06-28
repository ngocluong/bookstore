@javascript @clear_cache
Feature: Delete item in shopping cart
As an unauthorized user
I want to delete book item in my shopping cart

Background:
  Given The Bookstore has books
  Then I visit book listing page
  And I want to add book in my cart
  Then I add one book in my cart
  And I will see this book in my cart

Scenario: Delete one of book items
  When I delete book item
  Then I should see the following messages
    |message                        |
    |Remove successfully            |
  And This book will removed
