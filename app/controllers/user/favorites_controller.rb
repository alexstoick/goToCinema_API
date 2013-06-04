class User::FavoritesController < ApplicationController

	def add

		movie_id = params[:movie_id]
		user_id = params[:id]

		user = User.find(user_id)

		if ( ! view_context.checkUser( user_id , params[:token] ) )
			render json: { "success" => "Wrong credentials"}
			return
		end

		list_id = user.lists[0].id

		if ( ListEntry.find_by_movie_id_and_list_id( movie_id , list_id ) )
			render json: { "success" => "Already exists" }
			return
		end

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

		if ( ! view_context.checkUser( user_id , params[:token] ) )
			render json: { "success" => "Wrong credentials"}
			return
		end

		list_id = user.lists[0].id

		entry = ListEntry.find_by_movie_id_and_list_id( movie_id , list_id )
		if ( ! entry.nil? && entry.delete )
			render json: { "success" => true }
		else
			render json: { "success" => false }
		end
	end

	def show
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
