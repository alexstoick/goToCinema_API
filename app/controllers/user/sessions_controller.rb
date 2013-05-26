require 'bcrypt'

class User::SessionsController < ApplicationController

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
			response.headers["key"] = key
			render json: { "loggedIn" => true , "user_id" => user.id , "key" => key }
			user.authToken = key
			user.save!
		else
			render json: { "loggedIn" => false , "error" => "password" }
		end
	end

	def destroy

		if ( params[:token].nil? )
			render :json => { "error" => "Expecting a token parameter" }
			return
		end

		user = User.find_by_authToken( params[:token] )
		if ( user.nil? )
			render :json => { "error" => "Token does not exist" }
		else
			user.authToken = nil
			user.save!
			render :json => { "logout" => true }
		end
	end
end
