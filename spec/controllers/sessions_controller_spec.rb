require 'spec_helper'
describe SessionsController do

  context 'POST create' do
    let(:user_password) { 'password' }
    let(:authentication_params) { { user: { email: user.email, password: user_password } } }
    let(:recaptcha_params) { { recaptcha_challenge_field: 'recaptcha_challenge_field' } }
    let(:unauthentication_params) { { user: { email: user.email, password: 'incorrect password' } } }

    context 'captcha validation' do
      let(:user) { create :locked_user, password: user_password }

      context 'show captcha' do
        before do
          xhr :post, :create, authentication_params
        end

        it 'shows captcha for locked user' do
          expect(flash[:show_captcha]).to be_true
        end
      end

      context 'correct captcha' do
        before do
          xhr :post, :create, authentication_params.merge(recaptcha_params)
        end

        it 'sets success flash notice and current_user' do
          expect(flash[:notice]).to eq('Signed in successfully.')
          expect(controller.current_user).to eq(user)
        end
      end

      context 'wrong captcha', :recaptcha do
        before do
          xhr :post, :create, authentication_params.merge(recaptcha_params)
        end

        it 'sets flash condition and render :new action' do
          expect(flash[:recaptcha_error]).to be_present
        end
      end
    end

    context 'email and password combination' do
      let(:user) { create :confirm_user, password: user_password }

      context 'show captcha' do
        before do
          post :create, authentication_params
        end

        it 'does not show captcha for unlocked user' do
          expect(flash[:show_captcha]).to be_false
        end
      end

      context 'conrrect combination of email and password' do
        before do
          post :create, authentication_params
        end

        it 'sets success flash notice and current_user' do
          expect(flash[:notice]).to eq('Signed in successfully.')
          expect(controller.current_user).to eq(user)
        end
      end

      context 'incorrect combination of email and password' do
        before do
          post :create, unauthentication_params
        end

        it 'sets failure alert notice and does not set current_user' do
          expect(flash[:alert]).to eq('Invalid email or password.')
          expect(controller.current_user).to be_nil
        end
      end
    end
  end
end
