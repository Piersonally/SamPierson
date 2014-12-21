require 'spec_helper'

describe ApplicationHelper, type: :helper do
  describe "#page_heading_helper" do
    subject { helper.page_heading_helper }

    context "with no heading data" do
      it "should display a missing message" do
        expect(subject).to match /MISSING HEADING/
      end

      context "when there is a title set" do
        before { allow(helper).to receive(:title) { 'test title' } }
        it { should eq "<h1>test title</h1>" }

        context "and @heading is set" do
          before { @heading = 'at-heading' }
          it { should eq "<h1>at-heading</h1>" }

          context "and there is content_for :heading" do
            before { helper.content_for :heading, "content for heading" }
            it { should eq "content for heading" }
          end
        end
      end

      context "when @heading is false" do
        before { @heading = false }

        it "should suppress the heading" do
          should be_nil
        end
      end
    end
  end
end
