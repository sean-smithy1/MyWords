source 'https://rubygems.org'

gem 'rails', '4.1.0'
gem 'bcrypt-ruby', '~> 3.1.2' #Secure Passwords
gem 'bootstrap-will_paginate', '0.0.10' # Paginate records
gem 'will_paginate', '3.0.5'
gem 'roo', '~> 1.12.2' #CSV importing
gem 'mysql2', '~> 0.3.15'

gem 'jquery-rails', '< 3.0.0'
gem 'bootstrap-sass', '~> 3.0.3.0'

### GROUPS ###
group :development do
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
end

group :assets do
  #CSS
  gem 'sass-rails', '~> 4.0.0'

  # JavaScript
  gem 'coffee-rails', '~> 4.0.0'

  #Compression
  gem 'uglifier', '>= 1.3.0'
end

group :test do
  gem 'capybara', '1.1.2'
  # gem 'rb-inotify', '~>0.9'   ** Guard uses these
  # gem 'libnotify', '0.5.9'       ** Guard uses these
  gem 'factory_girl_rails', '~>4.3.0'
  gem 'database_cleaner'
end

group :development, :test do
  # RSpec (unit tests, some integration tests)
  gem 'spork-rails', '~>4.0'
  gem 'rspec-rails', '~>2.0'
  #Creation of test records
  gem 'faker', '1.0.1'
end

