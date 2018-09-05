source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'haml', '~> 5.0', '>= 5.0.4' # Haml (HTML Abstraction Markup Language) is a layer on top of HTML or XML that's designed to express the structure of documents in a non-repetitive, elegant, and easy way by using indentation rather than closing tags and allowing Ruby to be embedded with ease. It was originally envisioned as a plugin for Ruby on Rails, but it can function as a stand-alone templating engine.
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7' # a Sass-powered version of Bootstrap 3
gem 'devise', '~> 4.4', '>= 4.4.3' # 'Flexible authentication solution for Rails with Warden'
gem 'simple_form', '~> 4.0', '>= 4.0.1' # 'forms made easy'
gem 'redcarpet', '~> 3.4' # A fast, safe and extensible Markdown to (X)HTML parser
gem 'will_paginate', '~> 3.1', '>= 3.1.6' # simple API for performing paginated queries
gem 'betterlorem', '~> 0.1.2' # A better Lorem Ipsum generator
gem 'bootstrap-will_paginate', '~> 1.0' # Hooks into will_paginate to format the html to match Twitter Bootstrap styling
gem 'by_star', '~> 3.0' # ActiveRecord and Mongoid extension for easier date scopes and time ranges
gem 'acts-as-taggable-on', '~> 6.0' # Tag a single model on several contexts
gem 'factory_bot_rails', '~> 4.11' # provides a framework and DSL for defining and using factories - less error-prone, more explicit, and all-around easier to work with than fixtures
gem 'faker', '~> 1.9', '>= 1.9.1' # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.

gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'rails-ujs', '~> 0.1.0'


# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
