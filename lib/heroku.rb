require 'diagnostic_messaging'

class Heroku
  include ::DiagnosticMessaging

  def initialize(application_name=nil, options={})
    @application_name = application_name
    @verbose = options[:verbose]
  end

  def list_backups
    pgbackups_output = run "pg:backups"
    backups_list_with_header = paragraphs(pgbackups_output)[0]
    backups_list_with_header.split("\n").from(3).map do |line|
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

  def paragraphs(string_content)
    string_content.split("\n\n")
  end

  def execute_and_capture_output(shell_command)
    notice shell_command
    `#{shell_command}`
  end

  def create_shell_command(heroku_command)
    command = "heroku #{heroku_command}"
    command << " --app #{@application_name}" if @application_name
    command
  end
end
