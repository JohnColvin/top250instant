class NetflixMovie

  def self.find_by_imdb_movie(imdb_movie)
    if netflix_url = $redis.get(imdb_movie.id)
      data = NetFlix::Request.new(url: netflix_url).send
      TitleBuilder.from_xml(data).first
    else 
      results = NetFlix::Title.search(term: title, max_results: 4)
      match = results.find do |nf_title|
        nf_title.title.downcase == imdb_movie.title.downcase && nf_title.release_year.to_i == imdb_movie.release_year
      end
      $redis.set(id, match.id) if match
      match
    end
  end

end