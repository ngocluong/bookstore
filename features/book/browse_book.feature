Feature: Browse for book
As an unauthorized user
I want to browse for books

Background:
  Given The Bookstore has books
  And I visit book listing page

Scenario: Browse all book
  Then I should see first 9 books
  And I should see links to other pages
  Then I press "Next ›"
  And I should see next 9 books

Scenario: Change book per page
  When I change to 15 books per page
  Then I should see first 15 books
  Then I move to second page
  And I should see next 15 books

Scenario: Change book per page in page 2
  When I move to second page
  And I change to 15 books per page
  Then I should see first 15 books
