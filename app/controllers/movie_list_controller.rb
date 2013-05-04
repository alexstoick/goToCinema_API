class MovieListController < ApplicationController
	def index
		file = open ( "date.json" )
		content = file.read
		render :text => content
	end
end
