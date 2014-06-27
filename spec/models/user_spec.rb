require 'spec_helper'

describe User do
  it { should have_many(:comments).dependent(:destroy) }

  [:phone, :full_name, :birthday].each do |attr|
    it { should validate_presence_of attr }
  end

  context 'phone number validation' do
    let(:user) { build :user }

    context 'valid phone number' do

      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'invalid phone number' do
      before do
        user.phone = '111-111-11a2'
      end

      it 'is invalid' do
        expect(user).to be_invalid
      end
    end
  end
end
