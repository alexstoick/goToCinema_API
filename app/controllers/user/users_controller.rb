class User::UsersController < ApplicationController
	def index
		users = User.select( "username, email, nume, prenume, id" ).find ( :all )
		render json: users

	end

	def view
		user = User.select( "username, email" ).find ( params[:id] )
		render json: user
	end

	def posts
		user = User.find(params[:id])
		render json: user.posts.select("title, content")
	end

	def search
		search_term = params[:q]
		result = User.where( "nume like ? OR prenume like ? ", "%#{search_term}%" , "%#{search_term}%")
		 			.select("nume, prenume, username, id")
		render json: result
	end
end
