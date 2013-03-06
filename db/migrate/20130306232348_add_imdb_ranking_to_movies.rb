class AddImdbRankingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_ranking, :integer
    add_index :movies, :imdb_ranking, unique: true
  end
end
