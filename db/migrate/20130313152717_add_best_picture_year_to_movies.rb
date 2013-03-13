class AddBestPictureYearToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :best_picture_year, :integer
    add_index  :movies, :best_picture_year
  end
end
