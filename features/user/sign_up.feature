@javascript
Feature: Sign up
As an unauthorized user
I want to signup with my details
So that I can login

Background:
 Given I am a new user
 And I am on the signup page

Scenario: Registration successfully
  When I sign up with valid details
  Then I should be registed
  And I should receive a confirmation email

Scenario: Missing information
  When I did not fill all the signup information
  Then I should see the following messages
    | message                  |
    | Email can't be blank     |
    | Password can't be blank  |
    | Phone can't be blank     |
    | Full name can't be blank |
    | Birthday can't be blank  |

Scenario: Password doesn't match confirmation
  When I sign up with mismatched password
  Then I should see "Password confirmation doesn't match Password"

Scenario: Invalid email format
  When I sign up with invalid email format
  Then I should see "Email is invalid"

Scenario: Invalid phone format
  When I sign up with invalid phone format
  Then I should see "phone number should following format: xxx-xxx-xxxx"
