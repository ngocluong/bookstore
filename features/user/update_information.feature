Feature: Update personal information
As an authorized user
I want to modify my personal information

Background:
  Given I already logged in
  And I am on edit user information page

Scenario: Edit email successfully
  When I change my email address
  Then I should see the following messages
  |message|
  |You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address. |
  Then I should receive a confirmation email
  And I click on the confirmation link
  Then My email is updated

Scenario: Edit fullname, phone, birthday successfully
  When I fill in the Edit page with my new details
  Then I should see the following messages
  |message                               |
  |You updated your account successfully. |
  And My account detail is updated

Scenario: Edit password successfully
  When I change my password
  Then I should see the following messages
  |message                               |
  |You updated your account successfully. |
  And I can login with my new password

Scenario: Edit with invalid phone format
  When I fill in the Edit page with invalid phone format
  Then I should see "phone number should following format: xxx-xxx-xxxx"

Scenario: Edit with incorrect current password
  When I fill in the Edit page with my new details without correct current password
  Then I should see the following messages
  |message                               |
  |Current password is invalid           |

Scenario: Edit without fill in current password
  When I fill in the Edit page with my new details but without current password
  Then I should see the following messages
  |message                               |
  |Current password can't be blank        |

Scenario: Edit with new password not match with confirmation
  When I fill in the Edit page with password mismatched with confirmation
  Then I should see the following messages
  |message                                     |
  |Password confirmation doesn't match Password |



