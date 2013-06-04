Simple::Application.routes.draw do

	root :to => 'movies#index'

	match 'movies/', :to => "movies#index"
	match 'movies/:id', :to => "movies#show"
	match 'movies/:id/aparitii', :to => "movies#aparitii"


	get "parser/early_reload"

	match "/parser" => "parser#index"

	namespace :user do

		match 'checkToken/', :to => "token#check"

		match 'logout/', :to => "sessions#destroy"
		match 'login/', :to => "sessions#create", :via => :post
		match '/post', :to => "posts#create", :via => :post

		match '/search', :to => "users#search"
		match '/', :to => "users#index"
		match '/:id', :to => "users#view"
		match '/:id/posts', :to => "users#posts"
		match '/:id/wall', :to => "users#wall"
		match '/:id/friends', :to => "friends#friends"
		match '/:id/pending', :to => "friends#pending"
		match '/:id/lists' , :to => "lists#index"
		match '/:id/favorites', :to => "favorites#add", :via => :post
		match '/:id/favorites', :to => "favorites#remove", :via => :delete
		match '/:id/favorites' , :to => "favorites#show"
	end


	namespace :distance do

		match "/openMaps" => "open_maps#index"
		match "/googleMaps" => "gmaps_distance#index"
		match "/" => "distance_calculator#index"

		get "distance_calculator/wrong_params"
		get "gmaps_distance/wrong_params"
		get "open_maps/wrong_params"
	end

end
