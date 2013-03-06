class Movie
  attr_reader :title, :year, :plot_simple, :imdb_id, :poster
  attr_accessor :rank

  alias_attribute :id, :imdb_id
  alias_attribute :release_year, :year
  alias_attribute :storyline, :plot_simple

  def initialize(data)
    %w{ imbd_id title year plot_simple poster }.each do |attr|
      instance_variable_set("@#{attr}", data[attr])
    end
  end

  def to_s
    "#{title} (#{release_year})"
  end

  def netflix_instant?
    netflix_movie.present? && netflix_movie.delivery_formats.include?('instant')
  end

  def netflix_page
    netflix_movie.web_page
  end

  def box_art
    netflix_movie ? netflix_movie.box_art['large'] : poster
  end

  def synopsis
    storyline
  end

  def self.top_250
    uri = URI.parse('http://www.imdb.com/chart/top')
    top_250_page = Net::HTTP.get(uri)
    top_table = Nokogiri::HTML(top_250_page).css('div#main table')[1]
    top_table.children[0].remove #remove header row
    top_250_ids = imdb_ids_from_anchor_tags(top_table.children.map{ |row| row.at_css('td a') })
    movies = fetch(top_250_ids)
    movies.each_with_index{ |m, i| m.rank = i + 1 }
  end

  def self.fetch(imdb_ids)
    imdb_ids.each_slice(10).map do |ids|
      uri = URI.parse("http://imdbapi.org?type=json&ids=#{ids.join(',')}")
      result = Net::HTTP.get(uri)
      data = JSON.parse(result)
      data.map { |movie_data| movie = Movie.new(movie_data) }
    end.flatten
  end

  def netflix_movie
    @netflix_movie ||= NetflixMovie.find_by_imdb_movie(self)
  end

  private

  def self.imdb_id_from_anchor_tag(anchor_tag)
    anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/)
  end

  def self.imdb_ids_from_anchor_tags(anchor_tags)
    anchor_tags.map{ |anchor_tag| imdb_id_from_anchor_tag(anchor_tag) }
  end

end