class Netflix

  def self.find_by_title_and_release_year(attributes)
    results = NetFlix::Title.search(term: attributes[:title], max_results: 4, expand: 'synopsis')
    results.find do |nf_title|
      nf_title.title.downcase == attributes[:title].downcase && nf_title.release_year.to_i == attributes[:release_year].to_i
    end
  end

  def self.fetch(netflix_api_url)
    data = NetFlix::Request.new(url: netflix_api_url, parameters: { expand: 'synopsis' }).send
    TitleBuilder.from_xml(data).first
  end

end