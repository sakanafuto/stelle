source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'


gem 'rails', '>= 5.2.4.2'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'turbolinks', '~> 5'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0.0'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false


# ---以下追加---
gem 'font-awesome-rails'
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap-honoka-rails' , '~> 4.3.1'
gem 'jquery-rails'
gem 'devise'
gem 'rails-i18n'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'faker'
gem 'carrierwave'
gem 'mini_magick', '4.8.0'
gem 'fog-aws'
gem 'dotenv-rails'
gem 'ransack'
gem 'webpacker', github: "rails/webpacker"
gem 'therubyracer',  platforms: :ruby
gem 'unicorn'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # ---以下追加---  
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'spring-commands-rspec'
  gem 'capistrano',            '~>3.5.0'
  gem 'capistrano-bundler',   '~> 1.1.3'
  gem 'capistrano-rails',     '~> 1.1.7'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end


group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # ---以下追加--- 
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'bullet'
  gem 'rails-flog', require: 'flog'
end


group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers', '~> 3.0'

  # ---以下追加---  
  gem 'selenium-webdriver'
  gem 'rspec_junit_formatter'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

