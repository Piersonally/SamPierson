class AddRolesToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :roles, :string
  end
end
