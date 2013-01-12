class MoviesController < ApplicationController

  caches_page :index

  def index
    @imdb_movies = Movie.all(from: :top)
  end

end