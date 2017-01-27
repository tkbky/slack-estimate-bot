# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Slack bot
gem 'slack-ruby-client'
gem 'slack-bot-server'

# Templating
gem 'slim-rails'

# Queue store
gem 'redis'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # .env
  gem 'dotenv-rails'

  # Ruby static code analyzer
  gem 'rubocop', '~> 0.47.1', require: false

  # RSpec static code analyzer
  gem 'rubocop-rspec'

  # Testing framework
  gem 'rspec-rails', '~> 3.5'

  # Test fixtures
  gem 'factory_girl_rails'
end

group :test do
  # One-liners tests
  gem 'shoulda-matchers', '~> 3.1'

  # Manage environment
  gem 'climate_control'

  # # Stubbing HTTP requests
  # gem 'webmock'
  #
  # # Record & Replay test suite's HTTP Requests
  # gem 'vcr'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
