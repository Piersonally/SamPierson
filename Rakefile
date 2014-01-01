# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

SamPierson::Application.load_tasks

def ask_user_to_confirm_we_should_proceed(question)
  STDOUT << "#{question} (Y/n) ? "
  answer = STDIN.gets.chomp
  if %w[n no].include? answer.downcase
    puts "Aborting."
    exit
  end
end

def execute(command)
  puts "executing: #{command}"
  system command
  raise "Command \"#{command}\" returned exit code #{$?.exitstatus}" unless $?.success?
end
