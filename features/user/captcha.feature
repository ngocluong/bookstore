@javascript
Feature: Captcha when user got more than 3 failed sign in times
  Background:
    Given I already have an account
    Given I am on the Signin page
    Given I signs in unsuccessfully in 3 times
    Given I see the captcha

  Scenario: Login successful with correct captcha
    When I sign in with valid details
    And I enter correct captcha
    Then I should be logged in

  Scenario: Login with incorrect email or password
    When I sign in with incorrect password
    And I enter correct captcha
    Then I should see the following messages
      |message                    |
      |Invalid email or password. |

  @recaptcha
  Scenario: Login with incorrect captcha
    When I sign in with valid details but incorrect captcha
    Then I should see the following messages
      |message          |
      |Invalid captcha  |


