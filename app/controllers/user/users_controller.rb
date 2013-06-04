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
		user = User.where(:id => params[:id]).joins(:posts).includes(:posts)
		render json: user.to_json( :only => [] , :methods => [:fullname] ,
									:include => { :posts => { :only => [ :title , :content, :receiver_id] } } )
	end

	def wall

		user = User.where(:id => params[:id]).joins(:wall_posts).includes(:wall_posts).order('posts.created_at DESC').limit(1)

		render json: user[0].to_json( :only => [:id , :image , :DOB , :created_at ], :methods => [:fullname] ,
									:include =>  { :wall_posts => { :order => 'created_at DESC',
										:include => { :sender => { :only => [ :id , :image ] , :methods => [:fullname] } },
										:only => [ :title , :created_at ] } } )
	end

	def search
		search_term = params[:q]
		result = User.where( "nume like ? OR prenume like ? ", "%#{search_term}%" , "%#{search_term}%")
		 			.select("nume, prenume, username, id")
		render json: result
	end

end