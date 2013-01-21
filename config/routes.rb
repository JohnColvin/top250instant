Top250instant::Application.routes.draw do

  root to: 'movies#index'
  get 'best' => 'movies#best'

end
