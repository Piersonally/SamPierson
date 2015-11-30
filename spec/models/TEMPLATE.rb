require 'spec_helper'

describe "Model (remove quotes)", type: :model do

  describe "database" do
    #it { should have_db_index(:foo_id).unique(true) }
    #it { should have_foreign_key_for :foos, column: 'foo_id', name: 'foo_fk' }
  end

  describe "associations" do
    #it { should belong_to(:foo).class_name('Foo').dependent(:destroy) }
    #it { should have_many(:bar).through(:baz) }
  end

  describe "attributes" do
    #it { should_not allow_mass_assignment_of :foo_id }
    #it { should accept_nested_attributes_for :bar }
  end

  describe "validations" do
    #it { should validate_presence_of :foo }
  end

  describe "authorization"

  describe "lifecycle"

  describe "class methods"

  describe "instance methods"
end
