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

end