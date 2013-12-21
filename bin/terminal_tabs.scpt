#!/usr/bin/osascript

on run argv     # the 'on run' is required to read argv, which in this case, is the curdir

  # setup the command to change dirs for each tab
  #
  set changeDir to "cd " & item 1 of argv & "; "

  # need to preserve those funky linebreak continuation characters
  # which is an OPTION-ENTER in the AppleScript Editor
  #
  # {"AUTOTEST",      "autotest -cvf --style 'rails rspec2'"} ¬
  # {"JASMINE",       "rake jasmine"}, ¬
  # {"MEMCACHED",     "memcached"}, ¬
  # {"RESQUE-WEB",    "resque-web --foreground"}, ¬
  # {"SOLR-TEST",     "rake sunspot:solr:run RAILS_ENV=test"}, ¬
  # {"SPORK",         "spork"}, ¬
  # {"SQL",           "script/dbconsole -p"}, ¬
  # {"REDIS",         "redis-server /usr/local/etc/redis.conf"}, ¬
  # {"ZEUS",          "env RUBYLIB=~/Applications/RubyMine.app/rb/testing/patch/common:~/Applications/RubyMine.app/rb/testing/patch/bdd zeus start"}, ¬
  # {"SOLR",          "rake sunspot:solr:run"}, ¬
  # {"TEST-SOLR",     "rake sunspot:solr:run RAILS_ENV=test"}, ¬
  # {"RESQUE WORKER", "zeus rake environment resque:work QUEUE=nexus_development_urgent"}, ¬
  # {"RESQ-SCHED",    "zeus rake resque:scheduler"}, ¬

  set tabs to {¬
    {"ZEUS",          "env RUBYLIB=~/Applications/RubyMine.app/rb/testing/patch/common:~/Applications/RubyMine.app/rb/testing/patch/bdd zeus start"}, ¬
    {"CONSOLE",       "zeus console"}, ¬
    {"SERVER",        "zeus server"}, ¬
    {"GUARD",         "bundle exec guard"} ¬
  }

  # /usr/local/etc/redis.conf <= this was the default location for redis.conf for me. You may need to edit this

  # tell application "Terminal"
  #   display dialog "It's a good idea to run any 'sudo' command first" buttons ["Cancel", "Already Did!"]
  # end tell

  repeat with tabinfo in tabs
    tell application "Terminal"
      activate
      set cmd to changeDir & item 2 of tabinfo
      tell application "System Events" to tell process "Terminal" to keystroke "tIa" using command down
      tell application "System Events" to tell process "Terminal" to keystroke item 1 of tabinfo
      tell application "System Events" to tell process "Terminal" to keystroke "w" using command down
      tell application "System Events" to tell process "Terminal" to keystroke cmd & return
    end tell
  end repeat

end run
