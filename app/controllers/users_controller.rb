class UsersController < ApplicationController
	def index
		@users = User.select( "username, email" ).find ( :all )
		@users.delete_if {|hash| hash["id"] == session[:user_id]}
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
end
