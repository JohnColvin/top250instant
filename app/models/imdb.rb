class IMDB

  def self.top_250
    uri = URI.parse('http://www.imdb.com/chart/top')
    top_250_page = Net::HTTP.get(uri)
    top_table = Nokogiri::HTML(top_250_page).css('div#main table')[1]
    top_table.children[0].remove #remove header row
    imdb_ids_and_titles_from_anchor_tags(top_table.children.map{ |row| row.at_css('td a') })
  end

  private

  def self.imdb_id_and_title_from_anchor_tag(anchor_tag)
    { imdb_id: anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/).to_s, title: anchor_tag.text }
  end

  def self.imdb_ids_and_titles_from_anchor_tags(anchor_tags)
    anchor_tags.map do |anchor_tag|
      imdb_id_and_title_from_anchor_tag(anchor_tag)
    end
  end

end