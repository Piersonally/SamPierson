class Heroku
  class Backup
    attr_reader :id, :backup_at, :status, :junk, :status_at, :size, :db

    # Process a like like line 3 of the following:
    #
    # ID    Backup Time          Status                          Size    Database
    # ----  -------------------  ------------------------------  ------  -----------------------------------------
    # b002  2014/01/02 20:18.59  Finished @ 2014/01/02 20:19.03  45.2KB  HEROKU_POSTGRESQL_TEAL_URL (DATABASE_URL)
    #
    def initialize(pgbackups_output_line, heroku)
      @heroku = heroku
      words = pgbackups_output_line.split(' ')
      @id, @size, @db = words[0], words[7], words[8]
      Time.zone ||= 'UTC'
      @backup_at = Time.zone.parse "#{words[1]} #{words[2]} UTC"
      @status_at = Time.zone.parse "#{words[5]} #{words[6]} UTC"
    end

    # Get a downloadable URL of a Heroku backup
    def uri
      @uri ||= begin
        url = @heroku.run "pgbackups:url #{id}"
        URI.parse url.gsub('"', '')
      end
    end

    # Download a backup, return pathname of dump filename
    def get
      filename = File.basename uri.path
      outfile ||= "tmp/#{filename}"
      execute "curl -o #{outfile} '#{uri}'"
      @heroku.send :notice, "\nDownloaded database dump to: #{outfile}\n\n"
      outfile
    end

    def destroy
      @heroku.run "pgbackups:destroy #{id}"
    end
  end
end
