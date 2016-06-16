source 'https://rubygems.org'
ruby '2.3.1'

git_source(:fbf_engine) { |repo_name| "git@github.com:feedbackfruits/#{repo_name}.git" }

gem 'rails', '~> 5.0.0.rc1'
gem 'mongoid', git: 'https://github.com/mongodb/mongoid'
gem 'jbuilder', '~> 2.4.1'
gem 'bcrypt', '~> 3.1.10'
gem 'aasm', '~> 4.10.1'
gem 'responders', '~> 2.1'
gem 'enumerize', '~> 1.1.0'
gem 'active_model_serializers', '~> 0.10.0'
gem 'mongoid_paranoia', git: 'https://github.com/malagant/mongoid_paranoia'
gem 'rack-cors', require: 'rack/cors'
gem 'mongoid-tags', '~> 1.2.0'
gem 'kaminari', '~> 0.16.3'
gem 'sidekiq', '~> 4.1'
gem 'mongoid-observers', '~> 0.1.1'
gem 'rails-observers', git: 'https://github.com/rails/rails-observers'
gem 'activeresource', git: 'https://github.com/rails/activeresource'
gem 'url', '~> 0.3.2', require: false
gem 'redcarpet'
gem 'mongoid_rails_migrations'
gem 'date_validator'
gem 'pundit'
gem 'jwt', '~> 1.5.4'
gem 'httparty'
gem 'redis'

gem 'bepstore-goals', fbf_engine: 'bepstore-api-goals', branch: 'master'

group :development do
  gem 'web-console', '~> 3.0'
end

group :development, :test do
  gem 'byebug', '~> 4.0.5'
  gem 'pry', '~> 0.10.1'
  gem 'pry-byebug', '~> 3.1.0'
  gem 'rspec-rails', '~> 3.5.0.beta4'
  gem 'mongoid-rspec', git: 'https://github.com/diogobenica/mongoid-rspec'
  gem 'dotenv-rails', '~> 2.1.1'
  gem 'rubocop', '~> 0.39.0', require: false
  gem 'rubocop-rspec', '~> 1.4.1'
  gem 'duktape'
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'puma', '~> 3.4.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'shoulda-matchers', '~> 3.0.1'
  gem 'timecop', '~> 0.7.4'
  gem 'faker', '~> 1.4.3'
  gem 'webmock', '~> 2.0.3'
  gem 'simplecov', '~> 0.11.1', require: false
  gem 'codecov', require: false
  gem 'rspec_junit_formatter', '0.2.2'
  gem 'rspec-instafail'
end
