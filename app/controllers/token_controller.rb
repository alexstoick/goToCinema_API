class TokenController < ApplicationController

	def check
		if ( params[:token].nil? )
			redirect_to :action => "wrong_params"
			return
		end

		user = User.find_by_authToken ( params[:token] )
		if ( user.nil? )
			render :json => { "token" => false }
		else
			render :json => { "token" => true }
		end

	end
	def wrong_params
		render :json => { "error" => "Expecting a token parameter" }
	end
end
