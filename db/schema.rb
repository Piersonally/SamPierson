# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140310185935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_provider"
    t.string   "oauth_uid"
    t.string   "gravatar_id"
    t.string   "roles"
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["oauth_provider", "oauth_uid"], name: "index_accounts_on_oauth_provider_and_oauth_uid", using: :btree

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "visible",         default: false
    t.string   "body_lang",       default: "markdown"
    t.text     "custom_synopsis"
  end

  add_index "articles", ["author_id"], name: "index_articles_on_author_id", using: :btree
  add_index "articles", ["published_at"], name: "index_articles_on_published_at", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", using: :btree
  add_index "articles", ["visible"], name: "index_articles_on_visible", using: :btree

  create_table "articles_topics", force: true do |t|
    t.integer "article_id"
    t.integer "topic_id"
  end

  add_index "articles_topics", ["article_id"], name: "index_articles_topics_on_article_id", using: :btree
  add_index "articles_topics", ["topic_id"], name: "index_articles_topics_on_topic_id", using: :btree

  create_table "quotations", force: true do |t|
    t.integer  "quoter_id"
    t.text     "quote"
    t.string   "author"
    t.string   "source"
    t.string   "when"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotations", ["quoter_id"], name: "index_quotations_on_quoter_id", using: :btree

  create_table "slide_shows", force: true do |t|
    t.integer  "author_id"
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "theme",      default: "default"
  end

  add_index "slide_shows", ["author_id"], name: "index_slide_shows_on_author_id", using: :btree
  add_index "slide_shows", ["slug"], name: "index_slide_shows_on_slug", unique: true, using: :btree

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "topics", ["name"], name: "index_topics_on_name", unique: true, using: :btree
  add_index "topics", ["slug"], name: "index_topics_on_slug", unique: true, using: :btree

  add_foreign_key "articles", "accounts", column: "author_id", name: "articles_author_id_fk"
  add_foreign_key "articles_topics", "articles", name: "articles_topics_article_id_fk"
  add_foreign_key "articles_topics", "topics", name: "articles_topics_topic_id_fk"
  add_foreign_key "quotations", "accounts", column: "quoter_id", name: "quotations_quoter_id_fk"
  add_foreign_key "slide_shows", "accounts", column: "author_id", name: "slide_shows_author_id_fk"
end
