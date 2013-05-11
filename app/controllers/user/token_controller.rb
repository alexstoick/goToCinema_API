class User::TokenController < ApplicationController

	def check
		if ( params[:token].nil? )
			render :json => { "error" => "Expecting a token parameter" }
			return
		end

		user = User.find_by_authToken ( params[:token] )

		if ( user.nil? )
			render :json => { "token" => false }
		else
			render :json => { "token" => true }
		end

	end
end
