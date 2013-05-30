class User::FavoritesController < ApplicationController

	def add

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

	def remove
		movie_id = params[:movie_id]
		user_id = params[:id]

		user = User.find(user_id)

		## have to check if it is the same user with authToken.

		list_id = user.lists[0].id

		entry = ListEntry.find_by_movie_id_and_list_id( movie_id , list_id ) ;
		if ( ! entry.nil? && entry.delete )
			render json: { "success" => true }
		else
			render json: { "success" => false }
		end
	end

end