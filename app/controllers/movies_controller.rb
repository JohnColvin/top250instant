class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = top_250
  end

  def best
    @imdb_movies = Movie.all(from: :"best-pictures").reverse
  end


  def top_250
    top_table = Nokogiri::HTML(open('http://www.imdb.com/chart/top')).css('div#main table')[1]
    top_table.children[0].remove #remove header row
    movies_from_anchor_tags top_table.children[0..1].map{ |row| row.at_css('td a') }
  end

  def movies_from_anchor_tags(anchor_tags)
    anchor_tags.map { |anchor_tag| movie_from_anchor_tag(anchor_tag) }
  end

  def movie_from_anchor_tag(anchor_tag)
    anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/)
    Movie.new($1)
  end

end
