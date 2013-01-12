class MoviesController < ApplicationController

  caches_action :index

  def index
    @imdb_movies = Movie.all(from: :top)
  end

end