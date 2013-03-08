class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = Movie.imdb_top_250

    @imdb_movies = @imdb_movies.order("#{params[:sort]} asc") if %w{ title release_year length mpaa_rating }.include?(params[:sort])
    @imdb_movies = @imdb_movies.order('imdb_ranking asc')
    params[:sort] = 'imdb_ranking' if params[:sort].blank?
  end

end
