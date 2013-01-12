namespace :cache do

  desc 'Caches the root action of this app'
  task :root => :environment do
    app = ActionDispatch::Integration::Session.new(Rails.application)
    app.get '/'
    File.open(File.join(ActionController::Base.page_cache_directory, 'index.html'), 'w') { |f| f.write(app.response.body) }
  end
end