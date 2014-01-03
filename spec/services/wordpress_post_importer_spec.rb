require 'spec_helper'

describe WordpressPostImporter do

  let(:yaml_header) { "%YAML 1.1\n---\n# sam_wp.posts\n" }
  let(:yaml_footer) { "...\n" }

  let(:published_page_yaml) {
    <<-YAML
-
  ID: 2
  post_author: 2
  post_date: "2008-08-21 07:25:36"
  post_date_gmt: "2008-08-21 14:25:36"
  post_content: "post 2 content"
  post_title: "post 2 title"
  post_category: 0
  post_excerpt: ""
  post_status: "publish"
  comment_status: "open"
  ping_status: "open"
  post_password: ""
  post_name: "about"
  to_ping: ""
  pinged: ""
  post_modified: "2008-08-21 14:35:47"
  post_modified_gmt: "2008-08-21 21:35:47"
  post_content_filtered: ""
  post_parent: 0
  guid: "http://sampierson.com/blog/?page_id=2"
  menu_order: 0
  post_type: "page"
  post_mime_type: ""
  comment_count: 0
    YAML
  }

  let(:published_post_yaml) {
    <<-YAML
-
  ID: 17
  post_author: 2
  post_date: "2008-08-13 16:00:00"
  post_date_gmt: "2008-08-13 23:00:00"
  post_content: "post 17 content"
  post_title: "post 17 title"
  post_category: 0
  post_excerpt: ""
  post_status: "publish"
  comment_status: "open"
  ping_status: "open"
  post_password: ""
  post_name: "installing-mod_rails-in-apache2"
  to_ping: ""
  pinged: ""
  post_modified: "2009-02-19 23:16:17"
  post_modified_gmt: "2009-02-20 06:16:17"
  post_content_filtered: ""
  post_parent: 0
  guid: "urn:uuid:459c8e16-fc07-42de-aada-e06d417a6dcf"
  menu_order: 0
  post_type: "post"
  post_mime_type: ""
  comment_count: 1
    YAML
  }

  let(:inherit_revision_yaml) {
    <<-YAML
-
  ID: 36
  post_author: 2
  post_date: "2008-08-21 07:38:54"
  post_date_gmt: "2008-08-21 14:38:54"
  post_content: "post 36 content"
  post_title: "post 36 title"
  post_category: 0
  post_excerpt: ""
  post_status: "inherit"
  comment_status: "open"
  ping_status: "open"
  post_password: ""
  post_name: "20-revision-2"
  to_ping: ""
  pinged: ""
  post_modified: "2008-08-21 07:38:54"
  post_modified_gmt: "2008-08-21 14:38:54"
  post_content_filtered: ""
  post_parent: 20
  guid: "http://sampierson.com/blog/?p=36"
  menu_order: 0
  post_type: "revision"
  post_mime_type: ""
  comment_count: 0
    YAML
  }

  let(:invalid_post_yaml) {
    <<-YAML
-
  ID: 99
  post_author: 2
  post_date: "2008-08-21 07:38:54"
  post_date_gmt: "2008-08-21 14:38:54"
  post_content: "post 36 content"
  post_title: "" # title can't be blank
  post_category: 0
  post_excerpt: ""
  post_status: "publish"
  comment_status: "open"
  ping_status: "open"
  post_password: ""
  post_name: "20-revision-2"
  to_ping: ""
  pinged: ""
  post_modified: "2008-08-21 07:38:54"
  post_modified_gmt: "2008-08-21 14:38:54"
  post_content_filtered: ""
  post_parent: 20
  guid: "http://sampierson.com/blog/?p=36"
  menu_order: 0
  post_type: "post"
  post_mime_type: ""
  comment_count: 0
    YAML
  }

  describe ".new" do
    let(:author) { FactoryGirl.create :account }
    let(:importer) { WordpressPostImporter.new(author) }

    context "for a mix of published posts and other stuff" do
      let(:yaml) {
        yaml_header + published_page_yaml + published_post_yaml +
          inherit_revision_yaml + yaml_footer
      }

      it "should only import published posts" do
        expect {
          importer.import_from_yaml yaml
        }.to change(Article, :count).by(1)

        a = Article.last
        a.author_id.should == author.id
        a.title.should == "post 17 title"
        a.body.should == "post 17 content"
        a.published_at.should == Time.gm(2008, 8, 13, 23, 0, 0)
      end
    end

    context "for a mix of invalid posts and published posts" do
      let(:yaml) {
        yaml_header + invalid_post_yaml + published_post_yaml +
          inherit_revision_yaml + yaml_footer
      }
      before { importer.stub :puts } # suppress output during tests

      it "should keep going if it encounters an exception" do
        expect {
          importer.import_from_yaml yaml
        }.to change(Article, :count).by(1)
        expect(Article.last.title).to eq "post 17 title"
      end
    end
  end
end
