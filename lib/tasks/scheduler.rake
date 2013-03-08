namespace :cache do

  desc 'Caches the root action of this app'
  task :root => :environment do
    cache_path('/', 'index')
  end

  desc 'Caches the "best" action of this app'
  task :best => :environment do
    cache_path('/best', 'best')
  end

  def cache_path(path, name)
    cache = Dalli::Client.new

    # The app created below doesn't know its url. So, the cache creates one for example.com
    # Clear it out so we don't end up putting the example.com cache back in the cache
    cache.set("views/www.example.com/#{ name }", nil)

    app = ActionDispatch::Integration::Session.new(Rails.application)
    app.get path
    cache.set("views/top250instant.herokuapp.com/#{ name }", app.response.body, 172800)
  end

end

namespace :imdb_top_250 do

  desc 'Fetches the IMDB top 250, fills in netflix data and caches the top 250 page'
  task :update => [:environment, :fetch, 'netflix:fill', :rank, 'cache:root']

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