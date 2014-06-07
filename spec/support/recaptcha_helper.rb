RSpec.configure do |config|
  config.before(:each) do
    Recaptcha.configuration.skip_verify_env.delete("test") if example.metadata[:recaptcha].present?
  end

  config.after(:each) do
    Recaptcha.configuration.skip_verify_env << "test" if example.metadata[:recaptcha].present?
  end
end
