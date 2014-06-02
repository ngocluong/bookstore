Feature: Sign in
As an unauthorized user
I want to sign in with my email and password

Background:
  Given I already have an account
  Given I am on the Signin page

Scenario: Log in successfully
  When I fill in the Sign in page with valid details
  And I press "Sign in"
  Then I should see the following messages
    |messages               |
    |Signed in successfully.|

Scenario: Log in with account which is not comfirmation
  When I fill in the Sign in form with uncomfirmation account
  And I press "Sign in"
  Then I should see the following messages
    |errors                                               |
    |You have to confirm your account before continuing.  |

Scenario: Log in with incorrect email or password
  When I fill in the Sign in form with incorrect password
  And I press "Sign in"
  Then I should see the following messages
  |errors                     |
  |Invalid email or password. |

