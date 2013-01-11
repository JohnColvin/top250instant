class Movie < ActiveResource::Base

  self.site = ENV['IMDB_API_URL']

end