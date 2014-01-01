require 'postgres'

namespace :sam do
  namespace :db do

    desc "Load database from FILE="
    task :load do
      dumpfile = ENV['FILE'] or raise "You must provide FILE=<filename>"
      ask_user_to_confirm_we_should_proceed "Load database from #{dumpfile}"
      Postgres.load dumpfile
    end
  end
end
