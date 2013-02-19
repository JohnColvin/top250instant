class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = Movie.top_250
  end

  def best
    @imdb_movies = Movie.best_picture_winners
  end

end
