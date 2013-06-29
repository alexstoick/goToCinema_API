class CinemasController < ApplicationController

	def index

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
				{ 'lat' =>44.428742, 'lng' => 26.15415, 'name' =>'Gloria' },
				{'lat' => 44.434011, 'lng' => 26.096861, 'name' => 'Cinemateca Eforie' },
				{'lat' => 44.454662, 'lng' => 26.084064, 'name' => 'NCRR' },
				{'lat' => 44.446563, 'lng' => 26.104480, 'name' => 'Elvira Popescu' },
				{'lat' => 44.437159, 'lng' => 26.096134, 'name' => 'Cinemateca Union' },
				{'lat' => 44.434835, 'lng' => 26.094986, 'name' => 'Instituto Cervantes' }
			]
		render json: cinemas

	end
end