require 'spec_helper'

describe Sluggable, type: :model do
  let(:test_model) { Article }
  let(:model_factory) { :article }
  let(:slugged_column) { :title }

  context "if generate_slugs_from_column is nil" do
    before { test_model.generate_slugs_from_column = nil }
    after { test_model.generate_slugs_from_column = :title }

    it "the model should still function" do
      expect { FactoryGirl.create test_model }.not_to raise_error
    end
  end

  describe "validations" do
    subject { test_model.new }

    it { should validate_presence_of :slug }
    it { should validate_uniqueness_of :slug }
  end

  describe "lifecycle" do
    it "should set a slug when the object is created" do
      object = FactoryGirl.create model_factory, slugged_column => "Some Phrase"
      expect(object.slug).to eq 'some-phrase'
    end

    it "should not change an exisiting slug on save" do
      object = FactoryGirl.create model_factory, slugged_column => 'Phrase One'
      expect(object.slug).to eq 'phrase-one'
      object.update_attributes! slugged_column => 'Phrase Two'
      expect(object.slug).to eq 'phrase-one'
    end
  end

  describe "instance methods" do
    let(:object) { FactoryGirl.create model_factory, slugged_column => 'Slug This'}

    describe "#to_param" do
      it "should return the slug" do
        expect(object.to_param).to eq 'slug-this'
      end
    end
  end
end
