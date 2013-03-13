class BestPicture

  def self.winners
    Movie.destroy_all

    uri = URI.parse('http://www.oscars.org/awards/academyawards/legacy/best-pictures.html')
    winners_page = Net::HTTP.get(uri)
    winners_table = Nokogiri::HTML(winners_page).css('.films')

    winners_table.css('a').each do |doc|
      Movie.create! do |m|
        info = doc.text
        m.title             = info.match(/\"(.+)\"/)[1]
        m.best_picture_year = info.match(/(\d+)\s/).to_s
        m.release_year      = m.best_picture_year - 1
      end
    end
  end
end
