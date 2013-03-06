class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :length, :mpaa_rating, :netflix_api_url, :netflix_instant, :poster_url, :synopsis, :title, :release_year

  def fill_from_netflix
    if netflix_api_url.blank?
      netflix_title = Netflix.find_by_title_and_release_year(title: title, release_year: release_year)
    else
      netflix_title = Netflix.fetch(netflix_api_url)
    end

    if netflix_title
      self[:title]           = netflix_title.title
      self[:release_year]    = netflix_title.release_year
      self[:netflix_api_url] = netflix_title.id
      self[:netflix_instant] = netflix_title.delivery_formats.include?('instant')
      self[:poster_url]      = netflix_title.box_art[:large]
      self[:length]          = netflix_title.runtime
      self[:mpaa_rating]     = netflix_title.mpaa_rating
      self[:synopsis]        = netflix_title.synopsis
      save
    end
  end

end
