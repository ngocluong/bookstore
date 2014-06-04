Feature: Update personal information
As an authorized user
I want to modify my personal information

Background:
  Given I already logged in
  And I am on edit user information page

Scenario: Edit email successfully
  When I fill in the Edit page with valid details and new email address
  And I press "Update"
  Then I should see the following messages
  |messages                                                                                                                                                                                  |
  |You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address. |
  Then I should receive an confirmation email
  And I click on the confirmation link
  Then My email is updated

Scenario: Edit fullname, phone, birthday successfully
  When I fill in the Edit page with new details
  And I press "Update"
  Then I should see the following messages
  |messages                               |
  |You updated your account successfully. |
  And I should updated my details

Scenario: Edit password successfully
  When I fill in the Edit page with new password
  And I press "Update"
  Then I should see the following messages
  |messages                               |
  |You updated your account successfully. |
  And I should updated my password

Scenario: Edit with invalid phone format
  When I fill in the Edit page with invalid phone format
  And I press "Update"
  Then I should see "phone number should following format: xxx-xxx-xxxx"

Scenario: Edit with incorrect current password
  When I fill in the Edit page with invalid phone format
  And I press "Update"
  Then I should see "Current password is invalid"

Scenario: Edit without fill in Current password

Scenario: Edit with new password not match with confirmation



