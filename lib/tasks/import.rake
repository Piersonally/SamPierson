require 'open-uri'

namespace :sam do
  namespace :import do
    namespace :wordpress do
      desc "Import Wordpress articles from FILE=<uri> by AUTHOR=<email>"
      task :yaml => :environment do
        uri = ENV['FILE'] || raise('You must supply FILE=<uri>')
        author_email = ENV['AUTHOR'] || raise('You must suuply AUTHOR=<email>')
        author = Account.find_by_email author_email
        importer = WordpressPostImporter.new author, verbose: true
        importer.import_from_yaml(open uri)
      end
    end
  end
end
