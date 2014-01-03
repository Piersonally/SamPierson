require 'postgres'
require 'heroku'
require 'heroku/backup'

namespace :sam do
  namespace :db do

    desc "Load database from FILE="
    task :load do
      dumpfile = ENV['FILE'] || raise("You must provide FILE=<filename>")
      ask_user_to_confirm_we_should_proceed "Load database from #{dumpfile}"
      Postgres.load dumpfile
    end

    desc "Download latest backup and import it into development DB"
    task :pull do
      heroku = Heroku.new 'sampierson', verbose: true
      backup = heroku.list_backups.sort_by(&:backup_at).last
      dumpfile = backup.get
      Postgres.load dumpfile
    end
  end
end
