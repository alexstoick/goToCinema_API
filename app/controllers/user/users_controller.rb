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
		render json: user.to_json( :only => [] , :methods => [:fullname] ,
									:include => { :posts => { :only => [ :title , :content, :receiver_id] } } )
	end

	def wall
		user = User.find(params[:id])
		#:only => [ :nume , :prenume, :id],
		render json: user.to_json( :only => [:id], :methods => [:fullname] ,
									:include =>  { :wall_posts => {
										:include => { :sender => { :only => [] , :methods => [:fullname] } },
										:only => [ :title , :content ] } } )
	end

	def search
		search_term = params[:q]
		result = User.where( "nume like ? OR prenume like ? ", "%#{search_term}%" , "%#{search_term}%")
		 			.select("nume, prenume, username, id")
		render json: result
	end
end