# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [
  { imdb_id: "tt0080684", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60011114", title: "Star Wars: Episode V: The Empire Strikes Back" },
  { imdb_id: "tt0076759", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60010932", title: "Star Wars: Episode IV: A New Hope" },
  { imdb_id: "tt0114369", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/950149",   title: "Seven" },
  { imdb_id: "tt0082971", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60011649", title: "Indiana Jones and the Raiders of the Lost Ark" },
  { imdb_id: "tt0078788", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70124829", title: "Apocalypse Now / Apocalypse Now Redux" },
  { imdb_id: "tt0078748", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60029356", title: "Alien: Collector's Edition" },
  { imdb_id: "tt0090605", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60029358", title: "Aliens: Collector's Edition" },
  { imdb_id: "tt0910970", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70087540", title: "WALL-E" },
  { imdb_id: "tt0211915", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60022048", title: "Amelie" },
  { imdb_id: "tt0082096", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70189475", title: "Das Boot: Theatrical Cut" },
  { imdb_id: "tt0086190", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60010820", title: "Star Wars: Episode VI: Return of the Jedi" },
  { imdb_id: "tt0062622", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/207856",   title: "2001: A Space Odyssey" },
  { imdb_id: "tt0208092", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60003388", title: "Snatch" },
  { imdb_id: "tt0083658", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70082907", title: "Blade Runner: The Final Cut" }, 
  { imdb_id: "tt0079470", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/699257",   title: "Monty Python's Life of Brian" },
  { imdb_id: "tt0114746", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/17672318", title: "12 Monkeys" },
  { imdb_id: "tt0056801", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60021830", title: "8 1/2" },
  { imdb_id: "tt0047528", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60032448", title: "La Strada: Special Edition" },
  { imdb_id: "tt1201607", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70120085", title: "Harry Potter and the Deathly Hallows: Part II" },
  { imdb_id: "tt0087544", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/70019062", title: "Nausicaa of the Valley of the Wind" },
  { imdb_id: "tt0013442", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/812752",   title: "Nosferatu: Original Version" },
  { imdb_id: "tt0374546", netflix_api_url: "http://api-public.netflix.com/catalog/titles/movies/60036764", title: "Spring, Summer, Fall, Winter... and Spring" }
]

movies.each do |movie_attributes|
  if movie = Movie.find_by_imdb_id(movie_attributes[:imdb_id])
    movie.update_attribute(:netflix_api_url, movie_attributes[:netflix_api_url]) if movie.netflix_api_url.blank?
  else
    Movie.create(movie_attributes)
  end
end

