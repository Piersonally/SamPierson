class Postgres

  def self.load(dumpfile)
    execute pg_restore_command(dumpfile)
  end

  private

  def self.pg_restore_command(dumpfile)
    "pg_restore --clean --no-owner -d #{db_config['database']}" +
      pg_restore_username_option +
      pg_restore_password_option +
      " #{dumpfile}"
  end

  def self.pg_restore_password_option
    ENV['PW'] ? ' -W' : ' --no-password'
  end

  def self.pg_restore_username_option
    username = db_config['username']
    return "" if username.blank?
    " -U #{username}"
  end

  def self.db_config
    @db_config ||= begin
      YAML.load_file(Rails.root.join 'config/database.yml')[Rails.env]
    end
  end
end
