ruby '2.3.1'

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'newrelic_rpm'

gem 'active_model_serializers', '~> 0.10.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'rack-cors', require: 'rack/cors'

# Sidekiq
gem 'sidekiq', '~> 4.0'
gem 'sidekiq-failures'
gem 'sidekiq-cron', '~> 0.4.0'
gem 'sinatra', github: 'sinatra/sinatra', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'dotenv-rails'

  gem 'rspec', '= 3.5.0.beta3'
  gem 'rspec-core', '= 3.5.0.beta3'
  gem 'rspec-expectations', '= 3.5.0.beta3'
  gem 'rspec-mocks', '= 3.5.0.beta3'
  gem 'rspec-rails', '= 3.5.0.beta3'
  gem 'rspec-support', '= 3.5.0.beta3'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rails'
  gem 'guard-rspec', '~> 4.7'
  gem 'shoulda-matchers', '~> 3.1'
end

gem 'mechanize'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
