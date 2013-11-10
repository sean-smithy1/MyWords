source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'bcrypt-ruby', '~> 3.0.0' #Secure Passwords
gem 'bootstrap-will_paginate', '0.0.6' # Paginate records
# gem 'will_paginate', '3.0.3'
gem 'roo', '~> 1.12.2' #CSV importing

### GROUPS ###
group :development do
  gem 'mysql2', '0.3.11'
end

group :assets do
  #CSS
  gem 'sass-rails', '~> 4.0.0'
  gem 'bootstrap-sass'

  # JavaScript
  gem 'coffee-rails', '~> 4.0.0'
  gem 'jquery-rails'

  #Compression
  gem 'uglifier', '>= 1.3.0'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-inotify', '~>0.9'
  gem 'libnotify', '0.5.9'
  gem 'factory_girl_rails', '4.1.0'
end

group :production do
  gem 'mysql2', '0.3.11'
end

group :development, :test do
  # RSpec (unit tests, some integration tests)
  gem 'rspec-rails', '2.13.1'
  #Creation of test records
  gem 'faker', '1.0.1'
end

