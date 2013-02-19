class MoviesController < ApplicationController

  caches_action :index, :best

  def index
    @imdb_movies = top_250
  end

  def best
    @imdb_movies = best_picture_winners
  end


  def top_250
    top_table = Nokogiri::HTML(open('http://www.imdb.com/chart/top')).css('div#main table')[1]
    top_table.children[0].remove #remove header row
    movies_from_anchor_tags top_table.children.map{ |row| row.at_css('td a') }
  end

  def best_picture_winners
    (1929..Date.today.year).map { |year| best_picture_winner(year) }.compact
  end

  def best_picture_winner(year)
    oscar_results_page = Nokogiri::HTML(open("http://www.imdb.com/event/ev0000003/#{year}"))
    awards_block = oscar_results_page.at_css('#main .award')
    return nil if awards_block.nil?
    winner_header = awards_block.at_css('h3')
    return nil unless winner_header.text.downcase == 'winner'
    best_picture_anchor_tag = winner_header.next_element.at_css('strong a')
    movie_from_anchor_tag(best_picture_anchor_tag)
  end

  def movies_from_anchor_tags(anchor_tags)
    anchor_tags.map { |anchor_tag| movie_from_anchor_tag(anchor_tag) }
  end

  def movie_from_anchor_tag(anchor_tag)
    anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/)
    Movie.new($1)
  end

end
