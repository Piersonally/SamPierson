require 'spec_helper'

describe Quotation do
  describe "database" do
    it { should have_db_index(:quoter_id) }
    # it { should have_foreign_key_for :accounts, column: 'quoter_id' }
  end

  describe "associations" do
    it { should belong_to(:quoter).class_name('Account') }
  end

  describe "attributes"

  describe "validations" do
    it { should validate_presence_of :quoter_id }
    it { should validate_presence_of :quote }
    it { should validate_presence_of :author }
  end
end
