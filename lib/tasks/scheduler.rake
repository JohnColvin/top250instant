namespace :cache do

  desc 'Caches the root action of this app'
  task :root => :environment do
    cache = Dalli::Client.new

    # The app created below doesn't know its url. So, the cache creates one for example.com
    # Clear it out so we don't end up putting the example.com cache back in the cache
    cache.set('views/www.example.com/index', nil)

    app = ActionDispatch::Integration::Session.new(Rails.application)
    app.get '/'
    cache.set('views/top250instant.herokuapp.com/index', app.response.body, 172800)
  end
end