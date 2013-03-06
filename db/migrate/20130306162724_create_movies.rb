class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :imdb_id
      t.string :netflix_api_url
      t.boolean :netflix_instant
      t.string :poster_url
      t.string :synopsis
      t.string :mpaa_rating
      t.integer :length

      t.timestamps
    end

    add_index :movies, :imdb_id, :unique => true

  end
end
