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
		render json: user.to_json( :only => [:id , :image , :fullname ], :methods => [:fullname] ,
									:include =>  { :wall_posts => {
										:include => { :sender => { :only => [ :id , :image ] , :methods => [:fullname] } },
										:only => [ :title , :content ] } } )
	end

	def search
		search_term = params[:q]
		result = User.where( "nume like ? OR prenume like ? ", "%#{search_term}%" , "%#{search_term}%")
		 			.select("nume, prenume, username, id")
		render json: result
	end


	def friends
		user = User.find(params[:id])

		render json: user.to_json( :only => [] , :methods => [:fullname] ,
									:include => [
										{ :friends => { :only => [ :id , :image ] , :methods => [:fullname] } },
										{ :inverse_friends => { :only => [ :id , :image ] , :methods => [:fullname] } }
										] )
	end

	def pending

		user = User.find(params[:id])
		pending = user.friendships.pending
		render json: pending.to_json( :only => [] ,
								:include => { :friend => { :only => [ :id, :image] , :methods => [:fullname] } } )
	end

end