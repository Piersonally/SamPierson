require 'spec_helper'

describe CssClassList do

  describe ".new" do
    it "should take an array" do
      list = CssClassList.new %w[a b c]
      expect(list.size).to eq 3
      expect(list.to_s).to eq 'a b c'
    end

    it "should take a string" do
      list = CssClassList.new 'd e f'
      expect(list.size).to eq 3
      expect(list.to_s).to eq 'd e f'
    end

    it "should take a nil" do
      list = CssClassList.new nil
      expect(list.size).to eq 0
      expect(list.to_s).to eq ''
    end

    it "should take a mixture of arrays and strings" do
      list = CssClassList.new 'a', 'b', ['c', 'd', ['e', 'f']]
      expect(list.size).to eq 6
      expect(list.to_s).to eq 'a b c d e f'
    end
  end

  describe "#to_s" do
    it "should concatenate entries with spaces" do
      list = CssClassList.new %w[g h i]
      expect(list.to_s).to eq 'g h i'
    end
  end

  describe "#<<" do
    context "given an array" do
      it "should normalize the array and add the items to the list" do
        list = CssClassList.new %w[g h i]
        list << %w[j k l]
        expect(list.size).to eq 6
        expect(list.to_s).to eq 'g h i j k l'
      end
    end
    context "given an string" do
      it "should normalize the array and add the items to the list" do
        list = CssClassList.new %w[m n o]
        list << 'p q r'
        expect(list.size).to eq 6
        expect(list.to_s).to eq 'm n o p q r'
      end
    end

    context "given nil" do
      it "should normalize to an ampty erray" do
        list = CssClassList.new %w[m n o]
        list << nil
        expect(list.size).to eq 3
        expect(list.to_s).to eq 'm n o'
      end
    end

    context "given something it can't handle" do
      it "should raise an error" do
        list = CssClassList.new %w[m n o]
        expect {
          list << {}
        }.to raise_error RuntimeError
      end
    end

    it "should eliminate duplicates" do
      list = CssClassList.new %w[w x y]
      list << 'x y z'
      expect(list.to_s).to eq 'w x y z'
    end
  end

  describe "#size" do
    it "should track the number of classes in the list" do
      list = CssClassList.new %w[s t]
      expect(list.size).to eq 2
      list << 'u'
      expect(list.size).to eq 3
    end
  end

  describe "#any?" do
    it { expect( CssClassList.new.any? ).to be_false }
    it { expect( CssClassList.new('v').any? ).to be_true }
  end
end
