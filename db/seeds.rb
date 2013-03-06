# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [
  { imdb_id: "tt0080684", title: "Star Wars: Episode V: The Empire Strikes Back", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60011114" },
  { imdb_id: "tt0076759", title: "Star Wars: Episode IV: A New Hope", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60010932" },
  { imdb_id: "tt0114369", title: "Seven", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/950149" },
  { imdb_id: "tt0082971", title: "Indiana Jones and the Raiders of the Lost Ark", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60011649" },
  { imdb_id: "tt0078788", title: "Apocalypse Now / Apocalypse Now Redux", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70124829" },
  { imdb_id: "tt0078748", title: "Alien: Collector's Edition", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60029356" },
  { imdb_id: "tt0090605", title: "Aliens: Collector's Edition", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60029358" },
  { imdb_id: "tt0910970", title: "WALL-E", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70087540" },
  { imdb_id: "tt0211915", title: "Amelie", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60022048" },
  { imdb_id: "tt0082096", title: "Das Boot: Theatrical Cut", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70189475" },
  { imdb_id: "tt0086190", title: "Star Wars: Episode VI: Return of the Jedi", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60010820" },
  { imdb_id: "tt0062622", title: "2001: A Space Odyssey", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/207856" },
  { imdb_id: "tt0208092", title: "Snatch", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60003388" },
  { imdb_id: "tt0083658", title: "Blade Runner: The Final Cut", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70082907" },
  { imdb_id: "tt0079470", title: "Monty Python's Life of Brian", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/699257" },
  { imdb_id: "tt0114746", title: "12 Monkeys", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/17672318" },
  { imdb_id: "tt0056801", title: "8 1/2", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60021830" },
  { imdb_id: "tt0047528", title: "La Strada: Special Edition", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60032448" },
  { imdb_id: "tt1201607", title: "Harry Potter and the Deathly Hallows: Part II", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70120085" },
  { imdb_id: "tt0087544", title: "Nausicaa of the Valley of the Wind", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70019062" },
  { imdb_id: "tt0013442", title: "Nosferatu: Original Version", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/812752" },
  { imdb_id: "tt0374546", title: "Spring, Summer, Fall, Winter... and Spring", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60036764" }
]

movies.each do |movie_attributes|
  if movie = Movie.find_by_imdb_id(movie_attributes[:imdb_id])
    movie.update_attribute(:netflix_api_url, movie_attributes[:netflix_api_url]) if movie.netflix_api_url.blank?
  else
    Movie.create(movie_attributes)
  end
end