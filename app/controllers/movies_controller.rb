class MoviesController < ApplicationController

  def index
    @page = params[:page].to_i || 1
    @imdb_movies = Movie.get(:top, page: @page)
  end

end