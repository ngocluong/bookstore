@javascript
Feature: Sign in
As an unauthorized user
I want to sign in with my email and password

Background:
  Given I already have an account
  Given I am on the Signin page

Scenario: Log in successfully
  When I sign in with valid details
  Then I should see the following messages
    |message                |
    |Signed in successfully.|
  And I should be logged in

Scenario: Log in with account which is not comfirmation
  When I sign in with an uncomfirmed account
  Then I should see the following messages
    |message                                              |
    |You have to confirm your account before continuing.  |

Scenario: Log in with incorrect email or password
  When I sign in with incorrect password
  Then I should see the following messages
  |message                    |
  |Invalid email or password. |

