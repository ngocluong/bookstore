@clear_cache
Feature: Search for book
As an unauthorized user
I want to search for books base on title, author name and category

Background:
  Given The Bookstore has books oragnized in categories
  And I visit book listing page

Scenario: Search base on book title
  When I search with the title of the first book
  Then I should see this book title

Scenario: Search with author name and categories
  When I choose category of the first book
  And I search with the author name of the first book
  Then I should see this book title

Scenario: Search with book title is not available
  When I search with the title is not available
  Then I should see the following messages
    |message                                                  |
    |Can not find books which have title or author like this  |

Scenario: Search with available book title but incorrect categories
  When I choose category not contain the first book
  And I search with the author name of the first book
  Then I should see the following messages
    |message                                                  |
    |Can not find books which have title or author like this  |
