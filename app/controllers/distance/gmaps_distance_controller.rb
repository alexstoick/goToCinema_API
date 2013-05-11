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

			cinemas = [
				{ 'lat' =>44.507402, 'lng' => 26.090126, 'name' =>'Grand Cinema Digiplex' },
				{ 'lat' =>44.419560, 'lng' => 26.126651, 'name' =>'Hollywood Multiplex' },
				{ 'lat' =>44.437716, 'lng' => 26.069521, 'name' =>'Glendale Studio' },
				{ 'lat' =>44.434600, 'lng' => 26.096752, 'name' =>'Corso' },
				{ 'lat' =>44.438216, 'lng' => 26.114301, 'name' =>'Movieplex Cinema Plaza' },
				{ 'lat' =>44.409052, 'lng' => 26.086395, 'name' =>'The Light Cinema' },
				{ 'lat' =>44.431445, 'lng' => 26.053863, 'name' =>'Romtelecom IMAX' },
				{ 'lat' =>44.441101, 'lng' => 26.099904, 'name' =>'Scala' },
				{ 'lat' =>44.442391, 'lng' => 26.099133, 'name' =>'Patria' },
				{ 'lat' =>44.442391, 'lng' => 26.099133, 'name' =>'Caffe Cinema 3D Patria' },
				{ 'lat' =>44.431445, 'lng' => 26.053863, 'name' =>'Cinema City Cotroceni' },
				{ 'lat' =>44.431445, 'lng' => 26.053863, 'name' =>'Cinema City Cotroceni VIP' },
				{ 'lat' =>44.396106, 'lng' => 26.123128, 'name' =>'Cinema City Sun Plaza' },
				{ 'lat' =>44.507058, 'lng' => 26.090893, 'name' =>'Grand VIP Studios' },
				{ 'lat' =>44.374388, 'lng' => 26.119904, 'name' =>'Movie Vip Caffe' },
				{ 'lat' =>44.434266, 'lng' => 26.102266, 'name' =>'CinemaPRO' },
				{ 'lat' =>44.438216, 'lng' => 26.114301, 'name' =>'Europa' },
				{ 'lat' =>44.444685, 'lng' => 26.097327, 'name' =>'Studio' },
				{ 'lat' =>44.428742, 'lng' => 26.15415, 'name' =>'Gloria' }
			]
			linkOriginal = 'http://maps.googleapis.com/maps/api/distancematrix/json?sensor=false&origins='+lat+'%2C'+lng+'&destinations='

			cinemas.each do |cinema|
				th[i] =Thread.new do
					link = linkOriginal + cinema["lat"].to_s + "%2C" + cinema["lng"].to_s ;
					content = Net::HTTP.get( URI.parse(link) )
					parsed = JSON.parse ( content )
					entry = {}
					entry["name"] = cinema["name"]
					entry["distance"] = parsed['rows'][0]['elements'][0]['distance']['text']
					entry["duration"] = parsed['rows'][0]['elements'][0]['duration']['value']
					entry["lat"] = cinema["lat"]
					entry["lng"] = cinema["lng"]
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
