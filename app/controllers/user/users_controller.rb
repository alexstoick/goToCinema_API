class User::UsersController < ApplicationController
	def index
		users = User.select( "username, email, nume, prenume, id" ).find ( :all )
		render json: users

	end

	def view
		user = User.select( "username, email, nume, prenume, image, DOB" ).find ( params[:id] )
		render json: user
	end

	def posts
		user = User.find(params[:id])
		render json: user.posts.select("title, content, receiver_id")
	end
	def wall
		user = User.find(params[:id])
		json = []
		user.wall_posts.each do |post|
			sender = post.sender
			entry = {}
			entry [ "sender_name" ] = sender["nume"] + " " + sender["prenume"]
			entry [ "sender_id" ] = sender["id"]
			entry [ "content" ] = post.content
			entry [ "title" ] = post.title
			json.push ( entry )
		end
		render json: json
	end

	def search
		search_term = params[:q]
		result = User.where( "nume like ? OR prenume like ? ", "%#{search_term}%" , "%#{search_term}%")
		 			.select("nume, prenume, username, id")
		render json: result
	end
end
