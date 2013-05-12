class User::PostsController < ApplicationController

	def create

		if params[:title].nil? or params[:content].nil? or params[:token].nil? or params[:receiver_id].nil?
			render :json => { "error" => "Wrong params" }
			return
		end

		auth_token = params[:token]
		user = User.find_by_authToken( auth_token )
		if ( user.nil? )
			render :json => { "error" => "Invalid authToken" }
			return
		end

		post = Post.new
		post.sender_id = user.id
		post.receiver_id = params[:receiver_id]
		post.title = params[:title]
		post.content = params[:content]
		post.save!

		render :json => { "ok" => post.new_record? }
	end

end