Given(/^I signs in unsuccessfully in (\d+) times$/) do |arg1|
  @user.failed_attempts = 3;
  @user.save
  step %{I sign in with incorrect password}

end

Given(/^I see the captcha$/) do
  expect(page).to have_selector('div#recaptcha_area')
end

When(/^I enter correct captcha$/) do
  # do nothing
end

When(/^I sign in with valid details but incorrect captcha$/) do
  within sign_in_modal_id do
    step %{I fill in "Email" with "#{@user.email}"}
    step %{I fill in "Password" with "#{@user_password}"}
    step %{I press "Sign in"}
  end
end


