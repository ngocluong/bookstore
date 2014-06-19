@javascript
Feature: View post order
As an authorized user
I want to see my post order list

Background:
  Given The Bookstore has books
  And I already logged in
  Then I already buy some books
  And I visit book listing page

Scenario: View all my post order
  And view my post order
  Then I should see all my post order

Scenario: View post order without login
  When I sign out
  And view my post order
  Then I should see the following messages
    |message                        |
    |You need to sign in            |
