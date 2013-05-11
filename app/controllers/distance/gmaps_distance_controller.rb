class Distance::GmapsDistanceController < ApplicationController

	def index

		if ! ( params.has_key?(:lat) && params.has_key?(:lng) )
			redirect_to :action => "wrong_params"
		else
			lat = params[:lat]
			lng = params[:lng]

			require 'net/http'
			require 'json'

			th = []
			i = 0

			entries = []

			start = Time.now

			urls = [
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.507402%2C26.090126&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.41956%2C26.126651&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.437716%2C26.069521&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.4346%2C26.096752&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.438216%2C26.114301&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.409052%2C26.086395&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.431445%2C26.053863&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.441101%2C26.099904&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.442391%2C26.099133&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.442391%2C26.099133&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.431445%2C26.053863&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.431445%2C26.053863&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.396106%2C26.123128&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.507058%2C26.090893&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.374388%2C26.119904&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.434266%2C26.102266&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.438216%2C26.114301&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.444685%2C26.097327&sensor=false'},
				{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.428742%2C26.15415&sensor=false'}
			]

			th = []
			i = 0
			urls.each do |u|
				th[i] =Thread.new do
					u['content'] = Net::HTTP.get( URI.parse(u['link']) )
					parsed = JSON.parse ( u['content'] )
					entry = {}

					entry["distance"] = parsed['rows'][0]['elements'][0]['distance']['text']
					entry["duration"] = parsed['rows'][0]['elements'][0]['duration']['value']
					entries.push( entry )
				end
				i=i+1
			end
			th.each { |t| t.join }
			encoded = JSON.generate ( entries )
			render :text => encoded
		end
	end

	def wrong_params
		render :text => "Wrong paramaters; expecting lat&lng params for request"
	end

end
