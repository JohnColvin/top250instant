class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = Movie.imdb_top_250

    @imdb_movies = @imdb_movies.order("#{params[:order]} asc") if %w{ title release_year length mpaa_rating }.include?(params[:order])
    @imdb_movies = @imdb_movies.order('imdb_ranking asc')
  end

end
