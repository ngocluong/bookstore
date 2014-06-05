@javascript
Feature: forgot password
As an unauthorized user and forgot password
I want to reset my password

Background:
  Given I already have an account
  Given I am on the forgot password page

Scenario: Reset password successfully
  When I enter my email
  Then I should see the following messages
    |message                                                                                      |
    | You will receive an email with instructions on how to reset your password in a few minutes. |
  Then I should receive a email to change my password
  And I click on the change password link
  When I reset my password
  Then I should see the following messages
    |message                                                          |
    | Your password was changed successfully. You are now signed in.  |
  And My password is updated

Scenario: Missing information
  When I did not fill the email address
  Then I should see the following messages
    |message               |
    |Email can't be blank |

Scenario: Email not exists
  When I enter my email which is not exists
  Then I should see the following messages
    |message              |
    |Email not found      |

Scenario: Ignore email to change password
  When I enter my email
  Then I should receive a email to change my password
  And I ignore this email
  And My password is not updated
