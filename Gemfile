source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass'
end

gem 'cancan'

gem 'jquery-rails'

gem 'carrierwave'

gem 'devise'

gem 'enumerated_attribute', github: 'jeffp/enumerated_attribute'

gem 'figaro'

gem 'omniauth-google-oauth2'
gem 'omniauth-openid'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rmagick'

# To use debugger
# gem 'debugger'

gem 'simple_form'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'unicorn-rails'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'parallel_tests'
  gem 'zeus-parallel_tests'
end

group :test do
  gem 'capybara'
  gem 'guard-rspec'
  gem 'rb-inotify', '~> 0.8.8', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'zeus'
end  
