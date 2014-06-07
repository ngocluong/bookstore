Feature: Browse for book
As an unauthorized user
I want to browse for books

Background:
  Given The Bookstore has books
  And I visit book listing page

Scenario: browse all book
  Then I should see all book