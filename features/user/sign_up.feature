Feature: Sign up
As an unauthorized user
I want to signup with my details
So that I can login

Background:
 Given I am a new user
 Given I am on the signup page

@truncation
Scenario: Registration successfully
  When I fill in the Sign up form with valid details
  And I press "Sign up"
  And I should be registed
  And I should received an confirmation email

Scenario: Missing information
  When I did not fill all the signup information
  And I press "Sign up"
  Then I should see the following messages
    | error                    |
    | Email can't be blank     |
    | Password can't be blank  |
    | Phone can't be blank     |
    | Full name can't be blank |
    | Birthday can't be blank  |

Scenario: Password doesn't match confirmation
  When I fill in the Sign up form with mismatched password
  And I press "Sign up"
  Then I should see "Password confirmation doesn't match Password"

Scenario: Invalid email format
  When I fill in the Sign up form with invalid email format
  And I press "Sign up"
  Then I should see "Email is invalid"

Scenario: Invalid phone format
  When I fill in the sign up form with invalid phone format
  And I press "Sign up"
  Then I should see "phone number should following format: xxx-xxx-xxxx"
