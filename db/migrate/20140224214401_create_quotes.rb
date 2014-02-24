class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.integer :quoter_id
      t.text :quote
      t.string :author
      t.string :source
      t.string :when

      t.timestamps
    end

    add_index :quotations, :quoter_id
    add_foreign_key :quotations, :accounts, column: 'quoter_id'
  end
end
