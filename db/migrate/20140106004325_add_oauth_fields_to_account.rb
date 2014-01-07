class AddOauthFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :oauth_provider, :string
    add_column :accounts, :oauth_uid, :string
    add_column :accounts, :gravatar_id, :string

    add_index :accounts, [:oauth_provider, :oauth_uid]
  end
end
