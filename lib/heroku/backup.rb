class Heroku
  class Backup
    attr_reader :id, :backup_at, :status, :status_at, :size, :db

    # Process a like like line 3 of the following:
    #
    # ID     Backup Time                Status                               Size    Database
    # ----   -------------------------  -----------------------------------  ------  -----------------------------------------
    # oa498  2015-05-19 06:49:42 +0000  Completed 2015-05-19 06:51:20 +0000  67.2kB  DATABASE

    #
    def initialize(pgbackups_output_line, heroku)
      @heroku = heroku
      words = pgbackups_output_line.split(' ')
      @id, @status, @size, @db = words[0], words[4], words[8], words[9]
      Time.zone ||= 'UTC'
      @backup_at = Time.zone.parse "#{words[1]} #{words[2]} #{words[3]}"
      @status_at = Time.zone.parse "#{words[5]} #{words[6]} #{words[7]}"
    end

    # Get a downloadable URL of a Heroku backup
    def uri
      @uri ||= begin
        url = @heroku.run "pg:backups public-url #{id}"
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
      @heroku.run "pg:backups delete #{id}"
    end
  end
end
