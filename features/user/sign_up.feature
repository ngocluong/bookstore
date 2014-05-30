Feature: Sign up
As an unauthorized user
I want to signup with my details
So that I can login

Background:
   Given I am a new user
   Given I am on the signup page

Scenario: Missing information
  When I did not fill all the signup information
  And I press "Sign up"
  Then I should see the following errors
    | error                    |
    | Email can't be blank     |
    | Password can't be blank  |
    | Phone can't be blank     |


Scenario: Password doesn't match confirmation
  When I fill in the Sign up form with mismatched password
  And I press "Sign up"
  Then I should see "Password confirmation doesn't match Password"
