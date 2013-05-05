require 'bcrypt'

class SessionsController < ApplicationController

	include BCrypt

	def new
	end

	def create
		user = User.find_by_username( params[:username] )
		if ( user.nil? )
			render json: { "loggedIn" => false , "error" => "email" }
			return
		end
		if ( user && user.authenticate( params[:password] ) )
			session[:user_id] = user.id
			key = Password.create( params[:username]+params[:password] )
			render json: { "loggedIn" => true , "user_id" => user.id , "key" => key }
			user.authToken = key
			user.save!
		else
			render json: { "loggedIn" => false , "error" => "password" }
		end
	end

	def destroy
		render :text => "Successfully logout. NOT!"
	end
end

#$2a$10$J3vkiHpIlVpQOMw7s6C0Xu1SZprojTcfvcWQQP4WMOLG9crRW6/8a