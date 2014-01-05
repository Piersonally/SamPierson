shared_examples_for "a model that slugs column" do |slugged_column|
  describe "Sluggable" do
    it { expect(described_class.ancestors).to include Sluggable }
    it { expect(described_class.generate_slugs_from_column).to eq slugged_column }
  end
end
