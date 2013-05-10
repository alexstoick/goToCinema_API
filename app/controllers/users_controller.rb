class UsersController < ApplicationController
	def index
		@users = User.select( "username, email, nume, prenume" ).find ( :all )
		respond_to do |format|
			format.html { render :text => "nope"}
			format.json { render json: @users }
		end
	end

	def view
		@user = User.select( "username, email" ).find ( params[:id] )
		respond_to do |format|
			format.html { render :text => "nope"}
			format.json { render json: @user }
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			redirect_to @user, notice: 'User was successfully created.'
		end
	end

	def search
		#@user = User.where("nume like '?%' ", params[:nume])
		search_term = params[:nume]
		@user = User.where("name like ?", "%#{search_term}%")
		render json: @user
	end
end
