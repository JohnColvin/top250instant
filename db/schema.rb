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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130313152717) do

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "imdb_id"
    t.string   "netflix_api_url"
    t.boolean  "netflix_instant"
    t.string   "poster_url"
    t.text     "synopsis",          :limit => 255
    t.string   "mpaa_rating"
    t.integer  "length"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "release_year"
    t.integer  "imdb_ranking"
    t.integer  "best_picture_year"
  end

  add_index "movies", ["best_picture_year"], :name => "index_movies_on_best_picture_year"
  add_index "movies", ["imdb_id"], :name => "index_movies_on_imdb_id", :unique => true
  add_index "movies", ["imdb_ranking"], :name => "index_movies_on_imdb_ranking", :unique => true

end
