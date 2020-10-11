source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 5.0.0'
gem 'jbuilder', '~> 2.5'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'rails', '= 6.0.3.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# ---以下追加---
gem 'bcrypt_pbkdf'
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap-honoka-rails', '~> 4.3.1'
gem 'carrierwave'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'dotenv-rails'
gem 'ed25519'
gem 'faker'
gem 'fog-aws'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'mini_magick', '4.9.4'
gem 'mini_racer'
gem 'rails-i18n'
gem 'ransack'
gem 'rubocop', require: false
gem 'rubocop-rails'
gem 'webpacker', github: 'rails/webpacker'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # ---以下追加---
  gem 'capistrano', '~>3.5.0'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'capistrano-rails', '~> 1.1.7'
  gem 'capistrano-rails-db'
  gem 'capistrano-rbenv'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  # ---以下追加---
  gem 'annotate'
  gem 'bullet'
  gem 'rails-flog', require: 'flog'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers', '~> 3.0'
  # ---以下追加---
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
end

group :production, :staging do
  gem 'unicorn', '=5.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
