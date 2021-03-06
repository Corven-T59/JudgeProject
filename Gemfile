source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', platforms: :ruby

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

gem 'rspec-rails', '~> 3.5'
gem 'factory_girl_rails'
gem 'shoulda-matchers'
gem 'rails-controller-testing'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# users
gem 'devise', '~> 4.2', git: 'https://github.com/plataformatec/devise.git', branch: 'master'

# file uploads
gem 'carrierwave', '~> 1.0'
gem 'remotipart', '~> 1.2' # File uploads trough AJAX request
# background async process
gem 'sidekiq', '~> 5.0'

# rest clien
gem 'rest-client'

# rest data manipulation
gem 'json'

# scheduled updates
gem 'sidekiq-scheduler'

# Gem for bootstrap on sass
gem "bootstrap-sass"

# Tags
gem 'acts-as-taggable-on', '~> 5.0'

# Display model as pages
gem 'kaminari'

# Rails internationalization
gem 'rails-i18n', '~> 5.0.0'
gem 'devise-i18n'

# Data driven
gem "d3-rails"
group :development do
  # Use capistrano for deploy
  gem 'capistrano', '3.8.1'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'

  # Add this if you're using rbenv
  gem 'capistrano-rbenv'

  # Sidekiq
  gem 'capistrano-sidekiq'

  # Bundler
  gem 'capistrano-bundler'
end
