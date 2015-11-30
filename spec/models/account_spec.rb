require 'spec_helper'

describe Account, type: :model do
  describe "database" do
    it { should have_db_index(:email).unique(true) }
  end

  describe "associations" do
    it { should have_many :articles }
    it { should have_many :quotations }
    it { should have_many :slide_shows }
  end

  describe "attributes" do
    # it { should serialize(:roles).as(Array) }
  end

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

    describe "is_admin?" do
      subject { account.is_admin? }
      context "for a non-admin account" do
        let(:account) { FactoryGirl.create :account }
        it { should be_falsey }
      end
      context "for an admin account" do
        let(:account) { FactoryGirl.create :admin_account }
        it { should be_truthy }
      end
    end
  end
end
