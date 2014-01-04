require 'spec_helper'

describe Topic do

  describe "database" do
    it { should have_db_index(:name).unique(true) }
  end

  describe "associations" do
    #it { should have_and_belong_to_many :articles }  # Broken matcher with Rails 4.1
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
