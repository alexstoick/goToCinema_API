module FavoritesHelper

	def checkUser ( id , token )


		## have to check if it is the same user with authToken.

		user = User.find ( id )
		if ( user.authToken != params[:token] )
			return false
		end
		return true
	end
end