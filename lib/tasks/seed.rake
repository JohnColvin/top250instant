namespace :db do

  desc 'Seeds redis'
  task seed: :environment do
    ids = { 'tt0060196' => 'http://api-public.netflix.com/catalog/titles/movies/553500' }
    ids.each { |imdb_id, netflix_id| $redis.set(imdb_id, netflix_id) if $redis.get(imdb_id).blank? }
  end
end