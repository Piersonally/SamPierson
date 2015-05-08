# README

![CiecleCI Build Status](https://circleci.com/gh/Piersonally/SamPierson.png?circle-token=602cdb7505a807118fe29db1dba3b4e489e12dff&style=shield)
[![Code Climate](https://codeclimate.com/github/Piersonally/SamPierson.png)](https://codeclimate.com/github/Piersonally/SamPierson)
[![Test Coverage](https://codeclimate.com/github/Piersonally/SamPierson/badges/coverage.svg)](https://codeclimate.com/github/Piersonally/SamPierson)
[![Dependency Status](https://gemnasium.com/Piersonally/SamPierson.svg)](https://gemnasium.com/Piersonally/SamPierson)

This is the source for the website [sampierson.com](http://www.sampierson.com).

I use it as a platform for experimentation, therefore some of the technology
and methodology choices made here are not what I might use while doing for-profit
work.

## Technology

* Ruby 2.2.x
* Rails 4.2.x
* PostgreSQL, foreigner
* RSpec 3, FactoryGirl, Capybara, Poltergeist (phanjomjs)
* Zeus, Guard, guard-rspec, guard-livereload
* Bootstrap 3 (bootstrap-sass)
* [Authentication from scratch](http://railscasts.com/episodes/250-authentication-from-scratch-revised)
* A form builder I wrote for Bootstrap 3
  ([simple_bootstrap_form](https://github.com/Piersonally/simple_bootstrap_form)),
  which has a similar API
  to [simple\_form](https://github.com/plataformatec/simple_form),
  as at the time I started this project, simple\_form was not
  yet Bootstrap 3 compatible.

## Services

* CirleCI for Continuous Integration.
* CodeClimate for code complexity and coverage analysis.

## Methodology

* Follow the [GitHub Ruby Styleguide](https://github.com/styleguide/ruby),
  with the following exception:
  * It's okay to use JSON format for Hashes instead of hashrockets
* Maintain 100% code coverage
* Maintain a CodeClimate GPA of 4.0
* Comply with [Sandy Metz's 5 Rules](https://www.youtube.com/watch?v=npOGOmkxuio).
  1. Classes can be no longer than 100 lines of code
  2. Methods can be no longer than five lines of code
  3. Pass no more than four parameters into a method
  4. Rails controller actions can only instantiate one object
  5. You can pass only one instance variable to a view
* Use Form Objects for all non-trivial forms.
* Screenshot every page in integration tests.  This allows for rapid scanning
  for problems when sweeping CSS changes are made.  The goal is to to eventually
  compile these images into a single PDF.  If you know how to automatically do
  that, please let me know.
* Run [brakeman](http://brakemanscanner.org/) manually, as CodeClimate won't run
  it for open source projects.

## Getting Started

Know what you are doing, skip the steps you don't need:

    brew install postgres phantomjs terminal-notifier

    git clone git@github.com:Piersonally/SamPierson.git
    rvm install `cat SamPierson/.ruby-version`

    createuser --superuser
    rake db:create db:migrate db:test:prepare

    rake tabs

On Mac OS X `rake tabs` will open up a set of windows running the rails console,
server, and guard.  Press return in the guard window to run all tests.

## Deployment

This app is continuously deployed to Heroku by CircleCI upon a successful build.

## TO DO

* Attachments
* Search
