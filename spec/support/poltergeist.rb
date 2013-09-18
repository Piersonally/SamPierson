require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

# Make it so poltergeist (out of thread) tests can work with transactional fixtures
# http://www.opinionatedprogrammer.com/2011/02/capybara-and-selenium-with-rspec-and-rails-3/#comment-220
ActiveRecord::ConnectionAdapters::ConnectionPool.class_eval do
  def current_connection_id
    Thread.main.object_id
  end
end

Capybara.register_driver :poltergeist do |app|
  # options is a hash of options. The following options are supported:
  #
  # :phantomjs (String)                 - A custom path to the phantomjs executable
  # :debug (Boolean)                    - When true, debug output is logged to STDERR. Some debug info from the
  #                                       PhantomJS portion of Poltergeist is also output,
  #                                       but this goes to STDOUT due to technical limitations.
  # :logger (Object responding to puts) - When present, debug output is written to this object
  # :phantomjs_logger (IO object)       - Where the STDOUT from PhantomJS is written to.
  #                                       This is where your console.log statements will show up. Default: STDOUT
  # :timeout (Numeric)                  - The number of seconds we'll wait for a response when communicating with PhantomJS.
  #                                       Default is 30.
  # :inspector (Boolean, String)        - See 'Remote Debugging', above.
  # :js_errors (Boolean)                - When false, Javascript errors do not get re-raised in Ruby.
  # :window_size (Array)                - The dimensions of the browser window in which to test,
  #                                       expressed as a 2-element array, e.g. [1024, 768]. Default: [1024, 768]
  # :phantomjs_options (Array)          - Additional command line options to be passed to PhantomJS,
  #                                       e.g. ['--load-images=no', '--ignore-ssl-errors=yes']
  # :extensions (Array)                 - An array of JS files to be preloaded into the phantomjs browser.
  #                                       Useful for faking unsupported APIs.
  # :port (Fixnum)                      - The port which should be used to communicate with the PhantomJS process.
  #                                       Default: 44678.
  options = { }
  Capybara::Poltergeist::Driver.new app, options
end
