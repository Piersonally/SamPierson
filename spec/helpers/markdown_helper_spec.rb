require 'spec_helper'

describe MarkdownHelper do
  describe "#markdown" do
    context "for regular markdown" do
      let(:some_markdown) { "Heading\n=======\n\nBody\n" }
      let(:rendered_markdown) { "<h1>Heading</h1>\n\n<p>Body</p>\n" }

      it "should render markdown" do
        helper.markdown(some_markdown).should eq rendered_markdown
      end
    end

    context "for markdown including code" do
      let(:markdown) { "```ruby\nx = 1;\n```\n" }
      let(:rendered_markdown) {
        "<div class=\"CodeRay\">\n" +
        "  <div class=\"code\"><pre>x = <span class=\"integer\">1</span>;\n" +
        "</pre></div>\n" +
        "</div>\n"
      }

      it "should syntax highlight code" do
        helper.markdown(markdown).should eq rendered_markdown
      end
    end

    context "given a code block with no language" do
      let(:markdown) { "```\nx = 1;\n```\n" }

      it "shouldn't puke" do
        expect {
          helper.markdown(markdown)
        }.not_to raise_exception
      end
    end
  end
end
