source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'devise'
gem 'devise-async'
gem 'sidekiq'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'unicorn'
gem 'pg_search'
gem 'faker', require: false
gem 'factory_girl_rails'
gem 'activeadmin', github: 'gregbell/active_admin'

gem 'omniauth-facebook'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'slim-rails'

gem 'recaptcha', require: 'recaptcha/rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'webrat'
  gem 'letter_opener'
  gem 'byebug'
  gem 'quiet_assets'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'email_spec'
  gem 'simplecov', '~> 0.7.1', require: false
end
