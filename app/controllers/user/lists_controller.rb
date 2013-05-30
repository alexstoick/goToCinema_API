class User::ListsController < ApplicationController

	def index
		user = User.find(params[:id])
		entries = []
		user.lists.each do |list|
			entry = {}
			entry [ "listName" ] = list["name"]
			entry [ "movies" ] = []
			list.movies.each do |movie|
				movieEntry = {}
				movieEntry [ "name" ] = movie [ "titluEn" ]
				movieEntry [ "id" ] = movie [ "id" ]
				entry [ "movies" ].push( movieEntry )
			end
			entries.push( entry )
		end
		render json: entries
	end

	def addFavorite

		movie_id = params[:id]
		user_id = session[:user_id]

		user = User.find(user_id)

		## have to check if it is the same user with authToken.

		list_id = user.lists[0].id

		entry = ListEntry.new
		entry.movie_id = movie_id
		entry.list_id = list_id
		entry.save!
		render json: { "success" => ! entry.new_record? }
	end

	def favorites
		user = User.find(params[:id])
		entries = []
		list = user.lists[0]

		list.movies.each do |movie|
			movieEntry = {}
			movieEntry [ "name" ] = movie [ "titluEn" ]
			movieEntry [ "image" ] = movie [ "image" ]
			movieEntry [ "id" ] = movie [ "id" ]
			entries.push( movieEntry )
		end

		render json: entries
	end

end