require 'spec_helper'

describe Account do
  describe "database" do
    it { should have_db_index(:email).unique(true) }
  end

  describe "associations" do
    it { should have_many :posts }
  end

  describe "attributes"

  describe "validations" do
    before { FactoryGirl.create :account }

    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_uniqueness_of :email }
  end

  describe "authorization"

  describe "lifecycle"

  describe "class methods"

  describe "instance methods" do
    describe "#full_name" do
      it "should contantenate name" do
        account = Account.new first_name: 'Englebert', last_name: 'Humperdink'
        expect(account.full_name).to eq 'Englebert Humperdink'
      end

      it "should elide a blank first name" do
        account = Account.new first_name: '', last_name: 'Humperdink'
        expect(account.full_name).to eq 'Humperdink'
      end

      it "should elide a blank last name" do
        account = Account.new first_name: 'Englebert', last_name: nil
        expect(account.full_name).to eq 'Englebert'
      end
    end
  end
end
