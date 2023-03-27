source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "bootsnap", require: false
gem 'rufus-scheduler', require: false

group :development, :test do
  gem 'rspec-rails'
  gem "rspec"
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :test do
  gem 'pry'
  gem 'simplecov'
end
