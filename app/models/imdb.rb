class IMDB

  def self.top_250
    uri = URI.parse('http://www.imdb.com/chart/top')
    top_250_page = Net::HTTP.get(uri)
    top_table = Nokogiri::HTML(top_250_page).css('div#main table')[1]
    top_table.children[0].remove #remove header row
    attributes_from_table_rows(top_table.children)
  end

  private

  def self.attributes_from_table_row(table_row)
    table_cell = table_row.css('td')[2]
    anchor_tag = table_cell.at_css('a')
    { imdb_id: anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/).to_s, title: anchor_tag.text, release_year: table_cell.text.match(/(\d{4})/).to_s }
  end

  def self.attributes_from_table_rows(table_rows)
    table_rows.map { |table_row| attributes_from_table_row(table_row) }
  end

end
