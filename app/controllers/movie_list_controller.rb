class MovieListController < ApplicationController
	def index

		content = Net::HTTP.get( URI.parse( 'http://parsercinema.eu01.aws.af.cm/date.json' ) )
		render :text => content

	end
end
