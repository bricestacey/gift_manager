source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'therubyracer'

gem 'devise'

gem 'wcapi', :git => 'http://github.com/bricestacey/wcapi'
gem 'amazon-ecs'

gem 'haml'
gem 'kaminari'
gem 'formtastic'

gem 'pg'
gem 'passenger'

group :development do
  gem 'guard'
  gem 'rb-inotify' if RUBY_PLATFORM.downcase.include?("linux")
  gem 'rb-fsevent' if RUBY_PLATFORM.downcase.include?("darwin")
  gem 'guard-passenger'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-spork'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'valid_attribute'
  gem 'factory_girl_rails'
  gem 'headless'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'spork', '~> 0.9.0.rc'

  gem 'vcr'
  gem 'webmock'
end


group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'less-rails-bootstrap'

gem 'thor'

gem 'capistrano'
