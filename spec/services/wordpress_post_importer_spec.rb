require 'spec_helper'

describe WordpressPostImporter do

  let(:yaml) {
    <<-YAML
%YAML 1.1
---
# sam_wp.posts
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
...
    YAML
  }
  describe ".new" do
    let(:author) { FactoryGirl.create :account }

    it "should only import published posts" do
      expect {
        WordpressPostImporter.new(author).import_from_yaml yaml
      }.to change(Article, :count).by(1)

      a = Article.last
      a.author_id.should == author.id
      a.title.should == "post 17 title"
      a.body.should == "post 17 content"
      a.published_at.should == Time.gm(2008, 8, 13, 23, 0, 0)
    end
  end
end
