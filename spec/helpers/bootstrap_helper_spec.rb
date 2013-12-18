require 'spec_helper'

describe BootstrapHelper do

  def navbar_with_content(content)
    '<nav class="navbar navbar-default" role="navigation">' +
      '<div class="navbar-header">' +
        '<button class="navbar-toggle" data-target="#bs-navbar-collapse-1" data-toggle="collapse" data-type="button">' +
          '<span class="sr-only">Toggle navigation</span>' +
          '<span class="icon-bar"></span>' +
          '<span class="icon-bar"></span>' +
          '<span class="icon-bar"></span>' +
        '</button>' +
        '<a class="navbar-brand" href="/">Sam Pierson</a>' +
      '</div>' +
      '<div class="collapse navbar-collapse" id="bs-navbar-collapse-1">' +
         content +
      '</div>' +
    '</nav>'
  end

  describe "#navbar_helper" do
    subject { helper.navbar_helper content_data }
    before { helper.stub_chain(:request, :path).and_return('/foo') }

    describe "simple navbar" do
      let(:content_data) {
        [ {type: :nav, items: [
          { label: 'Home', href: '/' },
          { label: 'Contact', href: '/contact' },
        ] } ]
      }

      it "should do something" do
        expect(subject).to eq(
         navbar_with_content(
           '<ul class="nav navbar-nav">' +
             '<li><a href="/">Home</a></li>' +
             '<li><a href="/contact">Contact</a></li>' +
           '</ul>'
          )
        )
      end
    end

    describe "item with css classes" do
      let(:content_data) {
        [ {type: :nav, items: [
          { label: 'Home', href: '/' , class: 'someclass' }
        ] } ]
      }

      it "should do something" do
        expect(subject).to eq(
         navbar_with_content(
           '<ul class="nav navbar-nav">' +
             '<li class="someclass"><a href="/">Home</a></li>' +
           '</ul>'
          )
        )
      end
    end

    describe "content data with errors" do
      let(:content_data) {
        [ { type: :bogus } ]
      }

      it "should raise an error" do
        expect { subject }.to raise_error(RuntimeError)
      end
    end
  end
end
