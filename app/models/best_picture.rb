class BestPicture
  DurationRegex = /\((\d{2,3})\smins\.\)$/

  def self.winners
    Movie.destroy_all

    uri = URI.parse('http://www.imdb.com/list/4KQwA3YMoDk/')
    winners_page = Net::HTTP.get(uri)
    winners_table = Nokogiri::HTML(winners_page).css('.list.detail')

    winners_table.css('.list_item').each do |doc|
      Movie.create! do |m|
        info           = doc.css('.info a').first
        title_url      = "http://www.imdb.com" + info.attr('href')
        synopsis       = doc.css('.item_description').first.content

        m.title        = info.content
        m.imdb_id      = title_url.match(/(tt\d+)/)[0]
        m.release_year = doc.css('.year_type').first.content[1..4]
        m.poster_url   = doc.css('.image img').attr('src').value
        m.length       = synopsis.match(DurationRegex)[1] rescue ''

        synopsis.gsub!(DurationRegex, '')
        synopsis.strip!

        m.synopsis = synopsis

        # WIP: Grab the rating
        # uri = URI.parse('http://www.imdb.com/list/4KQwA3YMoDk/')
        # winners_page = Net::HTTP.get(uri)
      end
    end
  end
end
