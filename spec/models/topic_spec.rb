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

  describe "class methods" do
    describe ".topics_with_article_counts" do
      subject { Topic.topics_with_article_counts }

      it "should return topics with article counts" do
        topic1 = FactoryGirl.create :topic
        topic2 = FactoryGirl.create :topic
        FactoryGirl.create :article, topics: [topic1, topic2]
        FactoryGirl.create :article, topics: [topic2]
        expect(subject.to_a.size).to eq 2
        expect(subject.first.name).to eq topic2.name
        expect(subject.first.article_count).to eq 2
        expect(subject.last.name).to eq topic1.name
        expect(subject.last.article_count).to eq 1
      end
    end
  end

  describe "instance methods"
end
