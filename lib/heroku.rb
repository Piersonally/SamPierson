class Heroku

  def initialize(application_name=nil, options={})
    @application_name = application_name
    @verbose = options[:verbose]
  end

  def list_backups
    pgbackups_output = run "pgbackups"
    pgbackups_output.split("\n").from(2).map do |line|
      Backup.new line, self
    end
  end

  def run(heroku_command)
    Bundler.with_clean_env do
      output = execute_and_capture_output create_shell_command(heroku_command)
      notice output
      output
    end
  end

  private

  def execute_and_capture_output(shell_command)
    notice shell_command
    `#{shell_command}`
  end

  def create_shell_command(heroku_command)
    command = "heroku #{heroku_command}"
    command << " --app #{@application_name}" if @application_name
    command
  end

  def notice(message)
    puts message if @verbose
  end
end
