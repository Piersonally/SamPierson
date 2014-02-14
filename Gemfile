source 'https://rubygems.org'
ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', github: 'rails/rails'

gem 'pg'
gem 'foreigner'

gem 'sass-rails', '~> 4.0.0'                    # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'                      # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0'                  # Use CoffeeScript for .js.coffee assets and views
# gem 'therubyracer', platforms: :ruby          # See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'jquery-rails'                              # Use jquery as the JavaScript library
gem 'turbolinks'                                # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 1.2'                        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', require: false, group:[:doc]        # bundle exec rake doc:rails generates the API under doc/api.
gem 'bcrypt-ruby', '~> 3.1.2'                   # Use ActiveModel has_secure_password
# gem 'unicorn'                                 # Use unicorn as the app server
# gem 'capistrano', group: :development         # Use Capistrano for deployment
# gem 'debugger', group: [:development, :test]  # Use debugger

gem 'haml'
gem 'bootstrap-sass'
gem 'meta-tags', require: 'meta_tags'
gem 'redcarpet'                                 # markdown
gem 'coderay'                                   # Syntax highlighting
gem 'kaminari'                                  # Pagination
gem 'kaminari-bootstrap'
gem 'newrelic_rpm'
gem 'omniauth'
gem 'omniauth-github'
gem 'simple_bootstrap_form'

group :development do
  gem 'haml-rails'                              # use haml as templating engine in generators
  gem 'guard-rspec'
  gem 'guard-livereload', require: false
  gem 'guard-markdown'
  gem 'rack-livereload'
  gem 'terminal-notifier-guard'                 # Have Guard send Mac OS X system notifications
  gem 'quiet_assets'
  gem 'zeus'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'poltergeist'
  gem 'byebug'
end

group :test do
  gem 'shoulda-matchers', github: 'Piersonally/shoulda-matchers'
  gem 'factory_girl_rails'                      # If you use factory_girl for fixture replacement, ensure that factory_girl_rails is available in the development group. If it's not, Rails will generate standard yml files instead of factory files.
  gem 'faker'
  gem 'foreigner-matcher'
  #gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov', require: false
end

group :production do
  gem 'passenger'
  gem 'rails_12factor'                          # make Heroku happy (log to stdout, servce static assets)
end
