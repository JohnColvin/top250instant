class Movie
  attr_reader :title, :release_year, :storyline, :id

  def initialize(data)
    @id = data['imdb_id']
    @title = data['title']
    @release_year = data['year']
    @storyline = data['plot_simple']
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
    netflix_movie.box_art['large']
  end

  def synopsis
    storyline
  end

  def self.top_250
    if cached_top_250_ids = $redis.get('top-250-ids')
      top_250_ids = JSON.parse(cached_top_250_ids)
    else
      uri = URI.parse('http://www.imdb.com/chart/top')
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      top_250_page = response.body
      top_table = Nokogiri::HTML(top_250_page).css('div#main table')[1]
      top_table.children[0].remove #remove header row
      top_250_ids = imdb_ids_from_anchor_tags(top_table.children.map{ |row| row.at_css('td a') })
      $redis.set('top-250-ids', top_250_ids.map(&:to_s))
    end
    fetch(top_250_ids)
  end

  def self.best_picture_winners
    best_picture_ids = (1929..Date.today.year).map{ |year| best_picture_winner_id(year) }.compact
    fetch(best_picture_ids)
  end

  def self.fetch(imdb_ids)
    movies = []
    uncached_movie_ids = []

    imdb_ids.each do |imdb_id|
       if data = $redis.get("#{imdb_id}_imdb_data")
         movies << Movie.new(JSON.parse(data))
       else
        uncached_movie_ids << imdb_id
       end
     end

    uncached_movie_ids.each_slice(10) do |ids|
      uri = URI.parse("http://imdbapi.org?type=json&ids=#{ids.join(',')}")
      result = Net::HTTP.get(uri)
      data = JSON.parse(result)
      data.map do |movie_data|
        movie = Movie.new(movie_data)
        $redis.set("#{movie.id}_imdb_data", movie_data.to_json)
        movies << movie
      end
    end

    movies
  end

  def netflix_movie
    @netflix_movie ||= NetflixMovie.find_by_imdb_movie(self)
  end

  private

  def self.best_picture_winner_id(year)
    oscar_results_page = Nokogiri::HTML(open("http://www.imdb.com/event/ev0000003/#{year}"))
    awards_block = oscar_results_page.at_css('#main .award')
    return nil if awards_block.nil?
    winner_header = awards_block.at_css('h3')
    return nil unless winner_header.text.downcase == 'winner'
    best_picture_anchor_tag = winner_header.next_element.at_css('strong a')
    imdb_id_from_anchor_tag(best_picture_anchor_tag)
  end

  def self.imdb_id_from_anchor_tag(anchor_tag)
    anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/)
  end

  def self.imdb_ids_from_anchor_tags(anchor_tags)
    anchor_tags.map{ |anchor_tag| imdb_id_from_anchor_tag(anchor_tag) }
  end

end