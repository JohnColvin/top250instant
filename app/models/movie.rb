class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :length, :mpaa_rating, :netflix_api_url, :netflix_instant, :poster_url, :synopsis, :title
end
