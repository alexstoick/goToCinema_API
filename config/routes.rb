Simple::Application.routes.draw do

	root :to => 'distance_calculator#index'

	resources :movies

	get "parser/index"
	get "parser/early_reload"
	get "movie_list/index"
	get "distance_calculator/index"
	get "open_maps/index"
	get "gmaps_distance/index"
	get "distance_calculator/wrong_params"
	get "gmaps_distance/wrong_params"
	get "open_maps/wrong_params"

	match 'checkToken/', :to => "token#check"
	match 'logout/', :to => "sessions#destroy", :as => :logout
	match 'login/', :to => "sessions#create", :via => :post
	match 'login/', :to => "sessions#new", :as => :login
	match 'user/', :to => "users#create", :via => :post
	match 'user/', :to => "users#index", :as => :users
	match 'user/new', :to => "users#new", :as => :new_user
	match 'user/:id', :to => "users#view", :as => :user

	match "/parser" => "parser#index"
	match "/openMaps" => "open_maps#index"
	match "/googleMaps" => "gmaps_distance#index"
	match "/getMovies" => "movie_list#index"

	# The priority is based upon order of creation:
	# first created -> highest priority.

	# Sample of regular route:
	#   match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action

	# Sample of named route:
	#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)

	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Sample resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Sample resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Sample resource route with more complex sub-resources
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', :on => :collection
	#     end
	#   end

	# Sample resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	# root :to => 'welcome#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	#match ':controller(/:action(/:id))(.:format)'
end
