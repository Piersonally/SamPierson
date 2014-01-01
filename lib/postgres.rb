module Postgres
  def Postgres.load(dumpfile)
    db = YAML.load_file(Rails.root.join 'config/database.yml')[Rails.env]
    command = "pg_restore --clean --no-owner -d #{db['database']}"
    command += ENV['PW'] ? ' -W' : ' --no-password'
    command += " -U #{db['username']}" unless db['username'].blank?
    command += " #{dumpfile}"
    execute command
  end
end
