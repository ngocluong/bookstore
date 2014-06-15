@javascript
Feature: Rating and comment
As an authorized user
I want to add comment for book

Background:
  Given I already login
  And The Bookstore has books
  Then I show book of one book
  And I want to add some comment

Scenario: Add comment successfully
  When I add a some comment
  Then I should see the following messages
    |message                        |
    |Thank you for your contribution|
  And I will see my comment

Scenario: Add comment without content
  When I leave an empty content
  Then I should see the following messages
    |message                   |
    |Content can't be blank    |

Scenario: Add comment but not login
  When I log out
  Then I should see the following messages
    |message                          |
    |Please sign in to add a review   |
