namespace :cache do

  desc 'Caches the root action of this app'
  task :root => :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    app.get '/'
    cache = Dalli::Client.new
    cache.set('views/top250instant.herokuapp.com/index', app.response.body, 172800)
  end
end