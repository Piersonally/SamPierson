namespace :sampierson do
  desc 'Open up a bunch of Terminal tabs and start all the necessary processes to develop the app'
  task :tabs do
    system_type = `uname -s`
    case
    when system_type =~ /Darwin/
      system '/usr/bin/osascript bin/terminal_tabs.scpt ' + Dir.pwd
    else
      puts "Sorry I don't know what to do for a \"#{system_type}\" system"
    end
  end
end

task :tabs => 'sampierson:tabs'