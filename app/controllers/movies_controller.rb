class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = Movie.all(from: :top250)
  end

  def best
    @imdb_movies = Movie.all(from: :"best-pictures").reverse
  end

end
