class Movie
  attr_reader :title, :release_year, :storyline

  def initialize(data)
    @title = data['title']
    @release_year = data['year']
    @storyline = data['plot_simple']
  end

  def to_s
    "#{title} (#{release_year})"
  end

  def netflix_instant?
    netflix_title.present? && netflix_title.delivery_formats.include?('instant')
  end

  def netflix_page
    netflix_title.web_page
  end

  def box_art
    netflix_title.box_art['large']
  end

  def synopsis
    storyline
  end

  def self.top_250
    top_table = Nokogiri::HTML(open('http://www.imdb.com/chart/top')).css('div#main table')[1]
    top_table.children[0].remove #remove header row
    top_250_ids = imdb_ids_from_anchor_tags(top_table.children.map{ |row| row.at_css('td a') })
    fetch(top_250_ids)
  end

  def self.best_picture_winners
    best_picture_ids = (1929..Date.today.year).map{ |year| best_picture_winner_id(year) }.compact
    fetch(best_picture_ids)
  end

  def self.fetch(imdb_ids)
    imdb_ids.each_slice(10).map do |ids|
      uri = URI.parse("http://imdbapi.org?type=json&ids=#{ids.join(',')}")
      result = Net::HTTP.get(uri)
      data = JSON.parse(result)
      data.map{ |movie_data| Movie.new(movie_data) }
    end.flatten
  end

  def netflix_title
    @netflix_title ||= begin
      results = NetFlix::Title.search(term: title, max_results: 4)
      results.find{|nf_title| nf_title.title == title && nf_title.release_year.to_i == release_year}
   end
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