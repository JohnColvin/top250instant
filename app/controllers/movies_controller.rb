class MoviesController < ApplicationController

  def index
    @imdb_movies = Movie.all(from: :top)
  end

end