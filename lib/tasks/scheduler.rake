namespace :imdb_top_250 do

  desc 'Fetches the IMDB top 250, fills in netflix data and caches the top 250 page'
  task :update => [:environment, :fetch, 'netflix:fill', :rank]

  desc 'Fetch IMDB top 250'
  task :fetch => :environment do
    IMDB.top_250.each { |movie_attributes| Movie.find_or_create_by_imdb_id(movie_attributes) }
  end

  desc 'Rank the IMDB top 250'
  task :rank => :environment do
    Movie.update_all(imdb_ranking: nil)
    IMDB.top_250.each_with_index do |movie_attributes, i|
      movie = Movie.find_by_imdb_id(movie_attributes[:imdb_id])
      movie.imdb_ranking = i+1
      movie.save
    end
  end

end

namespace :netflix do

  desc 'Fills in movie that do not have netflix data'
  task :fill => :environment do
    Movie.where(netflix_instant: nil).each { |movie| movie.fill_from_netflix }
  end

  task :find_missing => :environment do
    Movie.where(netflix_api_url: nil).each do |movie|
      puts movie.title
      results = NetFlix::Title.search(term: movie.title, max_results: 4)
      results.find do |nf_title|
        print '  '
        puts nf_title.title
        print '  '
        puts "{ imdb_id: \"#{movie.imdb_id}\", netflix_api_url: \"#{nf_title.id}\", title: \"#{nf_title.title}\" },"
      end
    end
  end

end