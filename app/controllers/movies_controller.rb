class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = Movie.top_250
  end

end
