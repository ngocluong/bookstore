Feature: Browse for book
As an unauthorized user
I want to browse for books

Background:
  Given The Bookstore has books
  And I visit book listing page

Scenario: Browse all book
  Then I should see first 10 books
  And I should see links to other pages
  Then I press "Next ›" 
  And I should see next 10 books
