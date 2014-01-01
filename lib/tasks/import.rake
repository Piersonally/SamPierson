require 'open-uri'

namespace :sam do
  namespace :import do
    namespace :wordpress do
      desc "Import Wordpress articles from FILE=<uri> by AUTHOR=<email>"
      task :yaml => :environment do
        uri = ENV['FILE'] or raise('You must supply FILE=')
        author = Account.find_by_email ENV['AUTHOR']
        importer = WordpressPostImporter.new author, verbose: true
        importer.import_from_yaml(open uri)
      end
    end
  end
end
