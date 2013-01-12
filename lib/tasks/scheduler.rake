task :expire_cache => :environment do
  cached_page_path = File.join(ActionController::Base.page_cache_directory, 'index.html')

  if File.exists?(cached_page_path)
    cached_page = Pathname.new cached_page_path
    cached_page.unlink if cached_page.mtime < 1.day.ago
  end
end