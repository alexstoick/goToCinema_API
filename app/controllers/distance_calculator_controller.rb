class DistanceCalculatorController < ApplicationController
	def index

		if ! ( params.has_key?(:lat) && params.has_key?(:lng) )
			redirect_to :action => 'wrong_params'
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
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.507402%2C26.090126&sensor=false', 'name' => 'Grand Cinema Digiplex' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.419560%2C26.126651&sensor=false', 'name' => 'Hollywood Multiplex' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.437716%2C26.069521&sensor=false', 'name' => 'Glendale Studio' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.434600%2C26.096752&sensor=false', 'name' => 'Corso' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.438216%2C26.114301&sensor=false', 'name' => 'Movieplex Cinema Plaza' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.409052%2C26.086395&sensor=false', 'name' => 'The Light Cinema' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.431445%2C26.053863&sensor=false', 'name' => 'Romtelecom IMAX' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.441101%2C26.099904&sensor=false', 'name' => 'Scala' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.442391%2C26.099133&sensor=false', 'name' => 'Patria' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.442391%2C26.099133&sensor=false', 'name' => 'Caffe Cinema 3D Patria' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.431445%2C26.053863&sensor=false', 'name' => 'Cinema City Cotroceni' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.431445%2C26.053863&sensor=false', 'name' => 'Cinema City Cotroceni VIP' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.396106%2C26.123128&sensor=false', 'name' => 'Cinema City Sun Plaza' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.507058%2C26.090893&sensor=false', 'name' => 'Grand VIP Studios' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.374388%2C26.119904&sensor=false', 'name' => 'Movie Vip Caffe' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.434266%2C26.102266&sensor=false', 'name' => 'CinemaPRO' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.438216%2C26.114301&sensor=false', 'name' => 'Europa' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.444685%2C26.097327&sensor=false', 'name' => 'Studio' },
					{ 'link' => 'http://maps.googleapis.com/maps/api/distancematrix/json?origins='+lat+'%2C'+lng+'&destinations=44.428742%2C26.154150&sensor=false', 'name' => 'Gloria' }
			]

			# # Read JSON from a file, iterate over objects
			# file = open("places.json")
			# json = file.read

			# parsed = JSON.parse(json)

			# parsed["cinemas"].each do |shop|
			#   print shop["lat"] , " " , shop["lng"] , "\n"
			# end

			th = []
			i = 0
			urls.each do |u|
				th[i] =Thread.new do
					sleep 0.5
					u['content'] = Net::HTTP.get( URI.parse(u['link']) )
					parsed = JSON.parse ( u['content'] )
					entry = {}
					entry["name"] = u["name"] ;
					entry["distance"] = parsed['rows'][0]['elements'][0]['distance']['text']
					entry["duration"] = parsed['rows'][0]['elements'][0]['duration']['value']
					#puts entry
					entries.push( entry )

					if urls.all? {|u| u.has_key?("content") }
						fin = Time.now
						puts "Duration:                       " + (fin-start).to_s
					end
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
