source "https://rubygems.org"

ruby "3.2.2"

gem "bootsnap", require: false
gem "devise", "~> 4.9"
gem 'geocoder'
gem "jbuilder"
gem "jsonapi-serializer"
gem "image_processing", ">= 1.2"
gem "importmap-rails"
gem 'money-rails', '~> 1.12'
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.2"
gem "redis", ">= 4.0.1"
gem "sprockets-rails"
gem "sassc-rails"
gem "stimulus-rails"
gem 'stripe'
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem "rspec-rails", "~> 6.1.0"
  gem "pry-rails"
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem "web-console"
end
