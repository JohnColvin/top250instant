# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [
  { imdb_id: "tt0080684", title: "Star Wars: Episode V: The Empire Strikes Back", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60011114" },
  { imdb_id: "tt0076759", title: "Star Wars: Episode IV: A New Hope", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60010932" }
]

movies.each do |movie_attributes|
  if movie = Movie.find_by_imdb_id(movie_attributes[:imdb_id])
    movie.update_attribute(:netflix_api_url, movie_attributes[:netflix_api_url]) if movie.netflix_api_url.blank?
  else
    Movie.create(movie_attributes)
  end
end