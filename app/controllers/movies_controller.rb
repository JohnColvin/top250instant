class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = Movie.imdb_top_250
  end

end
