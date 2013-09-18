source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'pg'

gem 'sass-rails', '~> 4.0.0'                    # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'                      # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0'                  # Use CoffeeScript for .js.coffee assets and views
# gem 'therubyracer', platforms: :ruby          # See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'jquery-rails'                              # Use jquery as the JavaScript library
gem 'turbolinks'                                # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 1.2'                        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', require: false, group:[:doc]        # bundle exec rake doc:rails generates the API under doc/api.
# gem 'bcrypt-ruby', '~> 3.0.0'                 # Use ActiveModel has_secure_password
# gem 'unicorn'                                 # Use unicorn as the app server
# gem 'capistrano', group: :development         # Use Capistrano for deployment
# gem 'debugger', group: [:development, :test]  # Use debugger

gem 'haml'

group :development do
  gem 'haml-rails'                              # use haml as templating engine in generators
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'                 # Have Guard send Mac OS X system notifications
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'poltergeist'
end

group :production do
  gem 'rails_12factor'                          # make Heroku happy (log to stdout, servce static assets)
end