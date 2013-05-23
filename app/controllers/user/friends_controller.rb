class User::FriendsController < ApplicationController

	def friends
		friendships = User.find(params[:id]).friendships.accepted
		inverse_friendships = User.find(params[:id]).inverse_friendships.accepted

		friends = []

		friendships.each do |friendship|
			user = friendship.friend
			entry = {}
			entry [ "id" ] = user.id
			entry [ "image" ] = user.image
			entry [ "fullname" ] = user.fullname
			friends.push ( entry )
		end

		inverse_friendships.each do |friendship|
			user = friendship.user
			entry = {}
			entry [ "id" ] = user.id
			entry [ "image" ] = user.image
			entry [ "fullname" ] = user.fullname
			friends.push ( entry )
		end

		render json: friends
	end

	def pending

		friendships = User.find(params[:id]).friendships.pending
		inverse_friendships = User.find(params[:id]).inverse_friendships.pending

		pending = []

		friendships.each do |friendship|
			user = friendship.friend
			entry = {}
			entry [ "id" ] = user.id
			entry [ "image" ] = user.image
			entry [ "fullname" ] = user.fullname
			pending.push ( entry )
		end

		inverse_friendships.each do |friendship|
			user = friendship.user
			entry = {}
			entry [ "id" ] = user.id
			entry [ "image" ] = user.image
			entry [ "fullname" ] = user.fullname
			pending.push ( entry )
		end

		render json: pending
	end
end