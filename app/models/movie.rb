class Movie < ActiveResource::Base

  self.site = ENV['IMDB_API_URL']

  def to_s
    "#{title} (#{release_year})"
  end

  def netflix_instant?
    netflix_title.present? && netflix_title.delivery_formats.include?('instant')
  end

  def netflix_page
    netflix_title.web_page
  end

  private

  def netflix_title
    @netflix_title ||= begin
      results = NetFlix::Title.search(term: title, max_results: 10)
      results.find{|nf_title| nf_title.title == title && nf_title.release_year == release_year}
   end
  end

end
