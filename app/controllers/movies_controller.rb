class MoviesController < ApplicationController

  respond_to :html, :js

  def index
    @imdb_movies = Movie.imdb_top_250

    @imdb_movies = @imdb_movies.search(params[:term]) if params[:term].present?

    @imdb_movies = @imdb_movies.order("#{params[:sort]} asc") if %w{ title release_year length mpaa_rating }.include?(params[:sort])
    @imdb_movies = @imdb_movies.order('imdb_ranking asc')
    params[:sort] = 'imdb_ranking' if params[:sort].blank?

    params[:filter] = 'streaming' if params[:filter].blank?
    @show_all = params[:filter] == 'all'
    @imdb_movies = @imdb_movies.select{ |m| m.netflix_instant? } unless @show_all
  end

end
