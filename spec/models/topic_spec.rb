require 'spec_helper'

describe Topic do

  describe "database" do
    it { should have_db_index(:name).unique(true) }
  end

  describe "associations" do
    #it { should have_many(:bar).through(:baz) }
  end

  describe "attributes"

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe "authorization"

  describe "lifecycle"

  describe "class methods"

  describe "instance methods"
end
