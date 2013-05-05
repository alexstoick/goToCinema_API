class UsersController < ApplicationController
	def index
		@users = User.all
		@users.delete_if {|hash| hash["id"] == session[:user_id]}
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @users }
		end
	end

	def view
		@user = User.find ( params[:id] )
		@user.authToken = nil
		@user.password_digest = nil
		respond_to do |format|
			format.html # view.html.erb
			format.json { render json: { "username" => @user.username , "email" => @user.email } }
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
