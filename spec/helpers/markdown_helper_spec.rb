require 'spec_helper'

describe MarkdownHelper do
  describe "#markdown" do
    let(:some_markdown) {
      <<-MARKDOWN
Heading
=======

Body
      MARKDOWN
    }

    let(:rendered_markdown) {
      <<-HTML
<h1>Heading</h1>

<p>Body</p>
      HTML
    }
    it "should render markdown" do
      helper.markdown(some_markdown).should eq rendered_markdown
    end
  end
end
