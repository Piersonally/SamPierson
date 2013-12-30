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

  RSpec::Matchers.define :be_navbar_with_content do |expected_content|
    match do |actual|
      expect(actual).to eq navbar_with_content(expected_content)
    end
    failure_message_for_should do |actual|
      "expected #{actual} to contain #{expected_content}"
    end
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
        expect(subject).to be_navbar_with_content(
         '<ul class="nav navbar-nav">' +
           '<li><a href="/">Home</a></li>' +
           '<li><a href="/contact">Contact</a></li>' +
         '</ul>'
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
        expect(subject).to be_navbar_with_content(
         '<ul class="nav navbar-nav">' +
           '<li class="someclass"><a href="/">Home</a></li>' +
         '</ul>'
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

    describe "marking items active" do
      context "for an item without an 'active' regex" do
        let(:content_data) {
          [
            {
              type: :nav,
              items: [
                { label: 'Posts', href: '/posts' }
              ]
            }
          ]
        }

        context "when the request path matches exactly" do
          before { helper.stub_chain(:request, :path).and_return('/posts') }

          it "should be marked active" do
            expect(subject).to be_navbar_with_content(
             '<ul class="nav navbar-nav">' +
               '<li class="active"><a href="/posts">Posts</a></li>' +
             '</ul>'
            )
          end
        end

        context "when the request path doesn't match exactly" do
          before { helper.stub_chain(:request, :path).and_return('/posts/1') }

          it "should not be marked active" do
            expect(subject).to be_navbar_with_content(
             '<ul class="nav navbar-nav">' +
               '<li><a href="/posts">Posts</a></li>' +
             '</ul>'
            )
          end
        end
      end

      context "for an item with 'active' regex" do
        let(:content_data) {
          [
            {
              type: :nav,
              items: [
                { label: 'Posts', href: '/posts', active: /^\/posts/ }
              ]
            }
          ]
        }

        context "when the request path matches exactly" do
          before { helper.stub_chain(:request, :path).and_return('/posts') }

          it "should be marked active" do
            expect(subject).to be_navbar_with_content(
             '<ul class="nav navbar-nav">' +
               '<li class="active"><a href="/posts">Posts</a></li>' +
             '</ul>'
            )
          end
        end

        context "when the request path doesn't match exactly" do
          before { helper.stub_chain(:request, :path).and_return('/posts/1') }

          it "should be marked active" do
            expect(subject).to be_navbar_with_content(
             '<ul class="nav navbar-nav">' +
               '<li class="active"><a href="/posts">Posts</a></li>' +
             '</ul>'
            )
          end
        end
      end
    end
  end
end
